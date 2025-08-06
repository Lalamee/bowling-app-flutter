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
import '../widgets/radio_group_vertical.dart';

class RegisterOwnerScreen extends StatefulWidget {
  const RegisterOwnerScreen({Key? key}) : super(key: key);
  @override
  State<RegisterOwnerScreen> createState() => _RegisterOwnerScreenState();
}

class _RegisterOwnerScreenState extends MultiStepFormState<RegisterOwnerScreen> {
  final _inn = TextEditingController();
  final _club = TextEditingController();
  final _addr = TextEditingController();
  final _lanes = TextEditingController();
  final _skills = TextEditingController();
  final _phone = TextEditingController();
  final _fio = TextEditingController();
  final _customEquipment = TextEditingController();
  String? status;
  String? selectedEquipment;

  final List<String> _equipmentOptions = ['AMF', 'Brunswick', 'VIA', 'XIMA', 'другое'];

  @override
  void dispose() {
    [_inn, _club, _addr, _lanes, _skills, _phone, _fio, _customEquipment].forEach((c) => c.dispose());
    super.dispose();
  }

  void _submit() {
    if (!formKey.currentState!.validate() || status == null || selectedEquipment == null) {
      if (status == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Выберите статус')));
      }
      if (selectedEquipment == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Выберите оборудование')));
      }
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Регистрация владельца выполнена')));
  }

  @override
  Widget build(BuildContext ctx) {
    final steps = [_buildStepOne(ctx), _buildStepTwo(ctx)];

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
              child: step == 1
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
          'Это нужно, чтобы мы знали, каким клубом вы управляете, и могли предоставить вам доступ к инструментам управления, заказам и аналитике.',
        ),
        LabeledTextField(
          label: 'ФИО', 
          controller: _fio, 
          validator: Validators.notEmpty, 
          icon: Icons.person),
        LabeledTextField(
          label: 'Номер телефона', 
          controller: _phone, 
          validator: Validators.phone, 
          keyboardType: TextInputType.phone, 
          icon: Icons.phone),
        LabeledTextField(
          label: 'ИНН организации', 
          controller: _inn, 
          validator: Validators.notEmpty, 
          keyboardType: TextInputType.number, 
          icon: Icons.badge),
        LabeledTextField(
          label: 'Адрес клуба', 
          controller: _addr, 
          validator: Validators.notEmpty, 
          icon: Icons.location_on),
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

  Widget _buildStepTwo(BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(onPressed: prevStep, icon: const Icon(Icons.arrow_back)),
        sectionTitle('Расскажите о Вашем клубе:'),
        formDescription('Укажите количество дорожек и установленное оборудование — это нужно, чтобы мы могли точно учитывать особенности вашего клуба.'),
        LabeledTextField(label: 'Название клуба', controller: _club, validator: Validators.notEmpty, icon: Icons.sports),
        LabeledTextField(label: 'Количество дорожек', controller: _lanes, validator: Validators.integer, keyboardType: TextInputType.number, icon: Icons.format_list_numbered),
        const SizedBox(height: 16),
        sectionTitle('Какое оборудование стоит в клубе'),
        RadioGroupVertical(
          options: _equipmentOptions,
          groupValue: selectedEquipment,
          onChanged: (v) => setState(() => selectedEquipment = v),
        ),
        if (selectedEquipment == 'другое')
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: LabeledTextField(label: 'Уточните', controller: _customEquipment, validator: Validators.notEmpty),
          ),
      ],
    );
  }
}
