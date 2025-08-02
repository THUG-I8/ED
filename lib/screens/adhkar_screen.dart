import 'package:flutter/material.dart';

class AdhkarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الأذكار'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal[700]!,
              Colors.teal[50]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                // عنوان
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 50,
                        color: Colors.teal[700],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'أذكار الصباح والمساء',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20),
                
                // قائمة الأذكار
                Expanded(
                  child: ListView(
                    children: [
                      _buildDhikrCard(
                        'أذكار الصباح',
                        'أذكار تقال في الصباح',
                        Icons.wb_sunny,
                        Colors.orange,
                      ),
                      _buildDhikrCard(
                        'أذكار المساء',
                        'أذكار تقال في المساء',
                        Icons.nightlight_round,
                        Colors.indigo,
                      ),
                      _buildDhikrCard(
                        'أذكار النوم',
                        'أذكار تقال قبل النوم',
                        Icons.bedtime,
                        Colors.purple,
                      ),
                      _buildDhikrCard(
                        'أذكار الاستيقاظ',
                        'أذكار تقال عند الاستيقاظ',
                        Icons.wb_sunny_outlined,
                        Colors.amber,
                      ),
                      _buildDhikrCard(
                        'أذكار المسجد',
                        'أذكار تقال عند دخول المسجد',
                        Icons.mosque,
                        Colors.green,
                      ),
                      _buildDhikrCard(
                        'أذكار عامة',
                        'أذكار متنوعة',
                        Icons.auto_awesome,
                        Colors.teal,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDhikrCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // سيتم إضافة محتوى الأذكار لاحقاً
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}