import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:adhan/adhan.dart';
import 'package:hijri/hijri.dart';
import '../constants/app_strings.dart';

class PrayerTimeProvider with ChangeNotifier {
  PrayerTimes? _prayerTimes;
  Position? _currentPosition;
  bool _isLoading = false;
  String? _error;
  DateTime? _lastUpdated;
  
  // Getters
  PrayerTimes? get prayerTimes => _prayerTimes;
  Position? get currentPosition => _currentPosition;
  bool get isLoading => _isLoading;
  String? get error => _error;
  DateTime? get lastUpdated => _lastUpdated;

  // أسماء الصلوات
  List<String> get prayerNames => [
    AppStrings.fajr,
    AppStrings.sunrise,
    AppStrings.dhuhr,
    AppStrings.asr,
    AppStrings.maghrib,
    AppStrings.isha,
  ];

  PrayerTimeProvider() {
    _initializePrayerTimes();
  }

  // تهيئة مواقيت الصلاة
  Future<void> _initializePrayerTimes() async {
    await _getCurrentLocation();
    if (_currentPosition != null) {
      await _calculatePrayerTimes();
    }
  }

  // الحصول على الموقع الحالي
  Future<void> _getCurrentLocation() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // التحقق من صلاحيات الموقع
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _error = AppStrings.permissionDenied;
          _isLoading = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _error = AppStrings.permissionDenied;
        _isLoading = false;
        notifyListeners();
        return;
      }

      // التحقق من تفعيل خدمات الموقع
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _error = AppStrings.enableLocation;
        _isLoading = false;
        notifyListeners();
        return;
      }

      // الحصول على الموقع
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'خطأ في الحصول على الموقع: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // حساب مواقيت الصلاة
  Future<void> _calculatePrayerTimes() async {
    if (_currentPosition == null) return;

    try {
      // إعداد الإحداثيات
      final coordinates = Coordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      // إعداد معايير الحساب (الطريقة المصرية)
      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi; // المذهب الشافعي

      // حساب مواقيت اليوم
      final today = DateTime.now();
      _prayerTimes = PrayerTimes.today(coordinates, params);
      _lastUpdated = today;

      notifyListeners();
    } catch (e) {
      _error = 'خطأ في حساب مواقيت الصلاة: $e';
      notifyListeners();
    }
  }

  // الحصول على وقت صلاة محددة
  DateTime? getPrayerTime(String prayerName) {
    if (_prayerTimes == null) return null;

    switch (prayerName) {
      case 'الفجر':
        return _prayerTimes!.fajr;
      case 'الشروق':
        return _prayerTimes!.sunrise;
      case 'الظهر':
        return _prayerTimes!.dhuhr;
      case 'العصر':
        return _prayerTimes!.asr;
      case 'المغرب':
        return _prayerTimes!.maghrib;
      case 'العشاء':
        return _prayerTimes!.isha;
      default:
        return null;
    }
  }

  // الحصول على الصلاة التالية
  Map<String, dynamic>? getNextPrayer() {
    if (_prayerTimes == null) return null;

    final now = DateTime.now();
    final prayers = [
      {'name': AppStrings.fajr, 'time': _prayerTimes!.fajr},
      {'name': AppStrings.sunrise, 'time': _prayerTimes!.sunrise},
      {'name': AppStrings.dhuhr, 'time': _prayerTimes!.dhuhr},
      {'name': AppStrings.asr, 'time': _prayerTimes!.asr},
      {'name': AppStrings.maghrib, 'time': _prayerTimes!.maghrib},
      {'name': AppStrings.isha, 'time': _prayerTimes!.isha},
    ];

    // البحث عن الصلاة التالية
    for (var prayer in prayers) {
      final prayerTime = prayer['time'] as DateTime;
      if (prayerTime.isAfter(now)) {
        final timeRemaining = prayerTime.difference(now);
        return {
          'name': prayer['name'],
          'time': prayerTime,
          'timeRemaining': timeRemaining,
        };
      }
    }

    // إذا انتهت صلوات اليوم، فالصلاة التالية هي فجر الغد
    final tomorrow = now.add(const Duration(days: 1));
    final tomorrowCoordinates = Coordinates(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
    final tomorrowParams = CalculationMethod.egyptian.getParameters();
    final tomorrowPrayers = PrayerTimes.on(tomorrow, tomorrowCoordinates, tomorrowParams);
    
    final timeRemaining = tomorrowPrayers.fajr.difference(now);
    return {
      'name': AppStrings.fajr,
      'time': tomorrowPrayers.fajr,
      'timeRemaining': timeRemaining,
    };
  }

  // الحصول على الصلاة الحالية
  String? getCurrentPrayer() {
    if (_prayerTimes == null) return null;

    final now = DateTime.now();
    
    if (now.isAfter(_prayerTimes!.fajr) && now.isBefore(_prayerTimes!.sunrise)) {
      return AppStrings.fajr;
    } else if (now.isAfter(_prayerTimes!.dhuhr) && now.isBefore(_prayerTimes!.asr)) {
      return AppStrings.dhuhr;
    } else if (now.isAfter(_prayerTimes!.asr) && now.isBefore(_prayerTimes!.maghrib)) {
      return AppStrings.asr;
    } else if (now.isAfter(_prayerTimes!.maghrib) && now.isBefore(_prayerTimes!.isha)) {
      return AppStrings.maghrib;
    } else if (now.isAfter(_prayerTimes!.isha)) {
      return AppStrings.isha;
    }
    
    return null;
  }

  // حساب اتجاه القبلة
  double? getQiblaDirection() {
    if (_currentPosition == null) return null;

    // إحداثيات الكعبة المشرفة
    const kaabaLat = 21.4225;
    const kaabaLng = 39.8262;

    final currentLat = _currentPosition!.latitude;
    final currentLng = _currentPosition!.longitude;

    // حساب الاتجاه باستخدام الرياضيات الكروية
    final dLng = (kaabaLng - currentLng) * (3.14159 / 180);
    final lat1 = currentLat * (3.14159 / 180);
    final lat2 = kaabaLat * (3.14159 / 180);

    final y = math.sin(dLng) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) - 
              math.sin(lat1) * math.cos(lat2) * math.cos(dLng);

    final bearing = math.atan2(y, x) * (180 / 3.14159);
    return (bearing + 360) % 360; // تحويل إلى قيمة موجبة
  }

  // الحصول على التاريخ الهجري
  String getHijriDate() {
    final hijriDate = HijriCalendar.now();
    return '${hijriDate.hDay} ${_getHijriMonthName(hijriDate.hMonth)} ${hijriDate.hYear} هـ';
  }

  // الحصول على اسم الشهر الهجري
  String _getHijriMonthName(int month) {
    const months = [
      'محرم', 'صفر', 'ربيع الأول', 'ربيع الآخر',
      'جمادى الأولى', 'جمادى الآخرة', 'رجب', 'شعبان',
      'رمضان', 'شوال', 'ذو القعدة', 'ذو الحجة'
    ];
    return months[month - 1];
  }

  // تحديث الموقع ومواقيت الصلاة
  Future<void> refreshPrayerTimes() async {
    await _getCurrentLocation();
    if (_currentPosition != null) {
      await _calculatePrayerTimes();
    }
  }

  // تنسيق الوقت للعرض
  String formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'م' : 'ص';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  // الحصول على الوقت المتبقي بتنسيق نصي
  String formatTimeRemaining(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    
    if (hours > 0) {
      return '$hours ساعة و $minutes دقيقة';
    } else {
      return '$minutes دقيقة';
    }
  }

  // التحقق من إذا كان الوقت وقت صلاة
  bool isPrayerTime() {
    if (_prayerTimes == null) return false;
    
    final now = DateTime.now();
    const tolerance = Duration(minutes: 5); // هامش 5 دقائق
    
    final prayerTimes = [
      _prayerTimes!.fajr,
      _prayerTimes!.dhuhr,
      _prayerTimes!.asr,
      _prayerTimes!.maghrib,
      _prayerTimes!.isha,
    ];
    
    for (var prayerTime in prayerTimes) {
      if (now.difference(prayerTime).abs() <= tolerance) {
        return true;
      }
    }
    
    return false;
  }
}