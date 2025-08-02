import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../providers/quran_settings_provider.dart';
import '../models/quran_settings.dart';

class QuranReaderScreen extends StatefulWidget {
  const QuranReaderScreen({Key? key}) : super(key: key);

  @override
  State<QuranReaderScreen> createState() => _QuranReaderScreenState();
}

class _QuranReaderScreenState extends State<QuranReaderScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  double _currentScale = 1.0;
  double _minScale = 0.5;
  double _maxScale = 3.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المصحف الشريف'),
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuranSettingsScreen(),
                ),
              );
            },
            tooltip: 'الإعدادات',
          ),
        ],
      ),
      body: Consumer<QuranSettingsProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              _buildToolbar(context, provider),
              Expanded(
                child: _buildQuranViewer(context, provider),
              ),
              _buildBottomNavigation(context, provider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildToolbar(BuildContext context, QuranSettingsProvider provider) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          // أزرار التحكم في الحجم
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () => _decreaseFontSize(provider),
            tooltip: 'تصغير الخط',
          ),
          Expanded(
            child: Slider(
              value: provider.settings.fontSize,
              min: QuranSettings.availableFontSizes.first,
              max: QuranSettings.availableFontSizes.last,
              onChanged: (value) => provider.updateFontSize(value),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () => _increaseFontSize(provider),
            tooltip: 'تكبير الخط',
          ),
          
          const SizedBox(width: 8),
          
          // زر إعادة تعيين الزوم
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _resetZoom(),
            tooltip: 'إعادة تعيين الزوم',
          ),
          
          const SizedBox(width: 8),
          
          // زر تبديل الوضع الليلي
          IconButton(
            icon: Icon(
              _isDarkMode(provider) ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () => _toggleDarkMode(provider),
            tooltip: 'الوضع الليلي',
          ),
        ],
      ),
    );
  }

  Widget _buildQuranViewer(BuildContext context, QuranSettingsProvider provider) {
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: _getQuranPageImage(index),
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained * _minScale,
          maxScale: PhotoViewComputedScale.covered * _maxScale,
          heroAttributes: PhotoViewHeroAttributes(tag: "quran_page_$index"),
          onTapUp: (context, details, controllerValue) {
            // يمكن إضافة تفاعلات إضافية هنا
          },
        );
      },
      itemCount: 604, // عدد صفحات القرآن
      loadingBuilder: (context, event) => Center(
        child: CircularProgressIndicator(
          value: event == null ? 0 : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
        ),
      ),
      pageController: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
    );
  }

  Widget _buildBottomNavigation(BuildContext context, QuranSettingsProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // معلومات الصفحة الحالية
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الصفحة ${_currentPage + 1} من 604',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'السورة: ${_getSurahName(_currentPage)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // شريط التنقل
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.first_page),
                onPressed: _currentPage > 0 ? () => _goToPage(0) : null,
                tooltip: 'الصفحة الأولى',
              ),
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _currentPage > 0 ? () => _goToPage(_currentPage - 1) : null,
                tooltip: 'الصفحة السابقة',
              ),
              Expanded(
                child: Slider(
                  value: _currentPage.toDouble(),
                  min: 0,
                  max: 603,
                  divisions: 603,
                  onChanged: (value) => _goToPage(value.toInt()),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _currentPage < 603 ? () => _goToPage(_currentPage + 1) : null,
                tooltip: 'الصفحة التالية',
              ),
              IconButton(
                icon: const Icon(Icons.last_page),
                onPressed: _currentPage < 603 ? () => _goToPage(603) : null,
                tooltip: 'الصفحة الأخيرة',
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // أزرار إضافية
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => _showSurahList(context),
                icon: const Icon(Icons.list),
                label: const Text('قائمة السور'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C3E50),
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showBookmarks(context),
                icon: const Icon(Icons.bookmark),
                label: const Text('العلامات'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C3E50),
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showSearch(context),
                icon: const Icon(Icons.search),
                label: const Text('البحث'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C3E50),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // دوال مساعدة
  void _decreaseFontSize(QuranSettingsProvider provider) {
    if (provider.canDecreaseFontSize()) {
      provider.updateFontSize(provider.getPreviousFontSize());
    }
  }

  void _increaseFontSize(QuranSettingsProvider provider) {
    if (provider.canIncreaseFontSize()) {
      provider.updateFontSize(provider.getNextFontSize());
    }
  }

  void _resetZoom() {
    setState(() {
      _currentScale = 1.0;
    });
  }

  bool _isDarkMode(QuranSettingsProvider provider) {
    return provider.settings.backgroundColor == const Color(0xFF2C3E50) ||
           provider.settings.backgroundColor == const Color(0xFF1A1A1A);
  }

  void _toggleDarkMode(QuranSettingsProvider provider) {
    if (_isDarkMode(provider)) {
      provider.updateBackgroundColor(const Color(0xFFF8F6F1));
      provider.updateTextColor(const Color(0xFF2C3E50));
    } else {
      provider.updateBackgroundColor(const Color(0xFF2C3E50));
      provider.updateTextColor(const Color(0xFFFFFFFF));
    }
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  String _getSurahName(int page) {
    // قائمة أسماء السور مع أرقام الصفحات
    final surahPages = [
      {'name': 'الفاتحة', 'start': 1, 'end': 1},
      {'name': 'البقرة', 'start': 2, 'end': 49},
      {'name': 'آل عمران', 'start': 50, 'end': 76},
      {'name': 'النساء', 'start': 77, 'end': 106},
      {'name': 'المائدة', 'start': 107, 'end': 127},
      {'name': 'الأنعام', 'start': 128, 'end': 150},
      {'name': 'الأعراف', 'start': 151, 'end': 176},
      {'name': 'الأنفال', 'start': 177, 'end': 186},
      {'name': 'التوبة', 'start': 187, 'end': 207},
      {'name': 'يونس', 'start': 208, 'end': 221},
      // يمكن إضافة باقي السور هنا
    ];

    for (final surah in surahPages) {
      if (page >= surah['start']! - 1 && page <= surah['end']! - 1) {
        return surah['name']!;
      }
    }
    return 'غير محدد';
  }

  ImageProvider _getQuranPageImage(int page) {
    // هنا يمكن إضافة رابط الصور الحقيقية للمصحف
    // حالياً نستخدم صورة تجريبية
    return const AssetImage('assets/images/quran_page_placeholder.png');
  }

  void _showSurahList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'قائمة السور',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 114,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${index + 1}. ${_getSurahNameByIndex(index)}'),
                    onTap: () {
                      Navigator.pop(context);
                      _goToSurah(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookmarks(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        child: const Column(
          children: [
            Text(
              'العلامات المحفوظة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Text('لا توجد علامات محفوظة'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearch(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'البحث في القرآن',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'اكتب كلمة للبحث',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // تنفيذ البحث
              },
            ),
            const SizedBox(height: 16),
            const Expanded(
              child: Center(
                child: Text('اكتب كلمة للبحث في القرآن الكريم'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getSurahNameByIndex(int index) {
    final surahNames = [
      'الفاتحة', 'البقرة', 'آل عمران', 'النساء', 'المائدة', 'الأنعام', 'الأعراف', 'الأنفال', 'التوبة', 'يونس',
      'هود', 'يوسف', 'الرعد', 'إبراهيم', 'الحجر', 'النحل', 'الإسراء', 'الكهف', 'مريم', 'طه',
      'الأنبياء', 'الحج', 'المؤمنون', 'النور', 'الفرقان', 'الشعراء', 'النمل', 'القصص', 'العنكبوت', 'الروم',
      'لقمان', 'السجدة', 'الأحزاب', 'سبأ', 'فاطر', 'يس', 'الصافات', 'ص', 'الزمر', 'غافر',
      'فصلت', 'الشورى', 'الزخرف', 'الدخان', 'الجاثية', 'الأحقاف', 'محمد', 'الفتح', 'الحجرات', 'ق',
      'الذاريات', 'الطور', 'النجم', 'القمر', 'الرحمن', 'الواقعة', 'الحديد', 'المجادلة', 'الحشر', 'الممتحنة',
      'الصف', 'الجمعة', 'المنافقون', 'التغابن', 'الطلاق', 'التحريم', 'الملك', 'القلم', 'الحاقة', 'المعارج',
      'نوح', 'الجن', 'المزمل', 'المدثر', 'القيامة', 'الإنسان', 'المرسلات', 'النبأ', 'النازعات', 'عبس',
      'التكوير', 'الانفطار', 'المطففين', 'الانشقاق', 'البروج', 'الطارق', 'الأعلى', 'الغاشية', 'الفجر', 'البلد',
      'الشمس', 'الليل', 'الضحى', 'الشرح', 'التين', 'العلق', 'القدر', 'البينة', 'الزلزلة', 'العاديات',
      'القارعة', 'التكاثر', 'العصر', 'الهمزة', 'الفيل', 'قريش', 'الماعون', 'الكوثر', 'الكافرون', 'النصر',
      'المسد', 'الإخلاص', 'الفلق', 'الناس'
    ];
    return surahNames[index];
  }

  void _goToSurah(int surahIndex) {
    // حساب رقم الصفحة للسورة المحددة
    final surahStartPages = [
      1, 2, 50, 77, 107, 128, 151, 177, 187, 208, 221, 235, 249, 255, 262, 267, 282, 293, 305, 312,
      322, 332, 342, 350, 359, 367, 377, 385, 396, 404, 411, 415, 418, 428, 434, 440, 446, 453, 458, 467,
      477, 483, 489, 496, 499, 502, 507, 511, 515, 518, 520, 523, 526, 528, 531, 534, 537, 542, 545, 549,
      551, 553, 554, 556, 558, 560, 562, 564, 566, 568, 570, 572, 574, 575, 577, 578, 580, 582, 583, 585,
      586, 587, 587, 589, 590, 591, 591, 592, 593, 594, 595, 595, 596, 596, 597, 597, 598, 598, 599, 599,
      600, 600, 601, 601, 601, 602, 602, 602, 603, 603, 603, 603, 604, 604
    ];
    
    if (surahIndex < surahStartPages.length) {
      _goToPage(surahStartPages[surahIndex] - 1);
    }
  }
}