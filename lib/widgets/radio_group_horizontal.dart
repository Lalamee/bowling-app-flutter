import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class RadioGroupHorizontal extends StatelessWidget {
  final List<String> options;
  final String? groupValue;
  final void Function(String?) onChanged;

  const RadioGroupHorizontal({
    Key? key,
    required this.options,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: options.map((label) {
        final isSelected = label == groupValue;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: InkWell(
            onTap: () => onChanged(label),
            borderRadius: BorderRadius.circular(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: isSelected
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        )
                      : BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                ),
                Container(
                  width: 113,
                  height: 29,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.grey,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    label,
                    style: AppTextStyles.formInput.copyWith(
                      color: isSelected ? AppColors.primary : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
