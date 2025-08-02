import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quran_settings.dart';

class QuranSettingsProvider extends ChangeNotifier {
  QuranSettings _settings = QuranSettings.defaultSettings;
  bool _isLoading = false;

  QuranSettings get settings => _settings;
  bool get isLoading => _isLoading;

  QuranSettingsProvider() {
    _loadSettings();
  }

  // تحميل الإعدادات المحفوظة
  Future<void> _loadSettings() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsMap = <String, dynamic>{};
      
      // تحميل كل الإعدادات
      for (final key in [
        QuranSettings._fontFamilyKey,
        QuranSettings._fontSizeKey,
        QuranSettings._lineSpacingKey,
        QuranSettings._backgroundColorKey,
        QuranSettings._textColorKey,
        QuranSettings._showTranslationKey,
        QuranSettings._translationLanguageKey,
      ]) {
        final value = prefs.get(key);
        if (value != null) {
          settingsMap[key] = value;
        }
      }

      if (settingsMap.isNotEmpty) {
        _settings = QuranSettings.fromMap(settingsMap);
      }
    } catch (e) {
      debugPrint('خطأ في تحميل إعدادات المصحف: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // حفظ الإعدادات
  Future<void> _saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsMap = _settings.toMap();
      
      for (final entry in settingsMap.entries) {
        await prefs.setString(entry.key, entry.value.toString());
      }
    } catch (e) {
      debugPrint('خطأ في حفظ إعدادات المصحف: $e');
    }
  }

  // تحديث عائلة الخط
  Future<void> updateFontFamily(String fontFamily) async {
    _settings = _settings.copyWith(fontFamily: fontFamily);
    await _saveSettings();
    notifyListeners();
  }

  // تحديث حجم الخط
  Future<void> updateFontSize(double fontSize) async {
    _settings = _settings.copyWith(fontSize: fontSize);
    await _saveSettings();
    notifyListeners();
  }

  // تحديث المسافة بين الأسطر
  Future<void> updateLineSpacing(double lineSpacing) async {
    _settings = _settings.copyWith(lineSpacing: lineSpacing);
    await _saveSettings();
    notifyListeners();
  }

  // تحديث لون الخلفية
  Future<void> updateBackgroundColor(Color backgroundColor) async {
    _settings = _settings.copyWith(backgroundColor: backgroundColor);
    await _saveSettings();
    notifyListeners();
  }

  // تحديث لون النص
  Future<void> updateTextColor(Color textColor) async {
    _settings = _settings.copyWith(textColor: textColor);
    await _saveSettings();
    notifyListeners();
  }

  // تبديل عرض الترجمة
  Future<void> toggleTranslation() async {
    _settings = _settings.copyWith(showTranslation: !_settings.showTranslation);
    await _saveSettings();
    notifyListeners();
  }

  // تحديث لغة الترجمة
  Future<void> updateTranslationLanguage(String language) async {
    _settings = _settings.copyWith(translationLanguage: language);
    await _saveSettings();
    notifyListeners();
  }

  // إعادة تعيين الإعدادات للافتراضية
  Future<void> resetToDefault() async {
    _settings = QuranSettings.defaultSettings;
    await _saveSettings();
    notifyListeners();
  }

  // تحديث جميع الإعدادات مرة واحدة
  Future<void> updateAllSettings(QuranSettings newSettings) async {
    _settings = newSettings;
    await _saveSettings();
    notifyListeners();
  }

  // الحصول على الخط الحالي
  QuranFont? getCurrentFont() {
    try {
      return QuranSettings.availableFonts.firstWhere(
        (font) => font.family == _settings.fontFamily,
      );
    } catch (e) {
      return QuranSettings.availableFonts.first;
    }
  }

  // التحقق من أن الخط متاح
  bool isFontAvailable(String fontFamily) {
    return QuranSettings.availableFonts.any((font) => font.family == fontFamily);
  }

  // الحصول على حجم الخط التالي
  double getNextFontSize() {
    final currentIndex = QuranSettings.availableFontSizes.indexOf(_settings.fontSize);
    if (currentIndex < QuranSettings.availableFontSizes.length - 1) {
      return QuranSettings.availableFontSizes[currentIndex + 1];
    }
    return _settings.fontSize;
  }

  // الحصول على حجم الخط السابق
  double getPreviousFontSize() {
    final currentIndex = QuranSettings.availableFontSizes.indexOf(_settings.fontSize);
    if (currentIndex > 0) {
      return QuranSettings.availableFontSizes[currentIndex - 1];
    }
    return _settings.fontSize;
  }

  // التحقق من إمكانية تكبير الخط
  bool canIncreaseFontSize() {
    return _settings.fontSize < QuranSettings.availableFontSizes.last;
  }

  // التحقق من إمكانية تصغير الخط
  bool canDecreaseFontSize() {
    return _settings.fontSize > QuranSettings.availableFontSizes.first;
  }
}