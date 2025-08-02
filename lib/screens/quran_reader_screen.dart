import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quran_provider.dart';
import '../providers/quran_settings_provider.dart';
import '../services/quran_service.dart';
import 'quran_settings_screen.dart';

class QuranReaderScreen extends StatefulWidget {
  @override
  _QuranReaderScreenState createState() => _QuranReaderScreenState();
}

class _QuranReaderScreenState extends State<QuranReaderScreen> {
  @override
  void initState() {
    super.initState();
    // Load Quran data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuranProvider>().loadQuranData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المصحف الشريف'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuranSettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<QuranProvider>(
        builder: (context, quranProvider, child) {
          if (quranProvider.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green[700]!),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'جاري تحميل القرآن الكريم...',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          if (quranProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 80,
                    color: Colors.red[300],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'حدث خطأ في التحميل',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[700],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    quranProvider.error!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      quranProvider.loadQuranData();
                    },
                    child: Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          if (quranProvider.surahs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.book_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'لا توجد بيانات متاحة',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return _buildQuranContent(quranProvider);
        },
      ),
    );
  }

  Widget _buildQuranContent(QuranProvider quranProvider) {
    final settings = context.watch<QuranSettingsProvider>();
    final verses = quranProvider.currentPageVerses;

    return Column(
      children: [
        // معلومات الصفحة
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[700]!, Colors.green[600]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الصفحة ${quranProvider.currentPage}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (quranProvider.currentSurahData != null)
                      Text(
                        'سورة ${quranProvider.currentSurahData!.name.ar}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${quranProvider.currentPage}/${QuranService.getTotalPages()}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // محتوى القرآن
        Expanded(
          child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: settings.backgroundColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: verses.isEmpty
                ? Center(
                    child: Text(
                      'لا توجد آيات في هذه الصفحة',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: verses.map((verse) {
                        return _buildVerseWidget(verse, settings);
                      }).toList(),
                    ),
                  ),
          ),
        ),

        // أزرار التنقل
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: quranProvider.currentPage > 1
                    ? () => quranProvider.previousPage()
                    : null,
                icon: Icon(Icons.arrow_back_ios),
                color: quranProvider.currentPage > 1
                    ? Colors.green[700]
                    : Colors.grey[400],
              ),
              Container(
                width: 80,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '${quranProvider.currentPage}',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                  onSubmitted: (value) {
                    final page = int.tryParse(value);
                    if (page != null && page >= 1 && page <= QuranService.getTotalPages()) {
                      quranProvider.goToPage(page);
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: quranProvider.currentPage < QuranService.getTotalPages()
                    ? () => quranProvider.nextPage()
                    : null,
                icon: Icon(Icons.arrow_forward_ios),
                color: quranProvider.currentPage < QuranService.getTotalPages()
                    ? Colors.green[700]
                    : Colors.grey[400],
              ),
              IconButton(
                onPressed: () {
                  quranProvider.togglePageBookmark(quranProvider.currentPage);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        quranProvider.isPageBookmarked(quranProvider.currentPage)
                            ? 'تم إضافة الصفحة للمفضلة'
                            : 'تم إزالة الصفحة من المفضلة',
                      ),
                      backgroundColor: Colors.green[700],
                    ),
                  );
                },
                icon: Icon(
                  quranProvider.isPageBookmarked(quranProvider.currentPage)
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                ),
                color: quranProvider.isPageBookmarked(quranProvider.currentPage)
                    ? Colors.green[700]
                    : Colors.grey[600],
              ),
              IconButton(
                onPressed: () {
                  quranProvider.toggleTranslation();
                },
                icon: Icon(
                  quranProvider.showTranslation
                      ? Icons.translate
                      : Icons.translate_outlined,
                ),
                color: quranProvider.showTranslation
                    ? Colors.green[700]
                    : Colors.grey[600],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVerseWidget(verse, QuranSettingsProvider settings) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.green.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // رقم الآية
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green[700],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${verse.number}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 12),
          
          // النص العربي
          Text(
            verse.text.ar,
            style: TextStyle(
              fontFamily: settings.fontFamily,
              fontSize: settings.fontSize,
              color: settings.textColor,
              height: settings.lineSpacing,
              textDirection: TextDirection.rtl,
            ),
            textAlign: TextAlign.justify,
          ),
          
          // الترجمة (إذا كانت مفعلة)
          if (settings.showTranslation) ...[
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                verse.text.en,
                style: TextStyle(
                  fontSize: settings.fontSize * 0.8,
                  color: Colors.grey[700],
                  height: settings.lineSpacing * 0.9,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ],
      ),
    );
  }
}