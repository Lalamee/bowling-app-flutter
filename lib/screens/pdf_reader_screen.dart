import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import '../theme/colors.dart';
import '../widgets/app_bottom_nav.dart';
import '../utils/bottom_nav.dart';
import '../models/kb_pdf.dart';

class PdfReaderScreen extends StatefulWidget {
  final KbPdf doc;
  const PdfReaderScreen({Key? key, required this.doc}) : super(key: key);

  @override
  State<PdfReaderScreen> createState() => _PdfReaderScreenState();
}

class _PdfReaderScreenState extends State<PdfReaderScreen> {
  late final PdfControllerPinch _controller;

  @override
  void initState() {
    super.initState();
    _controller = PdfControllerPinch(document: PdfDocument.openAsset(widget.doc.assetPath));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('База знаний', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.sync), color: AppColors.primary)],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: PdfViewPinch(
              controller: _controller,
              backgroundDecoration: const BoxDecoration(color: Colors.white),
            ),
          ),
          Positioned(
            right: 12,
            top: 12,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary, width: 1.5),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.close, size: 18, color: AppColors.primary),
              ),
            ),
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
