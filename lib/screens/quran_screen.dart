import 'package:flutter/material.dart';
import '../constants/app_strings.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.quran),
      ),
      body: const Center(
        child: Text('شاشة المصحف - قيد التطوير'),
      ),
    );
  }
}