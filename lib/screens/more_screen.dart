import 'package:flutter/material.dart';
import '../constants/app_strings.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.more),
      ),
      body: const Center(
        child: Text('شاشة المزيد - قيد التطوير'),
      ),
    );
  }
}