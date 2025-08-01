import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/story.dart';

class StoryProvider with ChangeNotifier {
  List<Story> _stories = [];
  Story? _todayStory;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Story> get stories => _stories;
  Story? get todayStory => _todayStory;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Story> get favoriteStories => 
      _stories.where((story) => story.isFavorite).toList();

  List<Story> get readStories => 
      _stories.where((story) => story.isRead).toList();

  StoryProvider() {
    _loadStoriesData();
  }

  // تحميل بيانات القصص
  Future<void> _loadStoriesData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // تحميل القصص المحفوظة محلياً أو من API
      await _loadSampleStories();
      await _setTodayStory();
      _isLoading = false;
    } catch (e) {
      _error = 'خطأ في تحميل القصص: $e';
      _isLoading = false;
    }
    notifyListeners();
  }

  // تحميل قصص نموذجية
  Future<void> _loadSampleStories() async {
    _stories = [
      Story(
        id: 1,
        title: 'قصة نوح عليه السلام والفلك',
        content: '''
في زمن بعيد، عاش نبي الله نوح عليه السلام بين قوم لا يؤمنون بالله. دعاهم نوح تسعمائة وخمسين سنة إلى عبادة الله وحده، لكنهم رفضوا وأصروا على الكفر والعناد.

أمر الله سبحانه وتعالى نوحاً ببناء سفينة عظيمة، وعلمه كيف يصنعها. كان قوم نوح يسخرون منه وهو يبني السفينة في الصحراء، بعيداً عن البحر.

قال الله تعالى: "واصنع الفلك بأعيننا ووحينا ولا تخاطبني في الذين ظلموا إنهم مغرقون"

عندما اكتمل بناء السفينة، أمر الله نوحاً أن يحمل فيها من كل زوجين اثنين، وأهله إلا من سبق عليه القول، والذين آمنوا معه.

جاء الطوفان العظيم، وغرقت الأرض كلها، ونجا نوح ومن معه في السفينة. وبعد أن انتهى الطوفان، استقرت السفينة على جبل الجودي.

قال تعالى: "وقيل يا أرض ابلعي ماءك ويا سماء أقلعي وغيض الماء وقضي الأمر واستوت على الجودي وقيل بعداً للقوم الظالمين"
        ''',
        category: 'قصص الأنبياء',
        date: DateTime.now().subtract(const Duration(days: 0)),
        moral: 'الصبر على الدعوة والثقة في وعد الله',
        reflection: 'كيف يمكننا أن نصبر على الحق مثل نوح عليه السلام؟',
        readingTimeMinutes: 5,
      ),
      
      Story(
        id: 2,
        title: 'قصة أصحاب الكهف',
        content: '''
في زمن قديم، كان هناك ملك ظالم يجبر الناس على عبادة الأصنام. وكان في مملكته فتية مؤمنون رفضوا عبادة غير الله.

خاف هؤلاء الفتية من بطش الملك، فقرروا الهروب إلى كهف في الجبل. دخلوا الكهف مع كلبهم، ودعوا الله أن يحميهم.

استجاب الله دعاءهم، فأنامهم نوماً عميقاً لمئات السنين. كانت الشمس تشرق وتغرب، والسنون تمر، وهم نائمون في حماية الله.

قال تعالى: "وترى الشمس إذا طلعت تزاور عن كهفهم ذات اليمين وإذا غربت تقرضهم ذات الشمال وهم في فجوة منه"

بعد ثلاثمائة وتسع سنين، أيقظهم الله. ظنوا أنهم ناموا يوماً أو بعض يوم. أرسلوا أحدهم ليشتري طعاماً من المدينة.

عندما وصل إلى المدينة، وجد كل شيء قد تغير. الناس لا يعرفونه، والعملة التي معه لم تعد تُستعمل. اكتشف الناس قصتهم، وآمنوا بقدرة الله العظيمة.
        ''',
        category: 'قصص إيمانية',
        date: DateTime.now().subtract(const Duration(days: 1)),
        moral: 'الإيمان والثقة بالله تحمي من كل سوء',
        reflection: 'ما الذي يمكننا أن نتعلمه من ثبات أصحاب الكهف على دينهم؟',
        readingTimeMinutes: 6,
      ),

      Story(
        id: 3,
        title: 'قصة أبو بكر الصديق والهجرة',
        content: '''
عندما أذن الله لنبيه محمد صلى الله عليه وسلم بالهجرة من مكة إلى المدينة، اختار أبا بكر الصديق رضي الله عنه ليكون رفيقه في هذه الرحلة المباركة.

أعد أبو بكر راحلتين وزاداً للرحلة، وانطلقا من مكة خفية. كان أبو بكر يمشي أحياناً أمام النبي وأحياناً خلفه، خوفاً عليه من أن يصيبه أذى.

وصلا إلى غار ثور، واختبآ فيه ثلاثة أيام. كان أبو بكر يدخل الغار أولاً ليتأكد من سلامته، ثم يدخل النبي صلى الله عليه وسلم.

جاء المشركون يبحثون عنهما، ووقفوا على باب الغار. خاف أبو بكر وقال: "يا رسول الله، لو أن أحدهم نظر إلى قدميه لأبصرنا تحت قدميه"

فقال النبي صلى الله عليه وسلم: "يا أبا بكر، ما ظنك باثنين الله ثالثهما؟"

حماهما الله، فقد نسج العنكبوت خيوطه على باب الغار، وباضت الحمامة عند المدخل، فظن المشركون أن أحداً لم يدخل الغار.

نزل قول الله تعالى: "إلا تنصروه فقد نصره الله إذ أخرجه الذين كفروا ثاني اثنين إذ هما في الغار إذ يقول لصاحبه لا تحزن إن الله معنا"
        ''',
        category: 'قصص الصحابة',
        date: DateTime.now().subtract(const Duration(days: 2)),
        moral: 'المؤمن الحق يضحي بكل شيء في سبيل دينه',
        reflection: 'كيف يمكننا أن نكون أوفياء مثل أبي بكر الصديق؟',
        readingTimeMinutes: 7,
      ),

      Story(
        id: 4,
        title: 'قصة الرجل الذي أحيا الأرض الميتة',
        content: '''
في إحدى القرى، كان هناك رجل صالح يملك أرضاً واسعة لكنها جرداء لا تنبت شيئاً. كان الناس يقولون له: "لماذا لا تبيع هذه الأرض التي لا فائدة منها؟"

لكن الرجل الصالح كان يؤمن بقدرة الله، وقرر أن يحيي هذه الأرض. بدأ بحفر بئر عميق، وبعد جهد طويل، تفجر الماء من البئر.

ثم زرع الأرض بأشجار مثمرة، وكان يسقيها كل يوم بصبر ومثابرة. مرت السنوات، وأصبحت الأرض الجرداء بستاناً أخضر مليئاً بالثمار.

أما الثمار فكان يوزعها على الفقراء والمحتاجين، ويقول: "هذا رزق الله، وهو للجميع"

جاء إليه رجل ثري وعرض عليه مبلغاً كبيراً لشراء الأرض، فرفض الرجل الصالح وقال: "هذه الأرض وقف لله، ثمارها للفقراء والمساكين"

انتشرت قصة هذا الرجل في القرى المجاورة، وأصبح الناس يأتون إليه يتعلمون منه الصبر والإيمان والكرم.

عندما توفي هذا الرجل الصالح، دفنه الناس في بستانه، وظلت الأشجار تثمر، وظل الناس يذكرونه بالخير، ويدعون له بالرحمة والمغفرة.

قال تعالى: "ومن أحياها فكأنما أحيا الناس جميعاً"
        ''',
        category: 'قصص إيمانية',
        date: DateTime.now().subtract(const Duration(days: 3)),
        moral: 'العمل الصالح يبقى بعد الموت، والصدقة الجارية من أعظم الأعمال',
        reflection: 'ما العمل الصالح الذي يمكننا أن نبدأه اليوم؟',
        readingTimeMinutes: 5,
      ),

      Story(
        id: 5,
        title: 'قصة يوسف عليه السلام والعفو',
        content: '''
عندما تمكن يوسف عليه السلام من منصبه العظيم في مصر، وأصبح عزيزها، جاءه إخوته طالبين الطعام في سني الجفاف، ولم يعرفوه.

كان بإمكان يوسف أن ينتقم منهم لما فعلوه به في صغره، عندما ألقوه في البئر وباعوه عبداً. لكن قلب يوسف كان مليئاً بالرحمة والعفو.

عرّف يوسف بنفسه لإخوته، فخافوا وظنوا أنه سينتقم منهم. لكنه قال لهم كلمات مليئة بالحكمة والعفو.

قال يوسف عليه السلام: "لا تثريب عليكم اليوم يغفر الله لكم وهو أرحم الراحمين"

لم يكتف يوسف بالعفو فقط، بل أكرمهم وأعطاهم الطعام، وطلب منهم أن يأتوا بوالدهم وأهلهم ليعيشوا في مصر في عزة وكرامة.

عندما جاء يعقوب عليه السلام (أبو يوسف) إلى مصر، سجد له يوسف وإخوته، وقال يوسف: "يا أبت هذا تأويل رؤياي من قبل قد جعلها ربي حقاً"

وحمد الله يوسف على نعمه، وقال: "رب قد آتيتني من الملك وعلمتني من تأويل الأحاديث فاطر السماوات والأرض أنت وليي في الدنيا والآخرة توفني مسلماً وألحقني بالصالحين"
        ''',
        category: 'قصص الأنبياء',
        date: DateTime.now().subtract(const Duration(days: 4)),
        moral: 'العفو عند المقدرة من أخلاق الأنبياء والصالحين',
        reflection: 'متى كانت آخر مرة عفوت فيها عن شخص أساء إليك؟',
        readingTimeMinutes: 6,
      ),
    ];
  }

  // تحديد قصة اليوم
  Future<void> _setTodayStory() async {
    if (_stories.isNotEmpty) {
      // اختيار قصة بناءً على التاريخ الحالي
      final today = DateTime.now();
      final dayOfYear = today.difference(DateTime(today.year, 1, 1)).inDays;
      final storyIndex = dayOfYear % _stories.length;
      _todayStory = _stories[storyIndex];
    }
  }

  // تحديث حالة القراءة للقصة
  Future<void> markStoryAsRead(int storyId) async {
    try {
      final storyIndex = _stories.indexWhere((story) => story.id == storyId);
      if (storyIndex != -1) {
        _stories[storyIndex] = _stories[storyIndex].copyWith(isRead: true);
        notifyListeners();
        
        // حفظ الحالة محلياً
        final prefs = await SharedPreferences.getInstance();
        final readStories = prefs.getStringList('readStories') ?? [];
        if (!readStories.contains(storyId.toString())) {
          readStories.add(storyId.toString());
          await prefs.setStringList('readStories', readStories);
        }
      }
    } catch (e) {
      debugPrint('خطأ في تحديث حالة القراءة: $e');
    }
  }

  // إضافة/إزالة من المفضلة
  Future<void> toggleFavorite(int storyId) async {
    try {
      final storyIndex = _stories.indexWhere((story) => story.id == storyId);
      if (storyIndex != -1) {
        final currentState = _stories[storyIndex].isFavorite;
        _stories[storyIndex] = _stories[storyIndex].copyWith(isFavorite: !currentState);
        notifyListeners();
        
        // حفظ الحالة محلياً
        final prefs = await SharedPreferences.getInstance();
        final favoriteStories = prefs.getStringList('favoriteStories') ?? [];
        
        if (!currentState) {
          // إضافة للمفضلة
          if (!favoriteStories.contains(storyId.toString())) {
            favoriteStories.add(storyId.toString());
          }
        } else {
          // إزالة من المفضلة
          favoriteStories.remove(storyId.toString());
        }
        
        await prefs.setStringList('favoriteStories', favoriteStories);
      }
    } catch (e) {
      debugPrint('خطأ في تحديث المفضلة: $e');
    }
  }

  // الحصول على قصة بواسطة المعرف
  Story? getStoryById(int id) {
    try {
      return _stories.firstWhere((story) => story.id == id);
    } catch (e) {
      return null;
    }
  }

  // البحث في القصص
  List<Story> searchStories(String query) {
    if (query.isEmpty) return _stories;
    
    return _stories.where((story) =>
        story.title.toLowerCase().contains(query.toLowerCase()) ||
        story.content.toLowerCase().contains(query.toLowerCase()) ||
        story.category.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  // الحصول على القصص حسب التصنيف
  List<Story> getStoriesByCategory(String category) {
    return _stories.where((story) => story.category == category).toList();
  }

  // تحديث القصص (إعادة تحميل)
  Future<void> refreshStories() async {
    await _loadStoriesData();
  }
}