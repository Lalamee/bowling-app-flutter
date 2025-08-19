import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography_extension.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;

  const CustomButton({
    required this.text,
    this.onPressed,
    this.isOutlined = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isOutlined ? _buildOutlined(context) : _buildFilled(context);
  }

  Widget _buildOutlined(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        foregroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        backgroundColor: AppColors.white,
      ),
      child: Text(
        text,
        style: context.typo.formLabel.copyWith(color: AppColors.primary),
      ),
    );
  }

  Widget _buildFilled(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shadowColor: AppColors.shadowSoft,
        elevation: 1,
      ),
      child: Text(
        text,
        style: context.typo.formLabel.copyWith(color: AppColors.white),
      ),
    );
  }
}
