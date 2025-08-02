import 'package:flutter/material.dart';

class PrayerTimesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مواقيت الصلاة'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.schedule,
              size: 100,
              color: Colors.orange[700],
            ),
            SizedBox(height: 20),
            Text(
              'مواقيت الصلاة',
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