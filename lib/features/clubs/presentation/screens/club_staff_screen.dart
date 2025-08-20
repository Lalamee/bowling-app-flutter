import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../shared/widgets/chips/radio_group_horizontal.dart';
import '../../../../shared/widgets/nav/app_bottom_nav.dart' as nav;
import '../../../../core/routing/routes.dart';

class ClubStaffScreen extends StatefulWidget {
  const ClubStaffScreen({Key? key}) : super(key: key);

  @override
  State<ClubStaffScreen> createState() => _ClubStaffScreenState();
}

class _ClubStaffScreenState extends State<ClubStaffScreen> {
  int _navIndex = 3;

  final List<_Employee> _employees = [
    _Employee(
      fio: 'Менеджер Иван Иванович',
      workplaces: ['Боулинг клуб "Кегли"'],
      address: 'г. Воронеж, ул. Тверская, д. 45',
      phone: '+7 (980) 001 01 01',
      role: 'Менеджер',
    ),
  ];

  InputDecoration _dec({String? hint, Color? fill, bool enabled = true}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      enabled: enabled,
      fillColor: fill ?? AppColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.lightGray),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.lightGray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
      ),
    );
  }

  Future<void> _openAssignSheet() async {
    final result = await showModalBottomSheet<_Employee>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AssignEmployeeSheet(dec: _dec),
    );
    if (result != null) {
      setState(() => _employees.add(result));
    }
  }

  void _onNavTap(int i) {
    if (_navIndex == i) return;
    setState(() => _navIndex = i);
    switch (i) {
      case 0:
        Navigator.pushReplacementNamed(context, Routes.orders);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, Routes.clubSearch);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, Routes.club);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, Routes.profileMechanic); // если будет профиль владельца — заменишь
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textDark),
        ),
        title: const Text('Сотрудники клуба', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        centerTitle: false,
      ),
      bottomNavigationBar: nav.AppBottomNav(currentIndex: _navIndex, onTap: _onNavTap),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _openAssignSheet,
              icon: const Icon(Icons.add),
              label: const Text('Назначить сотрудника'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGray,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ..._employees.map((e) => _EmployeeCard(employee: e, dec: _dec, onDelete: () => setState(() => _employees.remove(e)))),
        ],
      ),
    );
  }
}

class _Employee {
  final String fio;
  final List<String> workplaces;
  final String address;
  final String phone;
  final String role;

  _Employee({
    required this.fio,
    required this.workplaces,
    required this.address,
    required this.phone,
    required this.role,
  });
}

class _EmployeeCard extends StatelessWidget {
  final _Employee employee;
  final InputDecoration Function({String? hint, Color? fill, bool enabled}) dec;
  final VoidCallback onDelete;

  const _EmployeeCard({Key? key, required this.employee, required this.dec, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(decoration: dec(enabled: false), controller: TextEditingController(text: employee.fio), enabled: false),
            const SizedBox(height: 10),
            ...employee.workplaces.map((w) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(decoration: dec(enabled: false), controller: TextEditingController(text: w), enabled: false),
            )),
            TextField(decoration: dec(enabled: false), controller: TextEditingController(text: employee.address), enabled: false),
            const SizedBox(height: 10),
            TextField(decoration: dec(fill: const Color(0xFFF0DADF), enabled: false), controller: TextEditingController(text: employee.phone), enabled: false),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: RadioGroupHorizontal(
                options: const ['Менеджер', 'Механик'],
                groupValue: employee.role,
                onChanged: (_) {},
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onDelete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Удалить сотрудника'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssignEmployeeSheet extends StatefulWidget {
  final InputDecoration Function({String? hint, Color? fill, bool enabled}) dec;

  const _AssignEmployeeSheet({Key? key, required this.dec}) : super(key: key);

  @override
  State<_AssignEmployeeSheet> createState() => _AssignEmployeeSheetState();
}

class _AssignEmployeeSheetState extends State<_AssignEmployeeSheet> {
  final _fio = TextEditingController();
  final _phone = TextEditingController(text: '+7 (980) 001 01 01');
  final List<TextEditingController> _work = [TextEditingController(text: 'Боулинг клуб "Кегли"')];
  String _role = 'Менеджер';

  @override
  void dispose() {
    _fio.dispose();
    _phone.dispose();
    for (final c in _work) c.dispose();
    super.dispose();
  }

  void _addWork() {
    setState(() => _work.add(TextEditingController()));
  }

  void _removeWork(int i) {
    if (_work.length <= 1) return;
    setState(() {
      final c = _work.removeAt(i);
      c.dispose();
    });
  }

  void _submit() {
    if (_fio.text.trim().isEmpty) return;
    final emp = _Employee(
      fio: _fio.text.trim(),
      workplaces: _work.map((c) => c.text.trim()).where((s) => s.isNotEmpty).toList(),
      address: 'г. Воронеж, ул. Тверская, д. 45',
      phone: _phone.text.trim(),
      role: _role,
    );
    Navigator.pop(context, emp);
  }

  @override
  Widget build(BuildContext context) {
    final dec = widget.dec;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (ctx, controller) => Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: ListView(
          controller: controller,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text('Назначить сотрудника', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                ),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: AppColors.textDark)),
              ],
            ),
            const SizedBox(height: 8),
            const Text('ФИО', style: TextStyle(fontSize: 13, color: AppColors.darkGray)),
            const SizedBox(height: 6),
            TextField(controller: _fio, decoration: dec()),
            const SizedBox(height: 16),
            const Text('Место работы', style: TextStyle(fontSize: 13, color: AppColors.darkGray)),
            const SizedBox(height: 6),
            ...List.generate(_work.length, (i) {
              final isLast = i == _work.length - 1;
              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
                child: Row(
                  children: [
                    Expanded(child: TextField(controller: _work[i], decoration: dec(hint: 'Боулинг клуб'))),
                    const SizedBox(width: 8),
                    if (_work.length > 1)
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: ElevatedButton(
                          onPressed: () => _removeWork(i),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.primary,
                            elevation: 0,
                            side: const BorderSide(color: AppColors.lightGray),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Icon(Icons.remove),
                        ),
                      ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 8),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _addWork,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.primary,
                  elevation: 0,
                  side: const BorderSide(color: AppColors.lightGray),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 8),
                    Text('Добавить клуб'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Номер телефона', style: TextStyle(fontSize: 13, color: AppColors.darkGray)),
            const SizedBox(height: 6),
            TextField(controller: _phone, decoration: dec()),
            const SizedBox(height: 16),
            const Text('Ваш статус:', style: TextStyle(fontSize: 13, color: AppColors.darkGray)),
            const SizedBox(height: 8),
            RadioGroupHorizontal(
              options: const ['Механик', 'Менеджер'],
              groupValue: _role,
              onChanged: (v) => setState(() => _role = v ?? _role),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Назначить сотрудника', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
