import 'dart:io';

Future<String> runCmd(List<String> cmd, {String? cwd}) async {
  var pr = await Process.run(cmd.first, cmd.sublist(1), workingDirectory: cwd, runInShell: true);
  var out = (pr.stdout ?? '').toString();
  var err = (pr.stderr ?? '').toString();
  return [out, err].where((s) => s.trim().isNotEmpty).join('\n');
}

String ts() {
  final d = DateTime.now();
  String two(int n) => n.toString().padLeft(2, '0');
  return '${d.year}${two(d.month)}${two(d.day)}_${two(d.hour)}${two(d.minute)}${two(d.second)}';
}

String readIfExists(String path) {
  final f = File(path);
  if (f.existsSync()) return f.readAsStringSync();
  return '';
}

List<String> findLines(String path, RegExp re) {
  final f = File(path);
  if (!f.existsSync()) return [];
  return f.readAsLinesSync().where((l) => re.hasMatch(l)).toList();
}

Future<void> main() async {
  final outPath = 'env_report_${ts()}.md';
  final sink = File(outPath).openWrite();

  sink.writeln('# Flutter');
  sink.writeln(await runCmd(['flutter', '--version']));
  sink.writeln(await runCmd(['flutter', 'doctor', '-v']));
  sink.writeln(await runCmd(['dart', '--version']));

  sink.writeln('# Java');
  sink.writeln(await runCmd(['java', '-version']));

  sink.writeln('# Env');
  sink.writeln('ANDROID_HOME=${Platform.environment['ANDROID_HOME'] ?? ''}');
  sink.writeln('ANDROID_SDK_ROOT=${Platform.environment['ANDROID_SDK_ROOT'] ?? ''}');
  sink.writeln('JAVA_HOME=${Platform.environment['JAVA_HOME'] ?? ''}');

  sink.writeln('# Git');
  sink.writeln((await runCmd(['git', 'rev-parse', '--short', 'HEAD'])).trim());

  sink.writeln('# Android/Gradle');
  final androidDir = Directory('android');
  if (androidDir.existsSync()) {
    final gradlew = Platform.isWindows ? 'gradlew.bat' : './gradlew';
    sink.writeln(await runCmd([gradlew, '-v'], cwd: 'android'));

    sink.writeln('## gradle-wrapper.properties');
    sink.writeln(readIfExists('android/gradle/wrapper/gradle-wrapper.properties'));

    sink.writeln('## local.properties');
    final lp = readIfExists('android/local.properties');
    sink.writeln(lp.isEmpty ? '' : lp);

    sink.writeln('## SDK numbers');
    final re = RegExp(r'(compileSdk|targetSdk|minSdk|ndkVersion)');
    final candidates = [
      'android/app/build.gradle',
      'android/app/build.gradle.kts',
      'android/build.gradle',
      'android/build.gradle.kts'
    ];
    for (final p in candidates) {
      final lines = findLines(p, re);
      if (lines.isNotEmpty) {
        sink.writeln('### $p');
        for (final l in lines) sink.writeln(l);
      }
    }
  }

  sink.writeln('# sdkmanager --list (top)');
  try {
    final list = await runCmd(['sdkmanager', '--list']);
    final lines = list.split('\n');
    final top = lines.take(200).join('\n');
    sink.writeln(top);
  } catch (_) {}

  await sink.flush();
  await sink.close();
  stdout.writeln(outPath);
}
