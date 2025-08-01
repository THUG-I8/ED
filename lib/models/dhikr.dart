class Dhikr {
  final int id;
  final String arabic;
  final String transliteration;
  final String translation;
  final String? benefit; // فائدة الذكر
  final int recommendedCount;
  final String category;
  final String? audioUrl;
  final bool isDaily; // هل هو ذكر يومي

  Dhikr({
    required this.id,
    required this.arabic,
    required this.transliteration,
    required this.translation,
    this.benefit,
    required this.recommendedCount,
    required this.category,
    this.audioUrl,
    this.isDaily = false,
  });

  factory Dhikr.fromJson(Map<String, dynamic> json) {
    return Dhikr(
      id: json['id'],
      arabic: json['arabic'],
      transliteration: json['transliteration'],
      translation: json['translation'],
      benefit: json['benefit'],
      recommendedCount: json['recommendedCount'],
      category: json['category'],
      audioUrl: json['audioUrl'],
      isDaily: json['isDaily'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'arabic': arabic,
      'transliteration': transliteration,
      'translation': translation,
      'benefit': benefit,
      'recommendedCount': recommendedCount,
      'category': category,
      'audioUrl': audioUrl,
      'isDaily': isDaily,
    };
  }
}

// تصنيفات الأذكار
enum DhikrCategory {
  morning('أذكار الصباح'),
  evening('أذكار المساء'),
  afterPrayer('أذكار ما بعد الصلاة'),
  sleep('أذكار النوم'),
  general('أذكار عامة'),
  tasbih('التسبيح');

  const DhikrCategory(this.arabicName);
  final String arabicName;
}

// عداد التسبيح
class TasbihCounter {
  final String dhikrText;
  int currentCount;
  final int targetCount;
  final DateTime startTime;
  DateTime? endTime;
  final bool enableVibration;
  final bool enableSound;

  TasbihCounter({
    required this.dhikrText,
    this.currentCount = 0,
    this.targetCount = 33,
    required this.startTime,
    this.endTime,
    this.enableVibration = true,
    this.enableSound = true,
  });

  // زيادة العدد
  void increment() {
    currentCount++;
  }

  // إعادة تعيين
  void reset() {
    currentCount = 0;
    endTime = null;
  }

  // هل انتهى العدد المطلوب
  bool get isCompleted => currentCount >= targetCount;

  // النسبة المئوية للإكمال
  double get progressPercentage => (currentCount / targetCount).clamp(0.0, 1.0);

  Map<String, dynamic> toJson() {
    return {
      'dhikrText': dhikrText,
      'currentCount': currentCount,
      'targetCount': targetCount,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'enableVibration': enableVibration,
      'enableSound': enableSound,
    };
  }

  factory TasbihCounter.fromJson(Map<String, dynamic> json) {
    return TasbihCounter(
      dhikrText: json['dhikrText'],
      currentCount: json['currentCount'],
      targetCount: json['targetCount'],
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      enableVibration: json['enableVibration'] ?? true,
      enableSound: json['enableSound'] ?? true,
    );
  }
}