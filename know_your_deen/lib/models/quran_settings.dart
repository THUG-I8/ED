import 'package:flutter/material.dart';

class QuranSettings {
  static const String _fontFamilyKey = 'quran_font_family';
  static const String _fontSizeKey = 'quran_font_size';
  static const String _lineSpacingKey = 'quran_line_spacing';
  static const String _backgroundColorKey = 'quran_background_color';
  static const String _textColorKey = 'quran_text_color';
  static const String _showTranslationKey = 'quran_show_translation';
  static const String _translationLanguageKey = 'quran_translation_language';

  // قائمة الخطوط المتاحة
  static const List<QuranFont> availableFonts = [
    QuranFont('Uthmanic', 'Uthmanic', 'خط عثماني - رسم عثماني'),
    QuranFont('KFGQPC', 'KFGQPC', 'خط كوفي - رسم عثماني'),
    QuranFont('Scheherazade', 'Scheherazade', 'خط شهرزاد - خط واضح'),
    QuranFont('Amiri', 'Amiri', 'خط أميري - خط أنيق'),
    QuranFont('Cairo', 'Cairo', 'خط القاهرة - خط حديث'),
  ];

  // أحجام الخطوط المتاحة
  static const List<double> availableFontSizes = [
    16.0, 18.0, 20.0, 22.0, 24.0, 26.0, 28.0, 30.0, 32.0, 34.0, 36.0, 38.0, 40.0
  ];

  // المسافات بين الأسطر
  static const List<double> availableLineSpacings = [
    1.0, 1.2, 1.4, 1.6, 1.8, 2.0, 2.2, 2.4, 2.6, 2.8, 3.0
  ];

  // ألوان الخلفية
  static const List<Color> availableBackgroundColors = [
    Color(0xFFF8F6F1), // كريمي فاتح
    Color(0xFFFFFFFF), // أبيض
    Color(0xFFF0F8FF), // أزرق فاتح جداً
    Color(0xFFF5F5DC), // بيج فاتح
    Color(0xFFE6F3FF), // أزرق فاتح
    Color(0xFFF0F0F0), // رمادي فاتح
    Color(0xFF2C3E50), // أزرق داكن (للقراءة الليلية)
    Color(0xFF1A1A1A), // أسود (للقراءة الليلية)
  ];

  // ألوان النص
  static const List<Color> availableTextColors = [
    Color(0xFF2C3E50), // أزرق داكن
    Color(0xFF000000), // أسود
    Color(0xFF1B4F72), // أزرق غامق
    Color(0xFF2E4053), // رمادي داكن
    Color(0xFFFFFFFF), // أبيض (للخلفيات الداكنة)
    Color(0xFFE8F4FD), // أبيض فاتح (للخلفيات الداكنة)
  ];

  // الإعدادات الافتراضية
  static const QuranSettings defaultSettings = QuranSettings(
    fontFamily: 'Uthmanic',
    fontSize: 24.0,
    lineSpacing: 1.6,
    backgroundColor: Color(0xFFF8F6F1),
    textColor: Color(0xFF2C3E50),
    showTranslation: false,
    translationLanguage: 'ar',
  );

  final String fontFamily;
  final double fontSize;
  final double lineSpacing;
  final Color backgroundColor;
  final Color textColor;
  final bool showTranslation;
  final String translationLanguage;

  const QuranSettings({
    required this.fontFamily,
    required this.fontSize,
    required this.lineSpacing,
    required this.backgroundColor,
    required this.textColor,
    required this.showTranslation,
    required this.translationLanguage,
  });

  // نسخ مع تحديث
  QuranSettings copyWith({
    String? fontFamily,
    double? fontSize,
    double? lineSpacing,
    Color? backgroundColor,
    Color? textColor,
    bool? showTranslation,
    String? translationLanguage,
  }) {
    return QuranSettings(
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      lineSpacing: lineSpacing ?? this.lineSpacing,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      showTranslation: showTranslation ?? this.showTranslation,
      translationLanguage: translationLanguage ?? this.translationLanguage,
    );
  }

  // تحويل إلى Map للحفظ
  Map<String, dynamic> toMap() {
    return {
      _fontFamilyKey: fontFamily,
      _fontSizeKey: fontSize,
      _lineSpacingKey: lineSpacing,
      _backgroundColorKey: backgroundColor.value,
      _textColorKey: textColor.value,
      _showTranslationKey: showTranslation,
      _translationLanguageKey: translationLanguage,
    };
  }

  // إنشاء من Map
  factory QuranSettings.fromMap(Map<String, dynamic> map) {
    return QuranSettings(
      fontFamily: map[_fontFamilyKey] ?? defaultSettings.fontFamily,
      fontSize: map[_fontSizeKey]?.toDouble() ?? defaultSettings.fontSize,
      lineSpacing: map[_lineSpacingKey]?.toDouble() ?? defaultSettings.lineSpacing,
      backgroundColor: Color(map[_backgroundColorKey] ?? defaultSettings.backgroundColor.value),
      textColor: Color(map[_textColorKey] ?? defaultSettings.textColor.value),
      showTranslation: map[_showTranslationKey] ?? defaultSettings.showTranslation,
      translationLanguage: map[_translationLanguageKey] ?? defaultSettings.translationLanguage,
    );
  }
}

class QuranFont {
  final String name;
  final String family;
  final String description;

  const QuranFont(this.name, this.family, this.description);
}