import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/app_bottom_nav.dart';
import '../utils/bottom_nav.dart';
import '../services/kb_repository.dart';
import '../models/kb_pdf.dart';
import '../widgets/kb_list_tile.dart';
import 'pdf_reader_screen.dart';

class KnowledgeBaseScreen extends StatefulWidget {
  const KnowledgeBaseScreen({Key? key}) : super(key: key);

  @override
  State<KnowledgeBaseScreen> createState() => _KnowledgeBaseScreenState();
}

class _KnowledgeBaseScreenState extends State<KnowledgeBaseScreen> {
  late Future<List<KbPdf>> _future;

  @override
  void initState() {
    super.initState();
    _future = KbRepository.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F9),
        elevation: 0,
        title: const Text('База знаний', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        actions: [IconButton(onPressed: () => setState(() => _future = KbRepository.load()), icon: const Icon(Icons.sync), color: AppColors.primary)],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFE9E9E9)), borderRadius: BorderRadius.circular(14)),
            child: const Text('Инструкции', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          ),
          const SizedBox(height: 10),
          FutureBuilder<List<KbPdf>>(
            future: _future,
            builder: (context, s) {
              if (!s.hasData) {
                return const Padding(
                  padding: EdgeInsets.only(top: 32),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final items = s.data!;
              return Column(
                children: List.generate(items.length, (i) {
                  final it = items[i];
                  return Padding(
                    padding: EdgeInsets.only(bottom: i == items.length - 1 ? 0 : 10),
                    child: KbListTile(
                      title: it.title,
                      accent: i == 0,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => PdfReaderScreen(doc: it)));
                      },
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 3,
        onTap: (i) => BottomNavDirect.go(context, 3, i),
      ),
    );
  }
}
