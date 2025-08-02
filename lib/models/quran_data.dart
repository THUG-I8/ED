class QuranData {
  final List<Surah> surahs;
  final List<QuranPage> pages;

  QuranData({required this.surahs, required this.pages});

  factory QuranData.fromJson(Map<String, dynamic> json) {
    return QuranData(
      surahs: (json['surahs'] as List).map((e) => Surah.fromJson(e)).toList(),
      pages: (json['pages'] as List).map((e) => QuranPage.fromJson(e)).toList(),
    );
  }
}

class Surah {
  final int number;
  final SurahName name;
  final RevelationPlace revelationPlace;
  final int versesCount;
  final int wordsCount;
  final int lettersCount;
  final List<Verse> verses;
  final List<Audio> audio;

  Surah({
    required this.number,
    required this.name,
    required this.revelationPlace,
    required this.versesCount,
    required this.wordsCount,
    required this.lettersCount,
    required this.verses,
    required this.audio,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'],
      name: SurahName.fromJson(json['name']),
      revelationPlace: RevelationPlace.fromJson(json['revelation_place']),
      versesCount: json['verses_count'],
      wordsCount: json['words_count'],
      lettersCount: json['letters_count'],
      verses: (json['verses'] as List).map((e) => Verse.fromJson(e)).toList(),
      audio: (json['audio'] as List).map((e) => Audio.fromJson(e)).toList(),
    );
  }
}

class SurahName {
  final String ar;
  final String en;
  final String transliteration;

  SurahName({
    required this.ar,
    required this.en,
    required this.transliteration,
  });

  factory SurahName.fromJson(Map<String, dynamic> json) {
    return SurahName(
      ar: json['ar'],
      en: json['en'],
      transliteration: json['transliteration'],
    );
  }
}

class RevelationPlace {
  final String ar;
  final String en;

  RevelationPlace({
    required this.ar,
    required this.en,
  });

  factory RevelationPlace.fromJson(Map<String, dynamic> json) {
    return RevelationPlace(
      ar: json['ar'],
      en: json['en'],
    );
  }
}

class Verse {
  final int number;
  final VerseText text;
  final int juz;
  final int page;
  final bool sajda;

  Verse({
    required this.number,
    required this.text,
    required this.juz,
    required this.page,
    required this.sajda,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      number: json['number'],
      text: VerseText.fromJson(json['text']),
      juz: json['juz'],
      page: json['page'],
      sajda: json['sajda'],
    );
  }
}

class VerseText {
  final String ar;
  final String en;

  VerseText({
    required this.ar,
    required this.en,
  });

  factory VerseText.fromJson(Map<String, dynamic> json) {
    return VerseText(
      ar: json['ar'],
      en: json['en'],
    );
  }
}

class Audio {
  final int id;
  final Reciter reciter;
  final Rewaya rewaya;
  final String server;
  final String link;

  Audio({
    required this.id,
    required this.reciter,
    required this.rewaya,
    required this.server,
    required this.link,
  });

  factory Audio.fromJson(Map<String, dynamic> json) {
    return Audio(
      id: json['id'],
      reciter: Reciter.fromJson(json['reciter']),
      rewaya: Rewaya.fromJson(json['rewaya']),
      server: json['server'],
      link: json['link'],
    );
  }
}

class Reciter {
  final String ar;
  final String en;

  Reciter({
    required this.ar,
    required this.en,
  });

  factory Reciter.fromJson(Map<String, dynamic> json) {
    return Reciter(
      ar: json['ar'],
      en: json['en'],
    );
  }
}

class Rewaya {
  final String ar;
  final String en;

  Rewaya({
    required this.ar,
    required this.en,
  });

  factory Rewaya.fromJson(Map<String, dynamic> json) {
    return Rewaya(
      ar: json['ar'],
      en: json['en'],
    );
  }
}

class QuranPage {
  final int page;
  final PageImage image;
  final PageStart start;
  final PageEnd end;

  QuranPage({
    required this.page,
    required this.image,
    required this.start,
    required this.end,
  });

  factory QuranPage.fromJson(Map<String, dynamic> json) {
    return QuranPage(
      page: json['page'],
      image: PageImage.fromJson(json['image']),
      start: PageStart.fromJson(json['start']),
      end: PageEnd.fromJson(json['end']),
    );
  }
}

class PageImage {
  final String url;

  PageImage({required this.url});

  factory PageImage.fromJson(Map<String, dynamic> json) {
    return PageImage(url: json['url']);
  }
}

class PageStart {
  final int surahNumber;
  final int verse;
  final SurahName name;

  PageStart({
    required this.surahNumber,
    required this.verse,
    required this.name,
  });

  factory PageStart.fromJson(Map<String, dynamic> json) {
    return PageStart(
      surahNumber: json['surah_number'],
      verse: json['verse'],
      name: SurahName.fromJson(json['name']),
    );
  }
}

class PageEnd {
  final int surahNumber;
  final int verse;
  final SurahName name;

  PageEnd({
    required this.surahNumber,
    required this.verse,
    required this.name,
  });

  factory PageEnd.fromJson(Map<String, dynamic> json) {
    return PageEnd(
      surahNumber: json['surah_number'],
      verse: json['verse'],
      name: SurahName.fromJson(json['name']),
    );
  }
}