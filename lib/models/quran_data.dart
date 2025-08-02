class QuranData {
  final List<Surah> surahs;
  final List<QuranPage> pages;

  QuranData({required this.surahs, required this.pages});
}

class Surah {
  final int number;
  final SurahName name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final List<Verse> verses;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.verses,
  });
}

class SurahName {
  final String ar;
  final String en;

  SurahName({
    required this.ar,
    required this.en,
  });
}

class Verse {
  final int number;
  final VerseText text;
  final int page;

  Verse({
    required this.number,
    required this.text,
    required this.page,
  });
}

class VerseText {
  final String ar;
  final String en;

  VerseText({
    required this.ar,
    required this.en,
  });
}

class QuranPage {
  final int pageNumber;
  final List<Verse> verses;

  QuranPage({
    required this.pageNumber,
    required this.verses,
  });
}