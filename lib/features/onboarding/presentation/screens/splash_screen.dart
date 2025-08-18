import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/theme/colors.dart';
import 'onboarding_screen.dart';
import 'welcome_screen.dart';
import '../../../../shared/widgets/titles/bowling_market_title.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _decideRoute();
  }

  Future<void> _decideRoute() async {
    await Future.delayed(const Duration(seconds: 3));
    final sp = await SharedPreferences.getInstance();
    final ftueDone = sp.getBool('ftue_done') ?? false;
    if (!mounted) return;
    if (ftueDone) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => WelcomeScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/splash.jpg', fit: BoxFit.cover),
          ),
          const Center(
            child: BowlingMarketTitle(fontSize: 28),
          ),
        ],
      ),
    );
  }
}