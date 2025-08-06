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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: options.map((label) {
        final isSelected = label == groupValue;
        return Expanded(
          child: InkWell(
            onTap: () => onChanged(label),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? AppColors.primary : Colors.grey,
                        width: 2,
                      ),
                      color: isSelected ? AppColors.primary : Colors.transparent,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 29,
                    decoration: BoxDecoration(
                      border: Border.all(color: isSelected ? AppColors.primary : Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(label, style: AppTextStyles.formInput),
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