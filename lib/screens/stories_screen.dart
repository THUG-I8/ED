import 'package:flutter/material.dart';
import '../constants/app_strings.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.stories),
      ),
      body: const Center(
        child: Text('شاشة القصص - قيد التطوير'),
      ),
    );
  }
}