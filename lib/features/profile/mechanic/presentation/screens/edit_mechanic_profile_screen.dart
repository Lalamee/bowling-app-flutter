import 'package:flutter/material.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/typography_extension.dart';

class EditMechanicProfileScreen extends StatefulWidget {
  final String? mechanicId;
  final dynamic initial;
  final dynamic focus;

  const EditMechanicProfileScreen({
    super.key,
    this.mechanicId,
    this.initial,
    this.focus,
  });

  @override
  State<EditMechanicProfileScreen> createState() => _EditMechanicProfileScreenState();
}

class _EditMechanicProfileScreenState extends State<EditMechanicProfileScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _club = TextEditingController();

  late FocusNode _nameFocus;
  late FocusNode _phoneFocus;
  late FocusNode _clubFocus;

  @override
  void initState() {
    super.initState();
    _nameFocus = FocusNode();
    _phoneFocus = FocusNode();
    _clubFocus = FocusNode();
    _applyInitial(widget.initial);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final f = widget.focus;
      if (f is String) {
        switch (f.toLowerCase()) {
          case 'name':
          case 'fio':
          case 'fullname':
            _nameFocus.requestFocus();
            break;
          case 'phone':
            _phoneFocus.requestFocus();
            break;
          case 'club':
          case 'workplace':
          case 'currentclub':
            _clubFocus.requestFocus();
            break;
        }
      } else if (f is FocusNode) {
        f.requestFocus();
      }
    });
  }

  void _applyInitial(dynamic initial) {
    Map<String, dynamic>? map;
    if (initial is Map<String, dynamic>) {
      map = initial;
    } else {
      try {
        final j = initial?.toJson();
        if (j is Map<String, dynamic>) map = j;
      } catch (_) {}
    }
    if (map != null) {
      _name.text = _pick(map, ['fullName', 'fio', 'name']) ?? _name.text;
      _phone.text = _pick(map, ['phone']) ?? _phone.text;
      _club.text = _pick(map, ['club', 'workplace', 'currentClub']) ?? _club.text;
    }
  }

  String? _pick(Map<String, dynamic> m, List<String> keys) {
    for (final k in keys) {
      final v = m[k];
      if (v is String && v.trim().isNotEmpty) return v;
    }
    return null;
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _club.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _clubFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.typo;

    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль механика', style: t.sectionTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Основное', style: t.mainWelcomeTitle.copyWith(fontSize: 24)),
          const SizedBox(height: 12),
          TextField(
            controller: _name,
            focusNode: _nameFocus,
            decoration: const InputDecoration(labelText: 'ФИО'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phone,
            focusNode: _phoneFocus,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Телефон'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _club,
            focusNode: _clubFocus,
            decoration: const InputDecoration(labelText: 'Клуб'),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Сохранить'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Отмена'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (widget.mechanicId != null)
            Text('ID: ${widget.mechanicId}', style: t.formHint),
        ],
      ),
    );
  }
}
