import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/colors.dart';
import '../widgets/labeled_text_field.dart';
import '../widgets/radio_group_horizontal.dart';
import '../models/mechanic_profile.dart';
import 'mechanic_profile_screen.dart' show EditFocus;
import '../widgets/app_bottom_nav.dart';
import '../utils/bottom_nav.dart';

class EditMechanicProfileScreen extends StatefulWidget {
  final MechanicProfile initial;
  final EditFocus focus;

  const EditMechanicProfileScreen({
    Key? key,
    required this.initial,
    this.focus = EditFocus.none,
  }) : super(key: key);

  @override
  State<EditMechanicProfileScreen> createState() => _EditMechanicProfileScreenState();
}

class _EditMechanicProfileScreenState extends State<EditMechanicProfileScreen> {
  final _fio = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();
  final _birth = TextEditingController();
  final List<TextEditingController> _clubCtrls = [];
  final _fioFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _addrFocus = FocusNode();

  String _status = 'Механик';

  @override
  void initState() {
    super.initState();
    final p = widget.initial;
    _fio.text = p.fullName;
    _address.text = p.address;
    _phone.text = p.phone;
    _birth.text = DateFormat('dd.MM.yyyy').format(p.birthDate);
    _status = p.status;
    final clubs = (p.clubs.isEmpty ? [p.clubName] : p.clubs);
    for (final c in clubs) {
      _clubCtrls.add(TextEditingController(text: c));
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (widget.focus) {
        case EditFocus.name:
          _fioFocus.requestFocus();
          break;
        case EditFocus.phone:
          _phoneFocus.requestFocus();
          break;
        case EditFocus.address:
          _addrFocus.requestFocus();
          break;
        case EditFocus.none:
          break;
      }
    });
  }

  @override
  void dispose() {
    _fio.dispose();
    _address.dispose();
    _phone.dispose();
    _birth.dispose();
    for (final c in _clubCtrls) c.dispose();
    _fioFocus.dispose();
    _phoneFocus.dispose();
    _addrFocus.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration({String? hint, bool filled = true}) {
    return InputDecoration(
      hintText: hint,
      filled: filled,
      fillColor: AppColors.white,
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    );
  }

  void _addClubField() => setState(() => _clubCtrls.add(TextEditingController()));

  void _removeClubField(int i) {
    if (_clubCtrls.length <= 1) return;
    setState(() {
      final ctrl = _clubCtrls.removeAt(i);
      ctrl.dispose();
    });
  }

  void _saveAndPop() {
    final clubs = _clubCtrls.map((c) => c.text.trim()).where((s) => s.isNotEmpty).toList();
    final clubName = clubs.isNotEmpty ? clubs.first : '';
    final updated = widget.initial.copyWith(
      fullName: _fio.text.trim(),
      address: _address.text.trim(),
      phone: _phone.text.trim(),
      clubName: clubName,
      clubs: clubs,
      status: _status,
    );
    Navigator.pop(context, updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: _saveAndPop,
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textDark),
        ),
        title: const Text('Персональная информация', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const SizedBox(height: 6),
          const Text('Для редактирования информации нажмите на поле ввода', style: TextStyle(fontSize: 13, color: AppColors.darkGray)),
          const SizedBox(height: 18),
          const Text('ФИО', style: TextStyle(fontSize: 13, color: AppColors.darkGray)),
          const SizedBox(height: 6),
          TextField(controller: _fio, focusNode: _fioFocus, decoration: _fieldDecoration()),
          const SizedBox(height: 16),
          const Text('Место работы', style: TextStyle(fontSize: 13, color: AppColors.darkGray)),
          const SizedBox(height: 6),
          ...List.generate(_clubCtrls.length, (i) {
            final isLast = i == _clubCtrls.length - 1;
            return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
              child: Row(
                children: [
                  Expanded(child: TextField(controller: _clubCtrls[i], decoration: _fieldDecoration(hint: 'Боулинг клуб'))),
                  const SizedBox(width: 8),
                  if (_clubCtrls.length > 1)
                    SizedBox(
                      height: 48,
                      width: 48,
                      child: ElevatedButton(
                        onPressed: () => _removeClubField(i),
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
              onPressed: _addClubField,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.primary,
                elevation: 0,
                side: const BorderSide(color: AppColors.lightGray),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.add), SizedBox(width: 8), Text('Добавить клуб')],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Адрес', style: TextStyle(fontSize: 13, color: AppColors.darkGray)),
          const SizedBox(height: 6),
          TextField(controller: _address, focusNode: _addrFocus, decoration: _fieldDecoration(hint: 'г. Воронеж, ул. Тверская, д. 45')),
          const SizedBox(height: 16),
          const Text('Ваш статус:', style: TextStyle(fontSize: 13, color: AppColors.darkGray)),
          const SizedBox(height: 8),
          RadioGroupHorizontal(
            options: const ['Собственник', 'Механик'],
            groupValue: _status,
            onChanged: (v) => setState(() => _status = v ?? _status),
          ),
          const SizedBox(height: 20),
          const Text('Подтверждение', style: TextStyle(fontSize: 13, color: AppColors.darkGray)),
          const SizedBox(height: 6),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: _saveAndPop,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGray,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Отправить запрос на подтверждение', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ),
          ),
          const SizedBox(height: 18),
          LabeledTextField(label: 'Дата рождения', controller: _birth, readOnly: true),
          const SizedBox(height: 12),
          const Text('Номер телефона', style: TextStyle(fontSize: 13, color: AppColors.darkGray)),
          const SizedBox(height: 6),
          TextField(
            controller: _phone,
            focusNode: _phoneFocus,
            readOnly: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF0DADF),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            ),
          ),
          const SizedBox(height: 8),
          const Text('Чтобы изменить номер телефона, обратитесь в службу поддержки 8 800 000 00 00.', style: TextStyle(fontSize: 13, color: AppColors.darkGray)),
          const SizedBox(height: 28),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 3,
        onTap: (i) => BottomNavDirect.go(context, 3, i),
      ),
    );
  }
}
