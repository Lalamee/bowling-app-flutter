import 'package:flutter/material.dart';
import 'register_step1.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('BOWLING Market', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              child: Text('Войти'),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterStep1())),
              child: Text('Зарегистрироваться'),
            )
          ],
        ),
      ),
    );
  }
}