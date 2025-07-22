import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnboardingScreen()),
      );
    });
    return Scaffold(
      body: Center(
        child: Text('BOWLING Market', style: TextStyle(fontSize: 24, color: Color(0xFF8A002D))),
      ),
    );
  }
}
