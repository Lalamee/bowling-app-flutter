import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../shared/widgets/nav/app_bottom_nav.dart';
import '../../../../shared/widgets/layout/common_ui.dart';
import '../widgets/lane_card.dart';
import '../widgets/position_card.dart';
import '../../../../core/utils/bottom_nav.dart';
import 'club_search_screen.dart';
import '../../../../shared/widgets/inputs/adaptive_text.dart';

class ClubWarehouseScreen extends StatefulWidget {
  const ClubWarehouseScreen({Key? key}) : super(key: key);

  @override
  State<ClubWarehouseScreen> createState() => _ClubWarehouseScreenState();
}

class _ClubWarehouseScreenState extends State<ClubWarehouseScreen> {
  final _cellCtrl = TextEditingController(text: '25');
  final _shelfCtrl = TextEditingController(text: '2');
  final _markCtrl = TextEditingController(text: 'справа от входа стеллаж');
  String _selectedItem = 'Пинспоттер';
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _cellCtrl.dispose();
    _shelfCtrl.dispose();
    _markCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _openSearchOverlay() async {
    final res = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => ClubSearchScreen(query: _searchCtrl.text)),
    );
    if (res != null && res.isNotEmpty) {
      setState(() {
        _selectedItem = res;
        _searchCtrl.text = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            Row(
              children: [
                const Text('Склад', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.sync, color: AppColors.primary)),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.primary, width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchCtrl,
                      readOnly: true,
                      onTap: _openSearchOverlay,
                      decoration: const InputDecoration(
                        hintText: 'Поиск',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(onPressed: _openSearchOverlay, icon: const Icon(Icons.search, color: AppColors.primary)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            CommonUI.card(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  LaneCard(
                    title: 'Дорожка №1',
                    initiallyOpen: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PositionCard(
                          selected: true,
                          title: _selectedItem,
                          onEdit: _openSearchOverlay,
                          cellCtrl: _cellCtrl,
                          shelfCtrl: _shelfCtrl,
                          markCtrl: _markCtrl,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFEDEDED), width: 1.5),
                          ),
                          alignment: Alignment.centerLeft,
                          child: const AdaptiveText(
                            'Черный пинспоттер',
                            style: TextStyle(fontSize: 14, color: AppColors.textDark, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFEDEDED), width: 1.5),
                          ),
                          alignment: Alignment.centerLeft,
                          child: const AdaptiveText(
                            'Передний вал',
                            style: TextStyle(fontSize: 14, color: AppColors.textDark, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFEDEDED), width: 1.5),
                          ),
                          alignment: Alignment.centerLeft,
                          child: const AdaptiveText(
                            'Профиль крепежный',
                            style: TextStyle(fontSize: 14, color: AppColors.textDark, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const LaneCard(title: 'Дорожка №2'),
                  const LaneCard(title: 'Дорожка №3'),
                  const LaneCard(title: 'Дорожка №4'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 2,
        onTap: (i) => BottomNavDirect.go(context, 2, i),
      ),
    );
  }
}
