import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import '../models/dhikr.dart';
import '../constants/app_strings.dart';

class DhikrProvider with ChangeNotifier {
  List<Dhikr> _adhkar = [];
  TasbihCounter? _currentTasbih;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Dhikr> get adhkar => _adhkar;
  TasbihCounter? get currentTasbih => _currentTasbih;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Dhikr> get morningAdhkar => 
      _adhkar.where((dhikr) => dhikr.category == 'أذكار الصباح').toList();

  List<Dhikr> get eveningAdhkar => 
      _adhkar.where((dhikr) => dhikr.category == 'أذكار المساء').toList();

  List<Dhikr> get tasbihAdhkar => 
      _adhkar.where((dhikr) => dhikr.category == 'التسبيح').toList();

  DhikrProvider() {
    _loadAdhkarData();
    _loadSavedTasbih();
  }

  // تحميل بيانات الأذكار
  Future<void> _loadAdhkarData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _loadSampleAdhkar();
      _isLoading = false;
    } catch (e) {
      _error = 'خطأ في تحميل الأذكار: $e';
      _isLoading = false;
    }
    notifyListeners();
  }

  // تحميل أذكار نموذجية
  Future<void> _loadSampleAdhkar() async {
    _adhkar = [
      // أذكار الصباح
      Dhikr(
        id: 1,
        arabic: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ وَالْحَمْدُ لِلَّهِ لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ',
        transliteration: 'Asbahna wa asbahal-mulku lillahi wal-hamdu lillahi la ilaha illa Allahu wahdahu la sharika lah',
        translation: 'أصبحنا وأصبح الملك لله، والحمد لله، لا إله إلا الله وحده لا شريك له',
        benefit: 'من قالها حين يصبح أجير من الجن حتى يمسي',
        recommendedCount: 1,
        category: 'أذكار الصباح',
        isDaily: true,
      ),
      
      Dhikr(
        id: 2,
        arabic: 'اللَّهُمَّ بِكَ أَصْبَحْنَا وَبِكَ أَمْسَيْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ',
        transliteration: 'Allahumma bika asbahna wa bika amsayna wa bika nahya wa bika namutu wa ilaykan-nushur',
        translation: 'اللهم بك أصبحنا وبك أمسينا وبك نحيا وبك نموت وإليك النشور',
        benefit: 'دعاء شامل للحماية والتوكل على الله',
        recommendedCount: 1,
        category: 'أذكار الصباح',
        isDaily: true,
      ),

      Dhikr(
        id: 3,
        arabic: 'أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ. اللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ',
        transliteration: 'A\'udhu billahi minash-shaytanir-rajim. Allahu la ilaha illa huwal-hayyul-qayyum',
        translation: 'أعوذ بالله من الشيطان الرجيم. الله لا إله إلا هو الحي القيوم',
        benefit: 'آية الكرسي - حرز من كل سوء',
        recommendedCount: 1,
        category: 'أذكار الصباح',
        isDaily: true,
      ),

      // أذكار المساء
      Dhikr(
        id: 4,
        arabic: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ وَالْحَمْدُ لِلَّهِ لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ',
        transliteration: 'Amsayna wa amsal-mulku lillahi wal-hamdu lillahi la ilaha illa Allahu wahdahu la sharika lah',
        translation: 'أمسينا وأمسى الملك لله، والحمد لله، لا إله إلا الله وحده لا شريك له',
        benefit: 'من قالها حين يمسي أجير من الجن حتى يصبح',
        recommendedCount: 1,
        category: 'أذكار المساء',
        isDaily: true,
      ),

      Dhikr(
        id: 5,
        arabic: 'اللَّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا وَبِكَ نَحْيَا وَبِكَ نَمُوتُ وَإِلَيْكَ الْمَصِيرُ',
        transliteration: 'Allahumma bika amsayna wa bika asbahna wa bika nahya wa bika namutu wa ilaykal-masir',
        translation: 'اللهم بك أمسينا وبك أصبحنا وبك نحيا وبك نموت وإليك المصير',
        benefit: 'دعاء شامل للحماية والتوكل على الله',
        recommendedCount: 1,
        category: 'أذكار المساء',
        isDaily: true,
      ),

      // التسبيح
      Dhikr(
        id: 6,
        arabic: 'سُبْحَانَ اللَّهِ',
        transliteration: 'Subhan Allah',
        translation: 'سبحان الله',
        benefit: 'تنزيه الله عن كل نقص، ثقيلة في الميزان',
        recommendedCount: 33,
        category: 'التسبيح',
        isDaily: true,
      ),

      Dhikr(
        id: 7,
        arabic: 'الْحَمْدُ لِلَّهِ',
        transliteration: 'Alhamdulillah',
        translation: 'الحمد لله',
        benefit: 'تملأ الميزان، وهي أفضل الذكر',
        recommendedCount: 33,
        category: 'التسبيح',
        isDaily: true,
      ),

      Dhikr(
        id: 8,
        arabic: 'اللَّهُ أَكْبَرُ',
        transliteration: 'Allahu Akbar',
        translation: 'الله أكبر',
        benefit: 'تملأ ما بين السماوات والأرض',
        recommendedCount: 34,
        category: 'التسبيح',
        isDaily: true,
      ),

      Dhikr(
        id: 9,
        arabic: 'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
        transliteration: 'La ilaha illa Allahu wahdahu la sharika lahu lahul-mulku wa lahul-hamdu wa huwa \'ala kulli shay\'in qadir',
        translation: 'لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير',
        benefit: 'من قالها مائة مرة في يوم كتب له ألف حسنة ومحيت عنه ألف سيئة',
        recommendedCount: 100,
        category: 'التسبيح',
        isDaily: true,
      ),

      // أذكار النوم
      Dhikr(
        id: 10,
        arabic: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
        transliteration: 'Bismika Allahumma amutu wa ahya',
        translation: 'باسمك اللهم أموت وأحيا',
        benefit: 'دعاء النوم، يحفظ المؤمن في منامه',
        recommendedCount: 1,
        category: 'أذكار النوم',
        isDaily: true,
      ),
    ];
  }

  // بدء السبحة
  void startTasbih(String dhikrText, {int targetCount = 33}) {
    _currentTasbih = TasbihCounter(
      dhikrText: dhikrText,
      targetCount: targetCount,
      startTime: DateTime.now(),
    );
    notifyListeners();
    _saveTasbih();
  }

  // زيادة عداد السبحة
  Future<void> incrementTasbih() async {
    if (_currentTasbih != null) {
      _currentTasbih!.increment();
      
      // اهتزاز عند كل 33
      if (_currentTasbih!.currentCount % 33 == 0 && 
          _currentTasbih!.enableVibration) {
        try {
          if (await Vibration.hasVibrator() ?? false) {
            Vibration.vibrate(duration: 100);
          }
        } catch (e) {
          debugPrint('خطأ في الاهتزاز: $e');
        }
      }

      notifyListeners();
      _saveTasbih();
    }
  }

  // إعادة تعيين السبحة
  void resetTasbih() {
    if (_currentTasbih != null) {
      _currentTasbih!.reset();
      notifyListeners();
      _saveTasbih();
    }
  }

  // إنهاء السبحة
  void stopTasbih() {
    _currentTasbih = null;
    notifyListeners();
    _clearSavedTasbih();
  }

  // حفظ حالة السبحة
  Future<void> _saveTasbih() async {
    if (_currentTasbih != null) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final tasbihJson = _currentTasbih!.toJson();
        await prefs.setString('currentTasbih', tasbihJson.toString());
      } catch (e) {
        debugPrint('خطأ في حفظ السبحة: $e');
      }
    }
  }

  // تحميل السبحة المحفوظة
  Future<void> _loadSavedTasbih() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasbihString = prefs.getString('currentTasbih');
      if (tasbihString != null) {
        // تحويل من string إلى Map وإنشاء TasbihCounter
        // هذا مبسط - في التطبيق الحقيقي نحتاج JSON parsing أفضل
      }
    } catch (e) {
      debugPrint('خطأ في تحميل السبحة: $e');
    }
  }

  // مسح السبحة المحفوظة
  Future<void> _clearSavedTasbih() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('currentTasbih');
    } catch (e) {
      debugPrint('خطأ في مسح السبحة: $e');
    }
  }

  // الحصول على ذكر بواسطة المعرف
  Dhikr? getDhikrById(int id) {
    try {
      return _adhkar.firstWhere((dhikr) => dhikr.id == id);
    } catch (e) {
      return null;
    }
  }

  // الحصول على الأذكار حسب التصنيف
  List<Dhikr> getAdhkarByCategory(String category) {
    return _adhkar.where((dhikr) => dhikr.category == category).toList();
  }

  // البحث في الأذكار
  List<Dhikr> searchAdhkar(String query) {
    if (query.isEmpty) return _adhkar;
    
    return _adhkar.where((dhikr) =>
        dhikr.arabic.contains(query) ||
        dhikr.translation.contains(query) ||
        dhikr.transliteration.toLowerCase().contains(query.toLowerCase()) ||
        dhikr.category.contains(query)
    ).toList();
  }

  // الحصول على ذكر اليوم
  Dhikr? getTodayDhikr() {
    final dailyAdhkar = _adhkar.where((dhikr) => dhikr.isDaily).toList();
    if (dailyAdhkar.isNotEmpty) {
      final today = DateTime.now();
      final dayOfYear = today.difference(DateTime(today.year, 1, 1)).inDays;
      final dhikrIndex = dayOfYear % dailyAdhkar.length;
      return dailyAdhkar[dhikrIndex];
    }
    return null;
  }

  // تحديث الأذكار (إعادة تحميل)
  Future<void> refreshAdhkar() async {
    await _loadAdhkarData();
  }

  // أذكار سريعة للسبحة
  List<String> getQuickTasbihOptions() {
    return [
      AppStrings.subhanAllah,
      AppStrings.alhamdulillah,
      AppStrings.allahuAkbar,
      AppStrings.laIlahaIllaAllah,
    ];
  }
}