import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../shared/widgets/inputs/labeled_text_field.dart';
import '../../../../../shared/widgets/buttons/custom_button.dart';
import '../../../../../shared/widgets/chips/radio_group_wrap.dart';
import '../../../../../shared/widgets/chips/radio_group_horizontal.dart';
import '../../../../../shared/widgets/layout/common_ui.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/utils/form_navigation.dart';
import '../../../../../core/services/auth_service.dart';


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

  String? educationLevelId;
  String? status;

  @override
  void dispose() {
    [
      _fio, _birth, _phone,
      _educationName, _extraEducation,
      _workYears, _bowlingYears,
      _currentClub, _bowlingHistory, _skills
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

  Future<void> _submit() async {
    if (!formKey.currentState!.validate() || educationLevelId == null || status == null) {
      if (educationLevelId == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Выберите уровень образования')));
      }
      if (status == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Выберите статус')));
      }
      return;
    }

    final match = RegExp(r'^\d+\s+лет\s+-\s+Боулинг\s+["\u00AB\u201D](.+?)["\u00BB\u201D]\s+\(с\s+(\d{4})-(\d{4})\)\$')
        .firstMatch(_bowlingHistory.text.trim());

    final workPlace = match?.group(1) ?? _currentClub.text.trim();
    final workPeriod = (match != null) ? '${match.group(2)}-${match.group(3)}' : '';

    final data = {
      'fio': _fio.text.trim(),
      'birth': DateFormat('yyyy-MM-dd').format(birthDate!),
      'phone': _phone.text.trim(),
      'password': 'password123',
      'educationLevelId': educationLevelId!,
      'educationName': _educationName.text.trim(),
      'specializationId': '1',
      'advantages': _extraEducation.text.trim(),
      'workYears': _workYears.text.trim(),
      'bowlingYears': _bowlingYears.text.trim(),
      'currentClub': _currentClub.text.trim(),
      'bowlingHistory': _bowlingHistory.text.trim(),
      'skills': _skills.text.trim(),
      'status': status,
      'workPlaces': workPlace,
      'workPeriods': workPeriod,
    };

    final success = await AuthService.registerMechanic(data);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Регистрация механика успешна')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ошибка при отправке данных')));
    }
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
              child: step == steps.length - 1
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
        formDescription('Пожалуйста, заполните форму — это нужно, чтобы мы знали, где вы работаете и могли подключить Вас к системе.'),
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
          groupValue: educationLevelId,
          onChanged: (v) => setState(() => educationLevelId = v!.split(':')[0]),
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
          validator: (v) {
            final basic = Validators.integer(v);
            if (basic != null) return basic;
            return Validators.validateExperience(_workYears.text, v);
          },
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
          validator: Validators.bowlingHistoryFormat,
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
