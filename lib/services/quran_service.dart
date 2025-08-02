import 'dart:convert';
import '../models/quran_data.dart';

class QuranService {
  static const String _baseUrl = 'https://raw.githubusercontent.com/rn0x/Quran-Data/version-2.0/data';
  
  static Future<List<Surah>> getSurahs() async {
    try {
      // حل بسيط - إرجاع بيانات افتراضية
      return _getDefaultSurahs();
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  static Future<List<QuranPage>> getPages() async {
    try {
      // حل بسيط - إرجاع بيانات افتراضية
      return _getDefaultPages();
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  static Future<QuranData> getQuranData() async {
    try {
      final surahs = await getSurahs();
      final pages = await getPages();
      
      return QuranData(surahs: surahs, pages: pages);
    } catch (e) {
      throw Exception('خطأ في جلب بيانات القرآن: $e');
    }
  }

  static String getPageImageUrl(int pageNumber) {
    return 'https://raw.githubusercontent.com/rn0x/Quran-Data/version-2.0/data/quran_image/$pageNumber.png';
  }

  static List<Verse> getVersesForPage(List<Surah> surahs, int pageNumber) {
    List<Verse> pageVerses = [];
    
    for (var surah in surahs) {
      for (var verse in surah.verses) {
        if (verse.page == pageNumber) {
          pageVerses.add(verse);
        }
      }
    }
    
    return pageVerses;
  }

  static Surah? getSurahByNumber(List<Surah> surahs, int surahNumber) {
    try {
      return surahs.firstWhere((surah) => surah.number == surahNumber);
    } catch (e) {
      return null;
    }
  }

  static int getTotalPages() {
    return 604; // إجمالي صفحات القرآن
  }

  static int getTotalSurahs() {
    return 114; // إجمالي سور القرآن
  }

  static int getTotalJuz() {
    return 30; // إجمالي أجزاء القرآن
  }

  // بيانات افتراضية للقرآن
  static List<Surah> _getDefaultSurahs() {
    return [
      Surah(
        number: 1,
        name: SurahName(ar: 'الفاتحة', en: 'Al-Fatiha'),
        englishName: 'The Opening',
        englishNameTranslation: 'The Opening',
        revelationType: 'Meccan',
        verses: [
          Verse(
            number: 1,
            text: VerseText(ar: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ', en: 'In the name of Allah, the Entirely Merciful, the Especially Merciful.'),
            page: 1,
          ),
          Verse(
            number: 2,
            text: VerseText(ar: 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ', en: '[All] praise is [due] to Allah, Lord of the worlds.'),
            page: 1,
          ),
        ],
      ),
      Surah(
        number: 2,
        name: SurahName(ar: 'البقرة', en: 'Al-Baqarah'),
        englishName: 'The Cow',
        englishNameTranslation: 'The Cow',
        revelationType: 'Medinan',
        verses: [
          Verse(
            number: 1,
            text: VerseText(ar: 'الٓمٓ', en: 'Alif, Lam, Meem.'),
            page: 2,
          ),
        ],
      ),
    ];
  }

  static List<QuranPage> _getDefaultPages() {
    return [
      QuranPage(
        pageNumber: 1,
        verses: [
          Verse(
            number: 1,
            text: VerseText(ar: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ', en: 'In the name of Allah, the Entirely Merciful, the Especially Merciful.'),
            page: 1,
          ),
        ],
      ),
    ];
  }
}