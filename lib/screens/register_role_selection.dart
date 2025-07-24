import 'package:flutter/material.dart';
import 'register_owner_screen.dart';
import 'register_mechanic_screen.dart';

class RegisterRoleSelectionScreen extends StatelessWidget {
  const RegisterRoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterMechanicScreen()));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(60),
                  backgroundColor: Colors.grey[700],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Я МЕХАНИК', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterOwnerScreen()));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(60),
                  backgroundColor: Color(0xFFB2002D),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Я ВЛАДЕЛЕЦ КЛУБА', style: TextStyle(fontSize: 16)),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Text.rich(
                TextSpan(
                  text: 'BOVLING',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  children: [TextSpan(text: 'Market', style: TextStyle(color: Color(0xFFB2002D)))],
                ),
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
