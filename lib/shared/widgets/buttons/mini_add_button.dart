import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class MiniAddButton extends StatelessWidget {
  final VoidCallback onTap;

  const MiniAddButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.lightGray),
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.add, color: AppColors.primary, size: 18),
      ),
    );
  }
}
