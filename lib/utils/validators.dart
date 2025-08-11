class Validators {
  static String? notEmpty(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Обязательно заполните' : null;

  static String? integer(String? v) {
    if (v == null || v.trim().isEmpty) return 'Поле обязательно';
    return int.tryParse(v.trim()) != null ? null : 'Укажите целое число';
  }

  static String? phone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Введите номер телефона';
    final digits = v.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 11) return 'Неверный формат номера';
    return null;
  }

  static String? Function(String?) birth(DateTime? birthDate) {
    return (_) => birthDate == null ? 'Выберите дату' : null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Введите email';

    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$");
    if (!emailRegex.hasMatch(value.trim())) return 'Некорректный email';

    return null;
  }

  static String? validateExperience(String? total, String? bowling) {
    if (total == null || bowling == null) return null;
    final totalYears = int.tryParse(total.trim());
    final bowlingYears = int.tryParse(bowling.trim());
    if (totalYears == null || bowlingYears == null) return null;
    if (bowlingYears > totalYears) {
      return 'Стаж в боулинге не может превышать общий стаж';
    }
    return null;
  }

  static String? bowlingHistoryFormat(String? v) {
    if (v == null || v.trim().isEmpty) return 'Заполните поле';
    final pattern = RegExp(r'^\d+\s+лет\s+-\s+Боулинг\s+["\u00AB\u201D](.+?)["\u00BB\u201D]\s+\(с\s+\d{4}-\d{4}\)\$');
    if (!pattern.hasMatch(v.trim())) {
      return 'Формат: 5 лет - Боулинг “Шары” (с 2005-2010)';
    }
    return null;
  }
}
