import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quran_settings_provider.dart';
import 'screens/quran_reader_screen.dart';
import 'screens/islamic_education_screen.dart';
import 'screens/adhkar_screen.dart';
import 'screens/tasbih_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuranSettingsProvider()),
      ],
      child: MaterialApp(
        title: 'اعرف دينك',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF2C3E50),
          scaffoldBackgroundColor: const Color(0xFFF8F6F1),
          fontFamily: 'Cairo',
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2C3E50),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2C3E50),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        home: const HomeScreen(),
        locale: const Locale('ar', 'SA'),
        supportedLocales: const [
          Locale('ar', 'SA'),
          Locale('en', 'US'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اعرف دينك'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8F6F1),
              Color(0xFFE6F3FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // شعار التطبيق
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C3E50),
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.mosque,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // عنوان التطبيق
                const Text(
                  'اعرف دينك',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                
                const SizedBox(height: 10),
                
                const Text(
                  'تطبيق إسلامي شامل',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF7F8C8D),
                  ),
                ),
                
                const SizedBox(height: 50),
                
                // قائمة المميزات
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      _buildFeatureCard(
                        context,
                        'المصحف الشريف',
                        Icons.menu_book,
                        const Color(0xFF3498DB),
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuranReaderScreen(),
                          ),
                        ),
                      ),
                      _buildFeatureCard(
                        context,
                        'السبحة الإلكترونية',
                        Icons.beads,
                        const Color(0xFFE74C3C),
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TasbihScreen(),
                            ),
                          );
                        },
                      ),
                      _buildFeatureCard(
                        context,
                        'مواقيت الصلاة',
                        Icons.access_time,
                        const Color(0xFF2ECC71),
                        () {
                          // سيتم إضافة شاشة مواقيت الصلاة لاحقاً
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('قريباً - مواقيت الصلاة')),
                          );
                        },
                      ),
                      _buildFeatureCard(
                        context,
                        'اتجاه القبلة',
                        Icons.explore,
                        const Color(0xFFF39C12),
                        () {
                          // سيتم إضافة شاشة اتجاه القبلة لاحقاً
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('قريباً - اتجاه القبلة')),
                          );
                        },
                      ),
                      _buildFeatureCard(
                        context,
                        'الأذكار',
                        Icons.favorite,
                        const Color(0xFF9B59B6),
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdhkarScreen(),
                            ),
                          );
                        },
                      ),
                                             _buildFeatureCard(
                         context,
                         'التعليم الإسلامي',
                         Icons.school,
                         const Color(0xFF1ABC9C),
                         () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => const IslamicEducationScreen(),
                             ),
                           );
                         },
                       ),
                       _buildFeatureCard(
                         context,
                         'القصص الإسلامية',
                         Icons.auto_stories,
                         const Color(0xFFE91E63),
                         () {
                           // سيتم إضافة شاشة القصص لاحقاً
                           ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(content: Text('قريباً - القصص الإسلامية')),
                           );
                         },
                       ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // معلومات إضافية
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, color: Color(0xFF7F8C8D)),
                      SizedBox(width: 8),
                      Text(
                        'تطبيق مجاني ومفتوح المصدر',
                        style: TextStyle(
                          color: Color(0xFF7F8C8D),
                          fontSize: 14,
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
              offset: const Offset(0, 5),
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
                size: 30,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
