import 'package:flutter/material.dart';

class AppColors {
  // الألوان الأساسية
  static const Color primaryDark = Color(0xFF1A1D2E);     // كحلي داكن
  static const Color sandyBeige = Color(0xFFF7F2E8);      // رملي ناعم
  static const Color lightGold = Color(0xFFC5A96D);       // ذهبي فاتح
  static const Color emeraldGreen = Color(0xFF0A957A);    // أخضر زمردي
  
  // ألوان إضافية
  static const Color softWhite = Color(0xFFFCFCFC);
  static const Color lightGray = Color(0xFFE8E8E8);
  static const Color mediumGray = Color(0xFF9E9E9E);
  static const Color darkGray = Color(0xFF424242);
  
  // ألوان الحالة
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // تدرجات للخلفيات
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1A1D2E),
      Color(0xFF2A2D3E),
    ],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF7F2E8),
      Color(0xFFEDE8DC),
    ],
  );
  
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFC5A96D),
      Color(0xFFB8956A),
    ],
  );
  
  // ألوان الوضع الليلي
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkOnSurface = Color(0xFFE1E1E1);
  
  // ظلال ناعمة
  static const List<BoxShadow> softShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
  
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x15000000),
      blurRadius: 12,
      offset: Offset(0, 6),
    ),
  ];
}