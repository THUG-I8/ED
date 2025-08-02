import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranSettingsProvider extends ChangeNotifier {
  static const String _fontFamilyKey = 'quran_font_family';
  static const String _fontSizeKey = 'quran_font_size';
  static const String _lineSpacingKey = 'quran_line_spacing';
  static const String _backgroundColorKey = 'quran_background_color';
  static const String _textColorKey = 'quran_text_color';
  static const String _showTranslationKey = 'quran_show_translation';

  // الإعدادات الافتراضية
  String _fontFamily = 'Amiri';
  double _fontSize = 24.0;
  double _lineSpacing = 1.5;
  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;
  bool _showTranslation = true;

  // Getters
  String get fontFamily => _fontFamily;
  double get fontSize => _fontSize;
  double get lineSpacing => _lineSpacing;
  Color get backgroundColor => _backgroundColor;
  Color get textColor => _textColor;
  bool get showTranslation => _showTranslation;

  // الخطوط المتاحة - محدثة مع API الجديد
  static const List<String> availableFonts = [
    'Amiri',
    'Cairo',
    'Uthmanic',
    'KFGQPC',
    'Scheherazade',
    'Noto Naskh Arabic',
    'Noto Sans Arabic',
    'Almarai',
    'Tajawal',
    'Reem Kufi',
    'Harmattan',
    'Lateef',
    'Aref Ruqaa',
    'Changa',
    'IBM Plex Sans Arabic',
  ];

  // أسماء الخطوط العربية
  static const Map<String, String> fontDisplayNames = {
    'Amiri': 'أميري',
    'Cairo': 'القاهرة',
    'Uthmanic': 'عثماني',
    'KFGQPC': 'كوفي',
    'Scheherazade': 'شهرزاد',
    'Noto Naskh Arabic': 'نوتو نسخ',
    'Noto Sans Arabic': 'نوتو سانس',
    'Almarai': 'المراعي',
    'Tajawal': 'تجوال',
    'Reem Kufi': 'ريم كوفي',
    'Harmattan': 'حرتان',
    'Lateef': 'لطيف',
    'Aref Ruqaa': 'عارف رقعة',
    'Changa': 'تشانجا',
    'IBM Plex Sans Arabic': 'آي بي إم بلكس',
  };

  // الألوان المتاحة
  static const List<Color> availableColors = [
    Colors.white,
    Color(0xFFF8F6F1),
    Color(0xFFE6F3FF),
    Color(0xFFFFF8E1),
    Color(0xFFF3E5F5),
  ];

  QuranSettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    _fontFamily = prefs.getString(_fontFamilyKey) ?? 'Amiri';
    _fontSize = prefs.getDouble(_fontSizeKey) ?? 24.0;
    _lineSpacing = prefs.getDouble(_lineSpacingKey) ?? 1.5;
    _backgroundColor = Color(prefs.getInt(_backgroundColorKey) ?? Colors.white.value);
    _textColor = Color(prefs.getInt(_textColorKey) ?? Colors.black.value);
    _showTranslation = prefs.getBool(_showTranslationKey) ?? true;
    
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setString(_fontFamilyKey, _fontFamily);
    await prefs.setDouble(_fontSizeKey, _fontSize);
    await prefs.setDouble(_lineSpacingKey, _lineSpacing);
    await prefs.setInt(_backgroundColorKey, _backgroundColor.value);
    await prefs.setInt(_textColorKey, _textColor.value);
    await prefs.setBool(_showTranslationKey, _showTranslation);
  }

  void setFontFamily(String fontFamily) {
    if (availableFonts.contains(fontFamily)) {
      _fontFamily = fontFamily;
      _saveSettings();
      notifyListeners();
    }
  }

  void setFontSize(double fontSize) {
    if (fontSize >= 16.0 && fontSize <= 40.0) {
      _fontSize = fontSize;
      _saveSettings();
      notifyListeners();
    }
  }

  void setLineSpacing(double lineSpacing) {
    if (lineSpacing >= 1.0 && lineSpacing <= 3.0) {
      _lineSpacing = lineSpacing;
      _saveSettings();
      notifyListeners();
    }
  }

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    _saveSettings();
    notifyListeners();
  }

  void setTextColor(Color color) {
    _textColor = color;
    _saveSettings();
    notifyListeners();
  }

  void toggleTranslation() {
    _showTranslation = !_showTranslation;
    _saveSettings();
    notifyListeners();
  }

  void resetToDefaults() {
    _fontFamily = 'Amiri';
    _fontSize = 24.0;
    _lineSpacing = 1.5;
    _backgroundColor = Colors.white;
    _textColor = Colors.black;
    _showTranslation = true;
    
    _saveSettings();
    notifyListeners();
  }
}