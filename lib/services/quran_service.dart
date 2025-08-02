import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quran_data.dart';

class QuranService {
  static const String _baseUrl = 'https://raw.githubusercontent.com/rn0x/Quran-Data/version-2.0/data';
  
  static Future<List<Surah>> getSurahs() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/mainDataQuran.json'));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Surah.fromJson(json)).toList();
      } else {
        throw Exception('فشل في جلب بيانات القرآن: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  static Future<List<QuranPage>> getPages() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/pagesQuran.json'));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => QuranPage.fromJson(json)).toList();
      } else {
        throw Exception('فشل في جلب صفحات القرآن: ${response.statusCode}');
      }
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
}