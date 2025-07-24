import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/labeled_text_field.dart';
import '../widgets/radio_group.dart';
import '../widgets/custom_button.dart';

class RegisterMechanicScreen extends StatefulWidget {
  const RegisterMechanicScreen({Key? key}) : super(key: key);

  @override
  State<RegisterMechanicScreen> createState() => _RegisterMechanicScreenState();
}

class _RegisterMechanicScreenState extends State<RegisterMechanicScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fio = TextEditingController();
  final _birth = TextEditingController();
  final _phone = TextEditingController();
  final _clubs = TextEditingController();
  final _robots = TextEditingController();
  final _period = TextEditingController();
  final _skills = TextEditingController();

  DateTime? birthDate;
  String? status;

  @override
  void dispose() {
    [_fio, _birth, _phone, _clubs, _robots, _period, _skills].forEach((c) => c.dispose());
    super.dispose();
  }

  void _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
        context: context,
        initialDate: birthDate ?? DateTime(now.year - 18),
        firstDate: DateTime(1900),
        lastDate: now);
    if (picked != null) {
      birthDate = picked;
      _birth.text = DateFormat('dd / MM / yyyy').format(picked);
    }
  }

  String? _validateNotEmpty(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Обязательно заполните' : null;

  String? _validatePhone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Нужно ввести номер';
    final clean = v.replaceAll(RegExp(r'\D'), '');
    return clean.length == 10 ? null : '10 цифр без пробелов';
  }

  String? _validateBirth(String? v) => birthDate == null ? 'Выберите дату' : null;

  void _submit() {
    if (!_formKey.currentState!.validate() || status == null) {
      if (status == null)
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Выберите статус')));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Регистрация механика выполнена')));
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Icons.arrow_back)),
              Text('Добро пожаловать!', style: AppTextStyles.onboardingTitle.copyWith(color: AppColors.primary)),
              const SizedBox(height: 8),
              const Text('Короткая регистрационная форма'),
              const SizedBox(height: 24),
              LabeledTextField(label: 'ФИО', controller: _fio, validator: _validateNotEmpty),
              GestureDetector(onTap: _pickBirthDate, child: AbsorbPointer(child:
                LabeledTextField(label: 'Дата рождения', controller: _birth, validator: _validateBirth, readOnly: true))),
              LabeledTextField(label: 'Номер телефона', controller: _phone, validator: _validatePhone, keyboardType: TextInputType.phone),
              LabeledTextField(label: 'Клуб(ы)', controller: _clubs, validator: _validateNotEmpty),
              LabeledTextField(label: 'Роботы', controller: _robots, validator: _validateNotEmpty),
              LabeledTextField(label: 'Период работы', controller: _period, validator: _validateNotEmpty),
              LabeledTextField(label: 'Навыки', controller: _skills, validator: _validateNotEmpty),
              const SizedBox(height: 16),
              const Text('Статус', style: AppTextStyles.formLabel),
              RadioGroup(options: const ['ИП', 'Самозанятый'], groupValue: status, onChanged: (v) => setState(() => status = v)),
              const SizedBox(height: 24),
              CustomButton(text: 'Зарегистрироваться', onPressed: _submit),
            ]),
          ),
        ),
      ),
    );
  }
}
