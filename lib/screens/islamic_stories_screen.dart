import 'package:flutter/material.dart';

class IslamicStoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('القصص الإسلامية'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_stories,
              size: 100,
              color: Colors.pink[700],
            ),
            SizedBox(height: 20),
            Text(
              'القصص الإسلامية',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'سيتم إضافة المحتوى قريباً',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}