import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({Key? key}) : super(key: key);

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen>
    with TickerProviderStateMixin {
  Map<String, dynamic>? _prayerData;
  bool _isLoading = true;
  String _error = '';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _loadPrayerTimes();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _loadPrayerTimes() async {
    try {
      final today = DateTime.now();
      final date = DateFormat('dd-MM-yyyy').format(today);
      final url = 'https://api.aladhan.com/v1/timingsByCity/$date?city=cairo&country=egypt&method=8';
      
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _prayerData = data['data'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'فشل في تحميل مواقيت الصلاة';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'خطأ في الاتصال: $e';
        _isLoading = false;
      });
    }
  }

  String _getCurrentPrayer() {
    if (_prayerData == null) return '';
    
    final timings = _prayerData!['timings'];
    final now = DateTime.now();
    final currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    
    final prayers = [
      {'name': 'الفجر', 'time': timings['Fajr']},
      {'name': 'الظهر', 'time': timings['Dhuhr']},
      {'name': 'العصر', 'time': timings['Asr']},
      {'name': 'المغرب', 'time': timings['Maghrib']},
      {'name': 'العشاء', 'time': timings['Isha']},
    ];
    
    for (int i = 0; i < prayers.length; i++) {
      if (currentTime.compareTo(prayers[i]['time']!) < 0) {
        return prayers[i]['name']!;
      }
    }
    return 'الفجر'; // إذا كان الوقت بعد العشاء
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A237E), // أزرق داكن جداً
              Color(0xFF3949AB), // أزرق متوسط
              Color(0xFF5C6BC0), // أزرق فاتح
              Color(0xFF7986CB), // أزرق فاتح جداً
            ],
          ),
        ),
        child: SafeArea(
          child: _isLoading
              ? _buildLoadingScreen()
              : _error.isNotEmpty
                  ? _buildErrorScreen()
                  : _buildPrayerTimesScreen(),
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.mosque,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          const SizedBox(height: 20),
          const Text(
            'جاري تحميل مواقيت الصلاة...',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.error_outline,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _error,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loadPrayerTimes,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.2),
              foregroundColor: Colors.white,
            ),
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTimesScreen() {
    final timings = _prayerData!['timings'];
    final date = _prayerData!['date'];
    final currentPrayer = _getCurrentPrayer();
    
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(date),
          _buildCurrentPrayer(currentPrayer),
          _buildPrayerTimesList(timings),
          _buildAdditionalInfo(),
        ],
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> date) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // أيقونة المسجد
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.mosque,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          
          // العنوان
          FadeTransition(
            opacity: _fadeAnimation,
            child: const Text(
              'مواقيت الصلاة',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          const SizedBox(height: 10),
          
          // التاريخ
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                '${date['readable']} - ${date['hijri']['day']} ${date['hijri']['month']['ar']} ${date['hijri']['year']} هـ',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPrayer(String currentPrayer) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.access_time,
                    size: 30,
                    color: Colors.orange,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Text(
            'الصلاة القادمة',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            currentPrayer,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTimesList(Map<String, dynamic> timings) {
    final prayers = [
      {'name': 'الفجر', 'time': timings['Fajr'], 'icon': Icons.wb_sunny, 'color': const Color(0xFFFF9800)},
      {'name': 'الظهر', 'time': timings['Dhuhr'], 'icon': Icons.wb_sunny_outlined, 'color': const Color(0xFFFFC107)},
      {'name': 'العصر', 'time': timings['Asr'], 'icon': Icons.wb_sunny_outlined, 'color': const Color(0xFFFF5722)},
      {'name': 'المغرب', 'time': timings['Maghrib'], 'icon': Icons.nightlight_round, 'color': const Color(0xFF9C27B0)},
      {'name': 'العشاء', 'time': timings['Isha'], 'icon': Icons.nightlight_round, 'color': const Color(0xFF3F51B5)},
    ];

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'مواقيت الصلاة',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          ...prayers.map((prayer) => _buildPrayerCard(prayer)).toList(),
        ],
      ),
    );
  }

  Widget _buildPrayerCard(Map<String, dynamic> prayer) {
    final isCurrentPrayer = prayer['name'] == _getCurrentPrayer();
    
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isCurrentPrayer 
            ? Colors.orange.withOpacity(0.3)
            : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isCurrentPrayer 
              ? Colors.orange.withOpacity(0.5)
              : Colors.white.withOpacity(0.3),
          width: isCurrentPrayer ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: prayer['color'].withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            prayer['icon'],
            color: prayer['color'],
            size: 24,
          ),
        ),
        title: Text(
          prayer['name'],
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isCurrentPrayer ? Colors.orange : Colors.white,
          ),
        ),
        subtitle: Text(
          'وقت الصلاة',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: isCurrentPrayer 
                ? Colors.orange.withOpacity(0.2)
                : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isCurrentPrayer 
                  ? Colors.orange
                  : Colors.white.withOpacity(0.3),
            ),
          ),
          child: Text(
            prayer['time'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isCurrentPrayer ? Colors.orange : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo() {
    final meta = _prayerData!['meta'];
    
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'معلومات إضافية',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          _buildInfoRow('المدينة', 'القاهرة'),
          _buildInfoRow('الدولة', 'مصر'),
          _buildInfoRow('المنطقة الزمنية', meta['timezone']),
          _buildInfoRow('طريقة الحساب', meta['method']['name']),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}