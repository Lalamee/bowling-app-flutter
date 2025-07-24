import 'package:flutter/material.dart';

class RegisterOwnerScreen extends StatefulWidget {
  const RegisterOwnerScreen({super.key});

  @override
  State<RegisterOwnerScreen> createState() => _RegisterOwnerScreenState();
}

class _RegisterOwnerScreenState extends State<RegisterOwnerScreen> {
  String? _status;

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
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
              const Text(
                'Добро пожаловать!',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB2002D)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Пожалуйста, заполните короткую форму — это нужно, чтобы мы знали, в каком клубе вы работаете и могли подключить вас к системе для заказов и обслуживания оборудования.',
              ),
              const SizedBox(height: 24),
              _labeledInput('ИНН'),
              _labeledInput('Название клуба'),
              _labeledInput('Адрес'),
              _labeledInput('Количество дорожек'),
              _labeledInput('AMF, Brunswick, VIA, XIMA либо другое'),
              _labeledInput('Ваша специализация, навыки, преимущества:'),
              const SizedBox(height: 16),
              const Text('Ваш статус:',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  )),
              const SizedBox(height: 8),
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

  Widget _labeledInput(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFC2C3CB),
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              fontSize: 10,
              height: 1.0,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
          Radio<String>(
            value: label,
            groupValue: _status,
            onChanged: (value) {
              setState(() {
                _status = value;
              });
            },
          ),
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
        onPressed: () {
          // TODO: обработка регистрации
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[700],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text(
          'Зарегистрироваться',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
