import 'package:flutter/material.dart';

class RadioGroupVertical extends StatelessWidget {
  final List<String> options;
  final String? groupValue;
  final void Function(String?) onChanged;

  const RadioGroupVertical({
    Key? key,
    required this.options,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((label) {
        final isSelected = label == groupValue;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: GestureDetector(
            onTap: () => onChanged(label),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? const Color(0xFF8A002D) : Colors.grey,
                      width: 2,
                    ),
                    color: isSelected ? const Color(0xFF8A002D) : Colors.transparent,
                  ),
                ),
                Container(
                  height: 29,
                  constraints: const BoxConstraints(minWidth: 75),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF8A002D) : Colors.grey.shade400,
                    ),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? const Color(0xFF8A002D) : Colors.grey[700],
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
