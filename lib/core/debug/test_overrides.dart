import 'package:flutter/foundation.dart';

class TestOverrides {
  static const forceFirstRun = bool.fromEnvironment('FORCE_FIRST_RUN', defaultValue: false);
  static const forceSecondRun = bool.fromEnvironment('FORCE_SECOND_RUN', defaultValue: false);
  static const forceLoggedIn = bool.fromEnvironment('FORCE_LOGGED_IN', defaultValue: false);
  static const forceLoggedOut = bool.fromEnvironment('FORCE_LOGGED_OUT', defaultValue: false);
  static const forceRole = String.fromEnvironment('FORCE_ROLE', defaultValue: '');
  static const forceSplashVariant = String.fromEnvironment('FORCE_SPLASH', defaultValue: '');

  static bool get enabled => kDebugMode && (
      forceFirstRun || forceSecondRun || forceLoggedIn || forceLoggedOut || forceRole.isNotEmpty || forceSplashVariant.isNotEmpty
  );
}
