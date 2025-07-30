import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/labeled_text_field.dart';
import '../widgets/radio_group.dart';
import '../widgets/custom_button.dart';

class RegisterOwnerScreen extends StatefulWidget {
  const RegisterOwnerScreen({Key? key}) : super(key: key);

  @override
  State<RegisterOwnerScreen> createState() => _RegisterOwnerScreenState();
}

class _RegisterOwnerScreenState extends State<RegisterOwnerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _inn = TextEditingController();
  final _club = TextEditingController();
  final _addr = TextEditingController();
  final _lanes = TextEditingController();
  final _equip = TextEditingController();
  final _skills = TextEditingController();
  String? status;

  @override
  void dispose() {
    [_inn, _club, _addr, _lanes, _equip, _skills].forEach((c) => c.dispose());
    super.dispose();
  }

  String? _validateNotEmpty(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Обязательно заполните' : null;

  String? _validateInteger(String? v) {
    if (v == null || v.trim().isEmpty) return 'Поле обязательно';
    return int.tryParse(v) != null ? null : 'Укажите целое число';
  }

  void _submit() {
    if (!_formKey.currentState!.validate() || status == null) {
      if (status == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Выберите статус')),
        );
      }
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Регистрация владельца выполнена')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                Text(
                  'Добро пожаловать!',
                  style: AppTextStyles.onboardingTitle.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 8),
                const Text('Короткая регистрационная форма'),
                const SizedBox(height: 24),
                LabeledTextField(
                  label: 'ИНН',
                  controller: _inn,
                  validator: _validateNotEmpty,
                  keyboardType: TextInputType.number,
                ),
                LabeledTextField(
                  label: 'Название клуба', 
                  controller: _club, 
                  validator: _validateNotEmpty),
                LabeledTextField(
                  label: 'Адрес', 
                  controller: _addr, 
                  validator: _validateNotEmpty),
                LabeledTextField(
                  label: 'Количество дорожек',
                  controller: _lanes,
                  validator: _validateInteger,
                  keyboardType: TextInputType.number,
                ),
                LabeledTextField(
                  label: 'Оборудование', 
                  controller: _equip, 
                  validator: _validateNotEmpty),
                LabeledTextField(
                  label: 'Навыки', 
                  controller: _skills, 
                  validator: _validateNotEmpty),
                const SizedBox(height: 16),
                const Text('Статус', style: AppTextStyles.formLabel),
                RadioGroup(
                  options: const ['ИП', 'Самозанятый'],
                  groupValue: status,
                  onChanged: (v) => setState(() => status = v),
                ),
                const SizedBox(height: 24),
                Center(child: CustomButton(text: 'Зарегистрироваться', onPressed: _submit)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
