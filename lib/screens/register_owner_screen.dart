import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/labeled_text_field.dart';
import '../widgets/radio_group_horizontal.dart';
import '../widgets/radio_group_vertical.dart';
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
  final _skills = TextEditingController();
  final _phone = TextEditingController();
  final _fio = TextEditingController();
  final _customEquipment = TextEditingController();
  String? status;
  String? selectedEquipment;
  int _step = 0;

  final List<String> _equipmentOptions = ['AMF', 'Brunswick', 'VIA', 'XIMA', 'другое'];

  @override
  void dispose() {
    [_inn, _club, _addr, _lanes, _skills, _phone, _fio, _customEquipment].forEach((c) => c.dispose());
    super.dispose();
  }

  String? _validateNotEmpty(String? v) => (v == null || v.trim().isEmpty) ? 'Обязательно заполните' : null;
  String? _validateInteger(String? v) {
    if (v == null || v.trim().isEmpty) return 'Поле обязательно';
    return int.tryParse(v) != null ? null : 'Укажите целое число';
  }

  void _submit() {
    if (!_formKey.currentState!.validate() || status == null || selectedEquipment == null) {
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

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      setState(() => _step++);
    }
  }

  void _prevStep() {
    setState(() => _step--);
  }

  @override
  Widget build(BuildContext ctx) {
    final pages = [
      _buildStepOne(ctx),
      _buildStepTwo(ctx),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: pages[_step],
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
        const Text('Это нужно, чтобы мы знали, каким клубом вы управляете, и могли предоставить вам доступ к инструментам управления, заказам и аналитике.'),
        const SizedBox(height: 24),
        LabeledTextField(
          label: 'ФИО', 
          controller: _fio, 
          validator: _validateNotEmpty, 
          icon: Icons.person),
        LabeledTextField(
          label: 'Номер телефона', 
          controller: _phone, 
          validator: _validateNotEmpty, 
          keyboardType: TextInputType.phone, 
          icon: Icons.phone),
        LabeledTextField(
          label: 'ИНН организации', 
          controller: _inn, 
          validator: _validateNotEmpty, 
          keyboardType: TextInputType.number, 
          icon: Icons.badge),
        LabeledTextField(
          label: 'Адрес клуба', 
          controller: _addr, 
          validator: _validateNotEmpty, 
          icon: Icons.location_on),
        const Text('Ваш статус:', style: AppTextStyles.formLabel),
        RadioGroupHorizontal(
          options: const ['ИП', 'Самозанятый'],
          groupValue: status,
          onChanged: (v) => setState(() => status = v),
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
        const Text('Расскажите о Вашем клубе:', style: AppTextStyles.onboardingTitle),
        const SizedBox(height: 8),
        const Text('Укажите количество дорожек и установленное оборудование — это нужно, чтобы мы могли точно учитывать особенности вашего клуба, подбирая подходящие сервисные решения, а также быстрее обрабатывать заявки на обслуживание.'),
        const SizedBox(height: 24),
        LabeledTextField(
          label: 'Название клуба', 
          controller: _club, 
          validator: _validateNotEmpty, 
          icon: Icons.sports),
        LabeledTextField(
          label: 'Количество дорожек', 
          controller: _lanes, 
          validator: _validateInteger, 
          keyboardType: TextInputType.number, 
          icon: Icons.format_list_numbered),
        const Text('Какое оборудование стоит в клубе', style: AppTextStyles.formLabel),
        RadioGroupVertical(
          options: _equipmentOptions,
          groupValue: selectedEquipment,
          onChanged: (v) => setState(() => selectedEquipment = v),
        ),
        if (selectedEquipment == 'другое')
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: LabeledTextField(label: 'Уточните', controller: _customEquipment, validator: _validateNotEmpty),
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
