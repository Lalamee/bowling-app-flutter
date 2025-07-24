import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterMechanicScreen extends StatefulWidget {
  const RegisterMechanicScreen({super.key});

  @override
  State<RegisterMechanicScreen> createState() => _RegisterMechanicScreenState();
}

class _RegisterMechanicScreenState extends State<RegisterMechanicScreen> {
  DateTime? birthDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
              const Text(
                'Добро пожаловать!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFB2002D)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Пожалуйста, заполните короткую форму — это нужно, чтобы мы знали, в каком клубе вы работаете и могли подключить вас к системе для заказов и обслуживания оборудования.',
              ),
              const SizedBox(height: 24),
              _labeledInput('ФИО'),
              _birthDatePicker(),
              _labeledInput('Номер телефона', prefix: '+7'),
              _labeledInput('Клуб(ы), где обслуживаете'),
              _labeledInput('Марка и модель робота(роботов) по боулингу'),
              _labeledInput('Место и период работы в боулинге'),
              _labeledInput('Ваши специализации, навыки, преимущества:'),
              const SizedBox(height: 16),
              const Text('Ваш статус:', style: TextStyle(fontWeight: FontWeight.w500)),
              Row(
                children: [
                  _radioOption('ИП'),
                  _radioOption('Самозанятый'),
                ],
              ),
              const SizedBox(height: 24),
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _labeledInput(String label, {String? prefix}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              fontSize: 10,
              height: 1.0,
              letterSpacing: -0.2,
              color: Color(0xFFC2C3CB),
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            keyboardType: prefix != null ? TextInputType.phone : TextInputType.text,
            decoration: InputDecoration(
              prefixText: prefix,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _birthDatePicker() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Дата рождения',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              fontSize: 10,
              height: 1.0,
              letterSpacing: -0.2,
              color: Color(0xFFC2C3CB),
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime(now.year - 18),
                firstDate: DateTime(1900),
                lastDate: now,
              );
              if (picked != null) {
                setState(() => birthDate = picked);
              }
            },
            child: AbsorbPointer(
              child: TextField(
                controller: TextEditingController(
                  text: birthDate != null ? DateFormat('dd / MM / yyyy').format(birthDate!) : '',
                ),
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'ДД / ММ / ГГГГ',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                style: TextStyle(
                  color: birthDate != null ? Colors.black : Colors.grey[600],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _radioOption(String label) {
    return Expanded(
      child: Row(
        children: [
          Radio(value: label, groupValue: null, onChanged: (_) {}),
          Text(label),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[700],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text('Зарегистрироваться'),
      ),
    );
  }
}
