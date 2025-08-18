import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import 'common_ui.dart';

class SectionList extends StatelessWidget {
  final List<String> items;
  final int selected;
  final ValueChanged<int> onSelect;

  const SectionList({
    Key? key,
    required this.items,
    required this.selected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonUI.card(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: List.generate(items.length, (i) {
          final isActive = i == selected;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: InkWell(
              onTap: () => onSelect(i),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: isActive ? AppColors.primary : AppColors.lightGray, width: 1.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Text(
                      items[i],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isActive ? AppColors.textDark : AppColors.darkGray,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.keyboard_arrow_down, color: isActive ? AppColors.primary : AppColors.darkGray),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
