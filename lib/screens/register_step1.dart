import 'package:flutter/material.dart';
import 'register_step2.dart';

class RegisterStep1 extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Регистрация')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Имя')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterStep2()));
              },
              child: Text('Далее'),
            )
          ],
        ),
      ),
    );
  }
}