import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quran_settings_provider.dart';
import 'providers/quran_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuranSettingsProvider()),
        ChangeNotifierProvider(create: (_) => QuranProvider()),
      ],
      child: MaterialApp(
        title: 'اعرف دينك',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green[700],
          scaffoldBackgroundColor: Colors.grey[50],
          fontFamily: 'Cairo',
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
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
