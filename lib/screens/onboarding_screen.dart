import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import '../theme/colors.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  int _index = 0;

  final List<Map<String, String>> _data = [
    {
      'title': 'Проектирование и установка дорожек',
      'subtitle': 'Мы создаем профессиональные решения под ключ.',
    },
    {
      'title': 'Модернизация оборудования',
      'subtitle': 'Помогаем обновить ваши дорожки и систему.',
    },
    {
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
                    Icon(Icons.sports_handball, size: 120, color: Colors.grey),
                    SizedBox(height: 40),
                    Text(_data[i]['title']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Text(_data[i]['subtitle']!, textAlign: TextAlign.center),
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