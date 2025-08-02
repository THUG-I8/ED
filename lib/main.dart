import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اعرف دينك',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[700],
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[700],
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: SimpleHomeScreen(),
    );
  }
}

class SimpleHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اعرف دينك'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1B5E20),
              Color(0xFF2E7D32),
              Color(0xFF388E3C),
              Color(0xFF4CAF50),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // شعار التطبيق
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.mosque,
                    size: 60,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                SizedBox(height: 30),
                
                // عنوان التطبيق
                Text(
                  'اعرف دينك',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'تطبيق إسلامي شامل',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 50),
                
                // الميزات
                _buildFeatureCard(context, 'المصحف الشريف', Icons.book, Colors.white),
                SizedBox(height: 15),
                _buildFeatureCard(context, 'السبحة الإلكترونية', Icons.radio_button_checked, Colors.white),
                SizedBox(height: 15),
                _buildFeatureCard(context, 'مواقيت الصلاة', Icons.schedule, Colors.white),
                SizedBox(height: 15),
                _buildFeatureCard(context, 'اتجاه القبلة', Icons.explore, Colors.white),
                SizedBox(height: 15),
                _buildFeatureCard(context, 'الأذكار', Icons.auto_awesome, Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),
          SizedBox(width: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: color.withOpacity(0.7),
            size: 20,
          ),
        ],
      ),
    );
  }
}
