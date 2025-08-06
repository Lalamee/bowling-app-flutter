import 'package:flutter/material.dart';
import '../theme/text_styles.dart';
import '../theme/colors.dart';
import 'custom_button.dart';

Widget formStepTitle(String text) {
  return Text(
    text,
    style: AppTextStyles.mainWelcomeTitle,
  );
}

Widget sectionTitle(String text) {
  return Text(
    text,
    style: AppTextStyles.sectionTitle,
  );
}

Widget formDescription(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      text,
      style: AppTextStyles.onboardingSubtitle,
    ),
  );
}

Widget stepNavigationButton(String text, VoidCallback onPressed) {
  return SizedBox(
    width: double.infinity,
    height: 65,
    child: CustomButton(text: text, onPressed: onPressed),
  );
}
