import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart'; // замени на свой путь

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BowlingMarketApp());

    // Здесь может не быть счетчика '0', если ты не использовал пример с счетчиком
    // Лучше удалить этот шаблонный тест или переписать под твое приложение
  });
}
