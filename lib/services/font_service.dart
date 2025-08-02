import 'dart:convert';
import 'package:http/http.dart' as http;

class FontService {
  static const String _fontsApiUrl = 'https://raw.githubusercontent.com/fawazahmed0/quran-api/1/fonts.json';

  static Future<Map<String, dynamic>> getFonts() async {
    try {
      final response = await http.get(Uri.parse(_fontsApiUrl));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> fontsData = json.decode(response.body);
        return fontsData;
      } else {
        throw Exception('فشل في جلب الخطوط: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  static Future<List<String>> getAvailableFonts() async {
    try {
      final fontsData = await getFonts();
      final List<String> fonts = [];
      
      if (fontsData.containsKey('fonts')) {
        final Map<String, dynamic> fontsMap = fontsData['fonts'];
        fonts.addAll(fontsMap.keys);
      }
      
      return fonts;
    } catch (e) {
      // في حالة الفشل، نرجع الخطوط الافتراضية
      return [
        'Amiri',
        'Cairo',
        'Uthmanic',
        'KFGQPC',
        'Scheherazade',
      ];
    }
  }

  static Future<String?> getFontUrl(String fontName) async {
    try {
      final fontsData = await getFonts();
      
      if (fontsData.containsKey('fonts') && 
          fontsData['fonts'].containsKey(fontName)) {
        return fontsData['fonts'][fontName];
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }
}