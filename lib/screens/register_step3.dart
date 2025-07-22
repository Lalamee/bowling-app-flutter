import 'package:flutter/material.dart';

class RegisterStep3 extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Регистрация')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: phoneController, decoration: InputDecoration(labelText: 'Телефон')),
            TextField(controller: companyController, decoration: InputDecoration(labelText: 'Компания')),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Завершение регистрации
              },
              child: Text('Завершить'),
            )
          ],
        ),
      ),
    );
  }
}