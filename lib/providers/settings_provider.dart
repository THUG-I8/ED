import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  double _fontSize = 16.0;
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _prayerRemindersEnabled = true;
  bool _dailyStoryReminderEnabled = true;

  // Getters
  bool get isDarkMode => _isDarkMode;
  double get fontSize => _fontSize;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get soundEnabled => _soundEnabled;
  bool get vibrationEnabled => _vibrationEnabled;
  bool get prayerRemindersEnabled => _prayerRemindersEnabled;
  bool get dailyStoryReminderEnabled => _dailyStoryReminderEnabled;

  SettingsProvider() {
    _loadSettings();
  }

  // تحميل الإعدادات
  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _fontSize = prefs.getDouble('fontSize') ?? 16.0;
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      _soundEnabled = prefs.getBool('soundEnabled') ?? true;
      _vibrationEnabled = prefs.getBool('vibrationEnabled') ?? true;
      _prayerRemindersEnabled = prefs.getBool('prayerRemindersEnabled') ?? true;
      _dailyStoryReminderEnabled = prefs.getBool('dailyStoryReminderEnabled') ?? true;
      notifyListeners();
    } catch (e) {
      debugPrint('خطأ في تحميل الإعدادات: $e');
    }
  }

  // تغيير الوضع الليلي
  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    await _saveSettings();
  }

  // تغيير حجم الخط
  Future<void> setFontSize(double size) async {
    _fontSize = size;
    notifyListeners();
    await _saveSettings();
  }

  // تفعيل/إلغاء الإشعارات
  Future<void> toggleNotifications() async {
    _notificationsEnabled = !_notificationsEnabled;
    notifyListeners();
    await _saveSettings();
  }

  // تفعيل/إلغاء الصوت
  Future<void> toggleSound() async {
    _soundEnabled = !_soundEnabled;
    notifyListeners();
    await _saveSettings();
  }

  // تفعيل/إلغاء الاهتزاز
  Future<void> toggleVibration() async {
    _vibrationEnabled = !_vibrationEnabled;
    notifyListeners();
    await _saveSettings();
  }

  // تفعيل/إلغاء تذكير الصلاة
  Future<void> togglePrayerReminders() async {
    _prayerRemindersEnabled = !_prayerRemindersEnabled;
    notifyListeners();
    await _saveSettings();
  }

  // تفعيل/إلغاء تذكير القصة اليومية
  Future<void> toggleDailyStoryReminder() async {
    _dailyStoryReminderEnabled = !_dailyStoryReminderEnabled;
    notifyListeners();
    await _saveSettings();
  }

  // حفظ الإعدادات
  Future<void> _saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', _isDarkMode);
      await prefs.setDouble('fontSize', _fontSize);
      await prefs.setBool('notificationsEnabled', _notificationsEnabled);
      await prefs.setBool('soundEnabled', _soundEnabled);
      await prefs.setBool('vibrationEnabled', _vibrationEnabled);
      await prefs.setBool('prayerRemindersEnabled', _prayerRemindersEnabled);
      await prefs.setBool('dailyStoryReminderEnabled', _dailyStoryReminderEnabled);
    } catch (e) {
      debugPrint('خطأ في حفظ الإعدادات: $e');
    }
  }

  // إعادة تعيين الإعدادات
  Future<void> resetSettings() async {
    _isDarkMode = false;
    _fontSize = 16.0;
    _notificationsEnabled = true;
    _soundEnabled = true;
    _vibrationEnabled = true;
    _prayerRemindersEnabled = true;
    _dailyStoryReminderEnabled = true;
    notifyListeners();
    await _saveSettings();
  }
}