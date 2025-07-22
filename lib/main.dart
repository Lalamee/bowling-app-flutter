import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'theme/colors.dart';

void main() {
  runApp(BowlingMarketApp());
}

class BowlingMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primary,
        ),
      ),
      home: SplashScreen(),
    );
  }
}