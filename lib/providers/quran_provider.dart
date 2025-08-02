import 'package:flutter/foundation.dart';
import '../models/quran_data.dart';
import '../services/quran_service.dart';

class QuranProvider extends ChangeNotifier {
  List<Surah> _surahs = [];
  List<QuranPage> _pages = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  int _currentSurah = 1;
  int _currentVerse = 1;
  bool _showTranslation = true;

  // Getters
  List<Surah> get surahs => _surahs;
  List<QuranPage> get pages => _pages;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentPage => _currentPage;
  int get currentSurah => _currentSurah;
  int get currentVerse => _currentVerse;
  bool get showTranslation => _showTranslation;

  // Current page data
  QuranPage? get currentPageData {
    try {
      return _pages.firstWhere((page) => page.pageNumber == _currentPage);
    } catch (e) {
      return null;
    }
  }

  List<Verse> get currentPageVerses {
    return QuranService.getVersesForPage(_surahs, _currentPage);
  }

  Surah? get currentSurahData {
    return QuranService.getSurahByNumber(_surahs, _currentSurah);
  }

  // Load Quran data
  Future<void> loadQuranData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final quranData = await QuranService.getQuranData();
      _surahs = quranData.surahs;
      _pages = quranData.pages;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Navigation methods
  void goToPage(int page) {
    if (page >= 1 && page <= QuranService.getTotalPages()) {
      _currentPage = page;
      notifyListeners();
    }
  }

  void goToSurah(int surahNumber) {
    if (surahNumber >= 1 && surahNumber <= QuranService.getTotalSurahs()) {
      _currentSurah = surahNumber;
      
      // Find the first page of this surah
      final surah = QuranService.getSurahByNumber(_surahs, surahNumber);
      if (surah != null && surah.verses.isNotEmpty) {
        _currentPage = surah.verses.first.page;
        _currentVerse = surah.verses.first.number;
      }
      
      notifyListeners();
    }
  }

  void nextPage() {
    if (_currentPage < QuranService.getTotalPages()) {
      goToPage(_currentPage + 1);
    }
  }

  void previousPage() {
    if (_currentPage > 1) {
      goToPage(_currentPage - 1);
    }
  }

  void nextSurah() {
    if (_currentSurah < QuranService.getTotalSurahs()) {
      goToSurah(_currentSurah + 1);
    }
  }

  void previousSurah() {
    if (_currentSurah > 1) {
      goToSurah(_currentSurah - 1);
    }
  }

  // Toggle translation
  void toggleTranslation() {
    _showTranslation = !_showTranslation;
    notifyListeners();
  }

  // Search methods
  List<Surah> searchSurahs(String query) {
    if (query.isEmpty) return _surahs;
    
    return _surahs.where((surah) {
      return surah.name.ar.contains(query) ||
             surah.name.en.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Bookmark methods
  List<int> _bookmarkedPages = [];
  List<int> get bookmarkedPages => _bookmarkedPages;

  void togglePageBookmark(int page) {
    if (_bookmarkedPages.contains(page)) {
      _bookmarkedPages.remove(page);
    } else {
      _bookmarkedPages.add(page);
    }
    notifyListeners();
  }

  bool isPageBookmarked(int page) {
    return _bookmarkedPages.contains(page);
  }
}