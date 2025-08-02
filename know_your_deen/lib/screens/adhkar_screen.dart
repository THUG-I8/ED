import 'package:flutter/material.dart';

class AdhkarScreen extends StatefulWidget {
  const AdhkarScreen({Key? key}) : super(key: key);

  @override
  State<AdhkarScreen> createState() => _AdhkarScreenState();
}

class _AdhkarScreenState extends State<AdhkarScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2E7D32), // أخضر داكن
              Color(0xFF4CAF50), // أخضر متوسط
              Color(0xFF81C784), // أخضر فاتح
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _buildAdhkarContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // أيقونة الأذكار
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.favorite,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          
          // العنوان
          FadeTransition(
            opacity: _fadeAnimation,
            child: const Text(
              'الأذكار اليومية',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          const SizedBox(height: 10),
          
          // الوصف
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: const Text(
                'أذكار الصباح والمساء وأذكار النوم والاستيقاظ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdhkarContent() {
    final adhkarCategories = [
      {
        'title': 'أذكار الصباح',
        'icon': Icons.wb_sunny,
        'color': const Color(0xFFFF9800),
        'count': 12,
      },
      {
        'title': 'أذكار المساء',
        'icon': Icons.nightlight_round,
        'color': const Color(0xFF3F51B5),
        'count': 10,
      },
      {
        'title': 'أذكار النوم',
        'icon': Icons.bedtime,
        'color': const Color(0xFF9C27B0),
        'count': 8,
      },
      {
        'title': 'أذكار الاستيقاظ',
        'icon': Icons.alarm,
        'color': const Color(0xFF4CAF50),
        'count': 6,
      },
      {
        'title': 'أذكار المسجد',
        'icon': Icons.mosque,
        'color': const Color(0xFF795548),
        'count': 5,
      },
      {
        'title': 'أذكار عامة',
        'icon': Icons.auto_awesome,
        'color': const Color(0xFF607D8B),
        'count': 15,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'اختر نوع الأذكار',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.2,
              ),
              itemCount: adhkarCategories.length,
              itemBuilder: (context, index) {
                final category = adhkarCategories[index];
                return _buildAdhkarCard(category);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdhkarCard(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        _showAdhkarList(category['title']);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: category['color'].withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                category['icon'],
                size: 25,
                color: category['color'],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              category['title'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              '${category['count']} ذكر',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAdhkarList(String categoryTitle) {
    final adhkarList = _getAdhkarList(categoryTitle);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _getCategoryColor(categoryTitle),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Icon(
                    _getCategoryIcon(categoryTitle),
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      categoryTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: adhkarList.length,
                itemBuilder: (context, index) {
                  final dhikr = adhkarList[index];
                  return _buildDhikrCard(dhikr, index + 1);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDhikrCard(Map<String, dynamic> dhikr, int number) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: _getCategoryColor(dhikr['category']),
          child: Text(
            '$number',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          dhikr['title'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          'عدد المرات: ${dhikr['count']}',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dhikr['arabic'],
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.8,
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
                if (dhikr['translation'] != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    dhikr['translation'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الفضل: ${dhikr['benefit']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // يمكن إضافة صوت أو اهتزاز هنا
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تم قراءة: ${dhikr['title']}'),
                            backgroundColor: _getCategoryColor(dhikr['category']),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_arrow, size: 16),
                      label: const Text('استماع'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getCategoryColor(dhikr['category']),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getAdhkarList(String category) {
    switch (category) {
      case 'أذكار الصباح':
        return [
          {
            'title': 'سبحان الله',
            'arabic': 'سُبْحَانَ اللَّهِ',
            'translation': 'Glory be to Allah',
            'count': '3 مرات',
            'benefit': 'مغفرة الذنوب',
            'category': 'أذكار الصباح',
          },
          {
            'title': 'الحمد لله',
            'arabic': 'الْحَمْدُ لِلَّهِ',
            'translation': 'Praise be to Allah',
            'count': '3 مرات',
            'benefit': 'ثواب عظيم',
            'category': 'أذكار الصباح',
          },
          {
            'title': 'لا إله إلا الله',
            'arabic': 'لَا إِلَهَ إِلَّا اللَّهُ',
            'translation': 'There is no god but Allah',
            'count': '3 مرات',
            'benefit': 'حماية من الشيطان',
            'category': 'أذكار الصباح',
          },
          {
            'title': 'الله أكبر',
            'arabic': 'اللَّهُ أَكْبَرُ',
            'translation': 'Allah is the Greatest',
            'count': '3 مرات',
            'benefit': 'تعظيم الله',
            'category': 'أذكار الصباح',
          },
        ];
      case 'أذكار المساء':
        return [
          {
            'title': 'أعوذ بكلمات الله التامات',
            'arabic': 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ الَّتِي لَا يُجَاوِزُهُنَّ بَرٌّ وَلَا فَاجِرٌ',
            'translation': 'I seek refuge in Allah\'s perfect words',
            'count': '3 مرات',
            'benefit': 'حماية من كل شر',
            'category': 'أذكار المساء',
          },
          {
            'title': 'باسمك ربي وضعت جنبي',
            'arabic': 'بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي، وَبِكَ أَرْفَعُهُ، فَإِنْ أَمْسَكْتَ نَفْسِي فَارْحَمْهَا، وَإِنْ أَرْسَلْتَهَا فَاحْفَظْهَا بِمَا تَحْفَظُ بِهِ عِبَادَكَ الصَّالِحِينَ',
            'translation': 'In Your name, my Lord, I lay my side down',
            'count': 'مرة واحدة',
            'benefit': 'حماية في النوم',
            'category': 'أذكار المساء',
          },
        ];
      default:
        return [
          {
            'title': 'سبحان الله',
            'arabic': 'سُبْحَانَ اللَّهِ',
            'translation': 'Glory be to Allah',
            'count': '3 مرات',
            'benefit': 'مغفرة الذنوب',
            'category': category,
          },
        ];
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'أذكار الصباح':
        return const Color(0xFFFF9800);
      case 'أذكار المساء':
        return const Color(0xFF3F51B5);
      case 'أذكار النوم':
        return const Color(0xFF9C27B0);
      case 'أذكار الاستيقاظ':
        return const Color(0xFF4CAF50);
      case 'أذكار المسجد':
        return const Color(0xFF795548);
      default:
        return const Color(0xFF607D8B);
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'أذكار الصباح':
        return Icons.wb_sunny;
      case 'أذكار المساء':
        return Icons.nightlight_round;
      case 'أذكار النوم':
        return Icons.bedtime;
      case 'أذكار الاستيقاظ':
        return Icons.alarm;
      case 'أذكار المسجد':
        return Icons.mosque;
      default:
        return Icons.auto_awesome;
    }
  }
}