class Story {
  final int id;
  final String title;
  final String content;
  final String category;
  final String? audioUrl;
  final String? imageUrl;
  final DateTime date;
  final String? moral; // العبرة من القصة
  final String? reflection; // سؤال للتأمل
  final int readingTimeMinutes;
  final bool isRead;
  final bool isFavorite;

  Story({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    this.audioUrl,
    this.imageUrl,
    required this.date,
    this.moral,
    this.reflection,
    required this.readingTimeMinutes,
    this.isRead = false,
    this.isFavorite = false,
  });

  // من JSON
  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      audioUrl: json['audioUrl'],
      imageUrl: json['imageUrl'],
      date: DateTime.parse(json['date']),
      moral: json['moral'],
      reflection: json['reflection'],
      readingTimeMinutes: json['readingTimeMinutes'] ?? 5,
      isRead: json['isRead'] ?? false,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  // إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'date': date.toIso8601String(),
      'moral': moral,
      'reflection': reflection,
      'readingTimeMinutes': readingTimeMinutes,
      'isRead': isRead,
      'isFavorite': isFavorite,
    };
  }

  // نسخ مع تعديل
  Story copyWith({
    int? id,
    String? title,
    String? content,
    String? category,
    String? audioUrl,
    String? imageUrl,
    DateTime? date,
    String? moral,
    String? reflection,
    int? readingTimeMinutes,
    bool? isRead,
    bool? isFavorite,
  }) {
    return Story(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      audioUrl: audioUrl ?? this.audioUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      date: date ?? this.date,
      moral: moral ?? this.moral,
      reflection: reflection ?? this.reflection,
      readingTimeMinutes: readingTimeMinutes ?? this.readingTimeMinutes,
      isRead: isRead ?? this.isRead,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

// تصنيفات القصص
enum StoryCategory {
  prophets('قصص الأنبياء'),
  companions('قصص الصحابة'),
  moral('قصص إيمانية'),
  historical('قصص تاريخية'),
  wisdom('حكم وعبر');

  const StoryCategory(this.arabicName);
  final String arabicName;
}