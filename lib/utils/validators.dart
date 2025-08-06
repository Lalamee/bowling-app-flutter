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
}
