import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/labeled_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/radio_group_wrap.dart';
import '../utils/validators.dart';
import '../utils/form_navigation.dart';
import '../widgets/common_ui.dart';
import '../widgets/radio_group_horizontal.dart';

class RegisterMechanicScreen extends StatefulWidget {
  const RegisterMechanicScreen({Key? key}) : super(key: key);

  @override
  State<RegisterMechanicScreen> createState() => _RegisterMechanicScreenState();
}

class _RegisterMechanicScreenState extends MultiStepFormState<RegisterMechanicScreen> {
  final _fio = TextEditingController();
  final _birth = TextEditingController();
  final _phone = TextEditingController();
  DateTime? birthDate;

  final _educationName = TextEditingController();
  final _extraEducation = TextEditingController();

  final _workYears = TextEditingController();
  final _bowlingYears = TextEditingController();
  final _currentClub = TextEditingController();
  final _bowlingHistory = TextEditingController();
  final _skills = TextEditingController();

  String? educationLevel;
  String? status;

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
        _birth.text = DateFormat('dd.MM.yyyy').format(picked);
      });
    }
  }

  void _submit() {
    if (!formKey.currentState!.validate() || educationLevel == null || status == null) {
      if (educationLevel == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Выберите образование')));
      }
      if (status == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Выберите статус')));
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  child: steps[step],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: step == 2
                  ? CustomButton(text: 'Зарегистрироваться', onPressed: _submit)
                  : CustomButton(text: 'Далее', onPressed: nextStep),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepOne(BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Icons.arrow_back)),
        formStepTitle('Добро пожаловать!'),
        formDescription(
          'Пожалуйста, заполните короткую форму — это нужно, чтобы мы знали, в каком клубе вы работаете и могли подключить Вас к системе.',
        ),
        LabeledTextField(
          label: 'ФИО',
          controller: _fio,
          validator: Validators.notEmpty,
          icon: Icons.person,
        ),
        LabeledTextField(
          label: 'Дата рождения',
          controller: _birth,
          validator: Validators.birth(birthDate),
          readOnly: true,
          onTap: _pickBirthDate,
          icon: Icons.calendar_today,
        ),
        LabeledTextField(
          label: 'Номер телефона',
          controller: _phone,
          validator: Validators.phone,
          keyboardType: TextInputType.phone,
          icon: Icons.phone,
        ),
      ],
    );
  }

  Widget _buildStepTwo(BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(onPressed: prevStep, icon: const Icon(Icons.arrow_back)),
        sectionTitle('Какое у Вас образование?'),
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
          validator: Validators.notEmpty,
        ),
        LabeledTextField(
          label: 'Дополнительное образование (курсы и т.д.)',
          controller: _extraEducation,
          validator: Validators.notEmpty,
        ),
      ],
    );
  }

  Widget _buildStepThree(BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(onPressed: prevStep, icon: const Icon(Icons.arrow_back)),
        sectionTitle('Стаж работы'),
        const SizedBox(height: 8),
        LabeledTextField(
          label: 'Общий стаж работы',
          controller: _workYears,
          validator: Validators.integer,
          keyboardType: TextInputType.number,
        ),
        LabeledTextField(
          label: 'Стаж в боулинге',
          controller: _bowlingYears,
          validator: Validators.integer,
          keyboardType: TextInputType.number,
        ),
        LabeledTextField(
          label: 'Текущее место работы',
          controller: _currentClub,
          validator: Validators.notEmpty,
        ),
        LabeledTextField(
          label: 'Где и когда работали в боулинге',
          controller: _bowlingHistory,
          validator: Validators.notEmpty,
        ),
        LabeledTextField(
          label: 'Навыки и преимущества',
          controller: _skills,
          validator: Validators.notEmpty,
        ),
        const SizedBox(height: 16),
        formDescription('Ваш статус:'),
        RadioGroupHorizontal(
          options: const ['ИП', 'Самозанятый'],
          groupValue: status,
          onChanged: (v) => setState(() => status = v),
        ),
      ],
    );
  }
}