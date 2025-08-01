import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/app_colors.dart';
import 'constants/app_strings.dart';
import 'providers/story_provider.dart';
import 'providers/dhikr_provider.dart';
import 'providers/prayer_time_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // تعيين اتجاه الشاشة
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  // تخصيص شريط الحالة
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.primaryDark,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const KnowYourDeenApp());
}

class KnowYourDeenApp extends StatelessWidget {
  const KnowYourDeenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => StoryProvider()),
        ChangeNotifierProvider(create: (_) => DhikrProvider()),
        ChangeNotifierProvider(create: (_) => PrayerTimeProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            
            // دعم العربية
            locale: const Locale('ar'),
            supportedLocales: const [
              Locale('ar', ''), // العربية
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            
            // تخصيص الثيم
            theme: _buildLightTheme(),
            darkTheme: _buildDarkTheme(),
            themeMode: settingsProvider.isDarkMode 
                ? ThemeMode.dark 
                : ThemeMode.light,
            
            // الصفحة الرئيسية
            home: const SplashScreen(),
          );
        },
      ),
    );
  }

  // الثيم الفاتح
  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryDark,
        brightness: Brightness.light,
        primary: AppColors.primaryDark,
        secondary: AppColors.lightGold,
        surface: AppColors.sandyBeige,
        background: AppColors.softWhite,
      ),
      
      // الخطوط العربية
      textTheme: GoogleFonts.cairoTextTheme().copyWith(
        headlineLarge: GoogleFonts.amiri(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryDark,
        ),
        headlineMedium: GoogleFonts.amiri(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryDark,
        ),
        bodyLarge: GoogleFonts.cairo(
          fontSize: 16,
          color: AppColors.darkGray,
        ),
        bodyMedium: GoogleFonts.cairo(
          fontSize: 14,
          color: AppColors.darkGray,
        ),
      ),
      
      // شريط التطبيق
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.amiri(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      
      // البطاقات
      cardTheme: CardTheme(
        elevation: 4,
        shadowColor: AppColors.primaryDark.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // الأزرار المرتفعة
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // الأزرار المخططة
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryDark,
          side: const BorderSide(color: AppColors.primaryDark, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // FAB
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.lightGold,
        foregroundColor: Colors.white,
        elevation: 6,
      ),
      
      // شريط التنقل السفلي
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.softWhite,
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: AppColors.mediumGray,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.cairo(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.cairo(
          fontSize: 12,
        ),
      ),
      
      // إعدادات إضافية
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // الثيم الداكن
  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryDark,
        brightness: Brightness.dark,
        primary: AppColors.lightGold,
        secondary: AppColors.emeraldGreen,
        surface: AppColors.darkSurface,
        background: AppColors.darkBackground,
      ),
      
      textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme).copyWith(
        headlineLarge: GoogleFonts.amiri(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.lightGold,
        ),
        headlineMedium: GoogleFonts.amiri(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.lightGold,
        ),
        bodyLarge: GoogleFonts.cairo(
          fontSize: 16,
          color: AppColors.darkOnSurface,
        ),
        bodyMedium: GoogleFonts.cairo(
          fontSize: 14,
          color: AppColors.darkOnSurface,
        ),
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.lightGold,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.amiri(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.lightGold,
        ),
      ),
      
      cardTheme: CardTheme(
        color: AppColors.darkSurface,
        elevation: 4,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightGold,
          foregroundColor: AppColors.darkBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.lightGold,
          side: const BorderSide(color: AppColors.lightGold, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.lightGold,
        foregroundColor: AppColors.darkBackground,
        elevation: 6,
      ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.lightGold,
        unselectedItemColor: AppColors.mediumGray,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.cairo(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.cairo(
          fontSize: 12,
        ),
      ),
      
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}