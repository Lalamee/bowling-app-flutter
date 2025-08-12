import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/profile_tile.dart';
import '../models/mechanic_profile.dart';
import 'edit_mechanic_profile_screen.dart';
import '../widgets/app_bottom_nav.dart';
import 'orders/orders_screen.dart';

enum EditFocus { none, name, phone, address }

class MechanicProfileScreen extends StatefulWidget {
  const MechanicProfileScreen({Key? key}) : super(key: key);

  @override
  State<MechanicProfileScreen> createState() => _MechanicProfileScreenState();
}

class _MechanicProfileScreenState extends State<MechanicProfileScreen> {
  late MechanicProfile profile;

  @override
  void initState() {
    super.initState();
    profile = MechanicProfile(
      fullName: 'Механик Иван Иванович',
      phone: '+7 (980) 001-01-01',
      clubName: 'Боулинг клуб "Кегли"',
      clubs: ['Боулинг клуб "Кегли"'],
      address: 'г. Воронеж, ул. Тверская, д. 45',
      workplaceVerified: false,
      birthDate: DateTime(1989, 2, 24),
      status: 'Самозанятый',
    );
  }

  Future<void> _openEdit(EditFocus focus) async {
    final updated = await Navigator.push<MechanicProfile>(
      context,
      MaterialPageRoute(
        builder: (_) => EditMechanicProfileScreen(
          initial: profile,
          focus: focus,
        ),
      ),
    );
    if (updated != null) {
      setState(() => profile = updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F9),
        elevation: 0,
        title: const Text(
          'Личный кабинет',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF1C1C1E)),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sync),
            color: AppColors.primary,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: [
          ProfileTile(
            icon: Icons.person,
            text: profile.fullName,
            onEdit: () => _openEdit(EditFocus.name),
          ),
          const SizedBox(height: 10),
          ProfileTile(
            icon: Icons.phone,
            text: profile.phone,
            onEdit: () => _openEdit(EditFocus.phone),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE9E9E9)),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  width: 34, height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.badge_outlined, size: 18, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Статус:',
                  style: TextStyle(fontSize: 14, color: Color(0xFF6B6B6B)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    profile.status,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ProfileTile(
            icon: Icons.menu_book_rounded,
            text: 'База знаний',
            onTap: () {},
          ),
          const SizedBox(height: 10),
          ...List.generate(profile.clubs.length, (i) {
            final club = profile.clubs[i];
            return Padding(
              padding: EdgeInsets.only(bottom: i == profile.clubs.length - 1 ? 0 : 10),
              child: ProfileTile(
                icon: Icons.location_searching_rounded,
                text: club,
                showAlertBadge: !profile.workplaceVerified && i == 0,
                onTap: () => _openEdit(EditFocus.none),
              ),
            );
          }),
          const SizedBox(height: 10),
          ProfileTile(
            icon: Icons.location_on_rounded,
            text: profile.address,
            onEdit: () => _openEdit(EditFocus.address),
          ),
          const SizedBox(height: 10),
          ProfileTile(
            icon: Icons.history_rounded,
            text: 'История заказов',
            onTap: () {},
          ),
          const SizedBox(height: 10),
          ProfileTile(
            icon: Icons.notifications_active_outlined,
            text: 'Оповещения',
            onTap: () {},
          ),
          const SizedBox(height: 10),
          ProfileTile(
            icon: Icons.star_border_rounded,
            text: 'Избранные заказы/детали',
            onTap: () {},
          ),
          const SizedBox(height: 10),
          ProfileTile(
            icon: Icons.exit_to_app_rounded,
            text: 'Выход',
            danger: true,
            onTap: () {},
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 3,
        onTap: (i) {
          if (i == 3) return;
          if (i == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OrdersScreen()));
          }
        },
      ),
    );
  }
}
