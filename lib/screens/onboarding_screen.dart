import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  final List<Map<String, String>> _data = [
    {
      'image': 'assets/images/onboard1.jpg',
      'title': 'Проектирование и установка дорожек',
      'subtitle': 'Мы создаем профессиональные решения под ключ.',
    },
    {
      'image': 'assets/images/onboard2.jpg',
      'title': 'Модернизация оборудования',
      'subtitle': 'Помогаем обновить ваши дорожки и систему.',
    },
    {
      'image': 'assets/images/onboard3.jpg',
      'title': 'Обучение и техподдержка',
      'subtitle': 'Мы обучим и поддержим ваш персонал.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: _data.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(33.05),
                      child: Image.asset(
                        _data[i]['image']!,
                        width: 336,
                        height: 438.45,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: 330,
                      height: 70,
                      child: Text(
                        _data[i]['title']!,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.onboardingTitle,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 355,
                      height: 60,
                      child: Text(
                        _data[i]['subtitle']!,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.onboardingSubtitle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                if (_index < _data.length - 1) {
                  _controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                } else {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => WelcomeScreen()));
                }
              },
              child: Text(_index < _data.length - 1 ? 'Далее' : 'Начать'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
