import 'package:flutter/material.dart';
import 'register_step3.dart';

class RegisterStep2 extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Регистрация')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Пароль'), obscureText: true),
            TextField(controller: confirmPasswordController, decoration: InputDecoration(labelText: 'Подтверждение'), obscureText: true),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterStep3()));
              },
              child: Text('Далее'),
            )
          ],
        ),
      ),
    );
  }
}