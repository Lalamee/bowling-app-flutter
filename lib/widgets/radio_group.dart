import 'package:flutter/material.dart';

class RadioGroup extends StatelessWidget {
  final List<String> options;
  final String? groupValue;
  final void Function(String?) onChanged;

  const RadioGroup({
    Key? key,
    required this.options,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.map((label) {
        return Expanded(
          child: Row(
            children: [
              Radio<String>(
                value: label,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: const Color(0xFF8A002D), // AppColors.primary
              ),
              Text(label),
            ],
          ),
        );
      }).toList(),
    );
  }
}
