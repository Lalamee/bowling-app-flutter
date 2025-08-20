import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'register_role_selection.dart';
import '../../../../shared/widgets/titles/bowling_market_title.dart';
import '../../../../core/theme/colors.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/debug/test_overrides.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late final TapGestureRecognizer _policyRecognizer;

  @override
  void initState() {
    super.initState();
    _policyRecognizer = TapGestureRecognizer()..onTap = () {};
  }

  @override
  void dispose() {
    _policyRecognizer.dispose();
    super.dispose();
  }

  void _enter() {
    final role = TestOverrides.userRole.toLowerCase();
    if (role == 'owner') {
      Navigator.pushReplacementNamed(context, Routes.profileOwner);
    } else {
      Navigator.pushReplacementNamed(context, Routes.profileMechanic);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: BowlingMarketTitle(fontSize: 28)),
                  const SizedBox(height: 24),
                  const Text(
                    'Здесь широкий спектр услуг и товаров для инвесторов, собственников и механиков.',
                    style: TextStyle(fontSize: 14, height: 1.4, color: Color(0xFF23262F)),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (TestOverrides.userRole.toLowerCase() == 'owner') {
                          Navigator.pushReplacementNamed(context, Routes.profileOwner);
                        } else {
                          Navigator.pushReplacementNamed(context, Routes.profileMechanic);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: const Text('ВОЙТИ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    ),
                  ),

                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterRoleSelectionScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightGray,
                        foregroundColor: AppColors.darkGray,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: const Text('Регистрация', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(fontSize: 12, color: Color(0xFF6F6F6F), height: 1.3),
                        children: [
                          const TextSpan(text: 'При входе и регистрации Вы соглашаетесь '),
                          TextSpan(
                            text: 'с политикой обработки персональных данных.',
                            style: const TextStyle(decoration: TextDecoration.underline, color: Color(0xFF6F6F6F)),
                            recognizer: _policyRecognizer,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
