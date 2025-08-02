import 'package:flutter/material.dart';
import 'quran_reader_screen.dart';
import 'tasbih_screen.dart';
import 'prayer_times_screen.dart';
import 'qibla_screen.dart';
import 'adhkar_screen.dart';
import 'islamic_education_screen.dart';
import 'islamic_stories_screen.dart';

class HomeScreen extends StatelessWidget {
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
              Colors.green[700]!,
              Colors.green[50]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
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
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.mosque,
                    size: 60,
                    color: Colors.green[700],
                  ),
                ),
                
                SizedBox(height: 20),
                
                Text(
                  'اعرف دينك',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                
                Text(
                  'تطبيق إسلامي شامل',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                
                SizedBox(height: 40),
                
                // شبكة الميزات
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                    children: [
                      _buildFeatureCard(
                        context,
                        'المصحف الشريف',
                        Icons.book,
                        Colors.green[700]!,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuranReaderScreen(),
                          ),
                        ),
                      ),
                      _buildFeatureCard(
                        context,
                        'السبحة الإلكترونية',
                        Icons.radio_button_checked,
                        Colors.blue[700]!,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TasbihScreen(),
                          ),
                        ),
                      ),
                      _buildFeatureCard(
                        context,
                        'مواقيت الصلاة',
                        Icons.schedule,
                        Colors.orange[700]!,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrayerTimesScreen(),
                          ),
                        ),
                      ),
                      _buildFeatureCard(
                        context,
                        'اتجاه القبلة',
                        Icons.explore,
                        Colors.purple[700]!,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QiblaScreen(),
                          ),
                        ),
                      ),
                      _buildFeatureCard(
                        context,
                        'الأذكار',
                        Icons.auto_awesome,
                        Colors.teal[700]!,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdhkarScreen(),
                          ),
                        ),
                      ),
                      _buildFeatureCard(
                        context,
                        'التعليم الإسلامي',
                        Icons.school,
                        Colors.indigo[700]!,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IslamicEducationScreen(),
                          ),
                        ),
                      ),
                      _buildFeatureCard(
                        context,
                        'القصص الإسلامية',
                        Icons.auto_stories,
                        Colors.pink[700]!,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IslamicStoriesScreen(),
                          ),
                        ),
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

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}