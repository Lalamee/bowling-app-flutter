import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const TextStyle onboardingTitle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    fontSize: 28,
    height: 30 / 28,
    letterSpacing: -0.02 * 28,
    color: AppColors.textDark,
  );

  static const TextStyle onboardingSubtitle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w300,
    fontSize: 20,
    height: 30 / 20,
    letterSpacing: -0.02 * 20,
    color: AppColors.textDark,
  );
}
