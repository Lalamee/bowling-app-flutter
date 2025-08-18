import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routing/routes.dart';
import '../debug/test_overrides.dart';

class AppInitService {
  Future<void> boot(BuildContext context) async {
    var navigated = false;

    void go(String r) {
      if (navigated || !context.mounted) return;
      navigated = true;
      Navigator.pushReplacementNamed(context, r);
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (!navigated && context.mounted) go(Routes.welcome);
    });

    try {
      final sp = await SharedPreferences.getInstance();

      if (TestOverrides.enabled) {
        if (TestOverrides.forceFirstRun) await sp.setBool('first_run_done', false);
        if (TestOverrides.forceSecondRun) await sp.setBool('first_run_done', true);
        if (TestOverrides.forceLoggedIn) await sp.setBool('logged_in', true);
        if (TestOverrides.forceLoggedOut) await sp.setBool('logged_in', false);
        if (TestOverrides.forceRole.isNotEmpty) await sp.setString('user_role', TestOverrides.forceRole);
      }

      final firstRunDone = sp.getBool('first_run_done') ?? false;
      final loggedIn = sp.getBool('logged_in') ?? false;
      final role = sp.getString('user_role') ?? 'mechanic';

      if (!firstRunDone) {
        go(Routes.splashFirstTime);
        return;
      }
      if (loggedIn) {
        go(role == 'owner' ? Routes.club : Routes.profileMechanic);
        return;
      }
      go(Routes.welcome);
    } catch (e, st) {
      if (kDebugMode) debugPrint('AppInitService error: $e\n$st');
      go(Routes.welcome);
    }
  }

  static Future<void> completeOnboarding(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('first_run_done', true);
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, Routes.welcome);
  }
}
