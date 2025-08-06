import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/labeled_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/radio_group_wrap.dart';

class RegisterMechanicScreen extends StatefulWidget {
  const RegisterMechanicScreen({Key? key}) : super(key: key);

  @override
  State<RegisterMechanicScreen> createState() => _RegisterMechanicScreenState();
}

class _RegisterMechanicScreenState extends State<RegisterMechanicScreen> {
  final _formKey = GlobalKey<FormState>();
  int _step = 0;

  // Step 1
  final _fio = TextEditingController();
  final _birth = TextEditingController();
  final _phone = TextEditingController();
  DateTime? birthDate;

  // Step 2
  String? educationLevel;
  final _educationName = TextEditingController();
  final _extraEducation = TextEditingController();

  // Step 3
  final _workYears = TextEditingController();
  final _bowlingYears = TextEditingController();
  final _currentClub = TextEditingController();
  final _bowlingHistory = TextEditingController();
  final _skills = TextEditingController();

  @override
  void dispose() {
    [
      _fio,
      _birth,
      _phone,
      _educationName,
      _extraEducation,
      _workYears,
      _bowlingYears,
      _currentClub,
      _bowlingHistory,
      _skills,
    ].forEach((c) => c.dispose());
    super.dispose();
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: birthDate ?? DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        birthDate = picked;
        _birth.text = DateFormat('dd / MM / yyyy').format(picked);
      });
    }
  }

  String? _validateNotEmpty(String? v) => (v == null || v.trim().isEmpty) ? 'Обязательно заполните' : null;

  String? _validateBirth(String? v) => birthDate == null ? 'Выберите дату' : null;

  String? _validatePhone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Введите номер телефона';
    final digits = v.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 11) return 'Неверный формат номера';
    return null;
  }

  String? _validateInteger(String? v) {
    if (v == null || v.trim().isEmpty) return 'Обязательно заполните';
    return int.tryParse(v.trim()) != null ? null : 'Укажите целое число';
  }

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      if (_step == 1 && educationLevel == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Выберите образование')));
        return;
      }
      setState(() => _step++);
    }
  }

  void _prevStep() => setState(() => _step--);

  void _submit() {
    if (!_formKey.currentState!.validate() || educationLevel == null) {
      if (educationLevel == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Выберите образование')));
      }
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Регистрация механика выполнена')));
  }

  @override
  Widget build(BuildContext ctx) {
    final steps = [_buildStepOne(ctx), _buildStepTwo(ctx), _buildStepThree(ctx)];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: steps[_step],
          ),
        ),
      ),
    );
  }

  Widget _buildStepOne(BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Icons.arrow_back)),
        Text('Добро пожаловать!', style: AppTextStyles.onboardingTitle.copyWith(color: AppColors.primary)),
        const SizedBox(height: 8),
        const Text(
          'Пожалуйста, заполните короткую форму — это нужно, чтобы мы знали, в каком клубе вы работаете и могли подключить Вас к системе для заказов и обслуживания оборудования.',
        ),
        const SizedBox(height: 24),
        LabeledTextField(
          label: 'ФИО',
          controller: _fio,
          validator: _validateNotEmpty,
          icon: Icons.person,
        ),
        LabeledTextField(
          label: 'Дата рождения',
          controller: _birth,
          validator: _validateBirth,
          readOnly: true,
          onTap: _pickBirthDate,
          icon: Icons.calendar_today,
        ),
        LabeledTextField(
          label: 'Номер телефона',
          controller: _phone,
          validator: _validatePhone,
          keyboardType: TextInputType.phone,
          icon: Icons.phone,
        ),
        const SizedBox(height: 52),
        SizedBox(
          width: double.infinity,
          height: 65,
          child: CustomButton(text: 'Далее', onPressed: _nextStep),
        ),
      ],
    );
  }

  Widget _buildStepTwo(BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(onPressed: _prevStep, icon: const Icon(Icons.arrow_back)),
        const Text('Какое у Вас образование?', style: AppTextStyles.onboardingTitle),
        const SizedBox(height: 16),
        RadioGroupWrap(
          options: const [
            'высшее',
            'высшее-профессиональное',
            'среднее',
            'средне-профессиональное',
            'другое',
          ],
          groupValue: educationLevel,
          onChanged: (v) => setState(() => educationLevel = v),
        ),
        const SizedBox(height: 16),
        LabeledTextField(
          label: 'Наименование образовательного учреждения',
          controller: _educationName,
          validator: _validateNotEmpty,
        ),
        LabeledTextField(
          label: 'Дополнительное образование (курсы и т.д.)',
          controller: _extraEducation,
          validator: _validateNotEmpty,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 65,
          child: CustomButton(text: 'Далее', onPressed: _nextStep),
        ),
      ],
    );
  }

  Widget _buildStepThree(BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(onPressed: _prevStep, icon: const Icon(Icons.arrow_back)),
        const Text('Стаж работы', style: AppTextStyles.onboardingTitle),
        const SizedBox(height: 8),
        LabeledTextField(
          label: 'Общий стаж работы',
          controller: _workYears,
          validator: _validateInteger,
          keyboardType: TextInputType.number,
        ),
        LabeledTextField(
          label: 'Стаж в боулинге',
          controller: _bowlingYears,
          validator: _validateInteger,
          keyboardType: TextInputType.number,
        ),
        LabeledTextField(
          label: 'Текущее место работы',
          controller: _currentClub,
          validator: _validateNotEmpty,
        ),
        LabeledTextField(
          label: 'Где и когда работали в боулинге',
          controller: _bowlingHistory,
          validator: _validateNotEmpty,
        ),
        LabeledTextField(
          label: 'Навыки и преимущества',
          controller: _skills,
          validator: _validateNotEmpty,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 65,
          child: CustomButton(text: 'Зарегистрироваться', onPressed: _submit),
        ),
      ],
    );
  }
}
