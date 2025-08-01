import 'package:flutter/material.dart';
import '../constants/app_strings.dart';

class TasbihScreen extends StatelessWidget {
  const TasbihScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.tasbih),
      ),
      body: const Center(
        child: Text('شاشة السبحة - قيد التطوير'),
      ),
    );
  }
}