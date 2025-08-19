import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';

class StockSearchSheet extends StatefulWidget {
  const StockSearchSheet({Key? key}) : super(key: key);

  @override
  State<StockSearchSheet> createState() => _StockSearchSheetState();
}

class _StockSearchSheetState extends State<StockSearchSheet> {
  final _queryCtrl = TextEditingController();
  final List<String> _all = const [
    'Пинспоттер',
    'Рама пинсколеса пинспоттера',
    'Пин-колесо - четный пинспоттер',
    'Направляющий рельс - нечетный пинспоттер',
    'Черный пинспоттер',
    'Передний вал',
    'Профиль крепежный',
  ];

  @override
  void dispose() {
    _queryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _all.where((e) => e.toLowerCase().contains(_queryCtrl.text.toLowerCase())).toList();
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 44,
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 44,
            child: TextField(
              controller: _queryCtrl,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Поиск по складу',
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.refresh, color: AppColors.primary),
                  onPressed: () => setState(() {}),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                final isAccent = i == 0;
                return InkWell(
                  onTap: () => Navigator.pop(context, filtered[i]),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 44,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isAccent ? AppColors.primary : AppColors.lightGray,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            filtered[i],
                            style: const TextStyle(fontSize: 14, color: AppColors.textDark),
                          ),
                        ),
                        if (isAccent) const Icon(Icons.edit, size: 16, color: AppColors.primary),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
