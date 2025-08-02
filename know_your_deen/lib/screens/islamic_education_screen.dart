import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quran_settings_provider.dart';

class IslamicEducationScreen extends StatefulWidget {
  const IslamicEducationScreen({Key? key}) : super(key: key);

  @override
  State<IslamicEducationScreen> createState() => _IslamicEducationScreenState();
}

class _IslamicEducationScreenState extends State<IslamicEducationScreen>
    with TickerProviderStateMixin {
  late AnimationController _titleController;
  late AnimationController _contentController;
  late Animation<Offset> _titleAnimation;
  late Animation<Offset> _contentAnimation;

  @override
  void initState() {
    super.initState();
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _titleAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _titleController,
      curve: Curves.elasticOut,
    ));

    _contentAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _contentController,
      curve: Curves.easeOutBack,
    ));

    _titleController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _contentController.forward();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
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
              Color(0xFF1E3A8A), // أزرق داكن
              Color(0xFF3B82F6), // أزرق متوسط
              Color(0xFF60A5FA), // أزرق فاتح
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                _buildMainContent(),
                _buildCategories(),
                _buildFooter(),
              ],
            ),
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
          // أيقونة التطبيق
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.mosque,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          
          // العنوان الرئيسي
          SlideTransition(
            position: _titleAnimation,
            child: const Text(
              'ما لا يسع أطفال المسلمين جهله',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Cairo',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 15),
          
          // الوصف
          SlideTransition(
            position: _contentAnimation,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: const Column(
                children: [
                  Text(
                    'مشروع يحوي منهجًا يسيرًا سهلًا لمسائل لا يسع المسلم جهلها، يشمل مسائل العقيدة والفقه والسيرة والآداب والتفسير والحديث والأخلاق والأذكار، ويصلح للصغار خصوصًا ولكافة الأعمار وحديثي الإسلام',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'المحتوى من كتاب ما لا يسع أطفال المسلمين جهله لمؤلفه يزن الغانم',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // زر التحميل
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 30),
            child: ElevatedButton.icon(
              onPressed: () {
                _showDownloadDialog();
              },
              icon: const Icon(Icons.download, size: 24),
              label: const Text(
                'تحميل الكتاب',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
            ),
          ),
          
          // زر الصلاة على النبي
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 30),
            child: ElevatedButton.icon(
              onPressed: () {
                _showPrayerDialog();
              },
              icon: const Icon(Icons.favorite, size: 24),
              label: const Text(
                'صلي على سيدنا محمد ﷺ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      {
        'title': 'العقيدة',
        'icon': Icons.psychology,
        'color': const Color(0xFFE74C3C),
        'description': 'أصول الإيمان والإسلام',
      },
      {
        'title': 'الفقه',
        'icon': Icons.gavel,
        'color': const Color(0xFF3498DB),
        'description': 'أحكام العبادات والمعاملات',
      },
      {
        'title': 'السيرة',
        'icon': Icons.history_edu,
        'color': const Color(0xFF2ECC71),
        'description': 'سيرة النبي ﷺ والصحابة',
      },
      {
        'title': 'الآداب',
        'icon': Icons.people,
        'color': const Color(0xFF9B59B6),
        'description': 'آداب الإسلام وأخلاقه',
      },
      {
        'title': 'التفسير',
        'icon': Icons.menu_book,
        'color': const Color(0xFFF39C12),
        'description': 'تفسير القرآن الكريم',
      },
      {
        'title': 'الحديث',
        'icon': Icons.record_voice_over,
        'color': const Color(0xFF1ABC9C),
        'description': 'أحاديث النبي ﷺ',
      },
      {
        'title': 'الأخلاق',
        'icon': Icons.favorite,
        'color': const Color(0xFFE67E22),
        'description': 'الأخلاق الحميدة',
      },
      {
        'title': 'الأذكار',
        'icon': Icons.auto_awesome,
        'color': const Color(0xFF34495E),
        'description': 'أذكار الصباح والمساء',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'أقسام المنهج',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.1,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return _buildCategoryCard(category);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        _showCategoryContent(category['title']);
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
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: category['color'].withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                category['icon'],
                size: 30,
                color: category['color'],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              category['title'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              category['description'],
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, color: Colors.white70, size: 20),
                SizedBox(width: 8),
                Text(
                  'تطبيق مجاني ومفتوح المصدر',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'بارك الله فيكم ونفع بهذا التطبيق 🤲',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showDownloadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تحميل الكتاب'),
        content: const Text('هل تريد تحميل كتاب "ما لا يسع أطفال المسلمين جهله"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // هنا يمكن إضافة رابط التحميل الفعلي
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('سيتم إضافة رابط التحميل قريباً'),
                ),
              );
            },
            child: const Text('تحميل'),
          ),
        ],
      ),
    );
  }

  void _showPrayerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('الصلاة على النبي ﷺ'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ، كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ، إِنَّكَ حَمِيدٌ مَجِيدٌ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 10),
            Text(
              'اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ، كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ، إِنَّكَ حَمِيدٌ مَجِيدٌ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('آمين'),
          ),
        ],
      ),
    );
  }

  void _showCategoryContent(String categoryTitle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF1E3A8A),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Text(
                    categoryTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'سيتم إضافة المحتوى قريباً',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'هذا القسم سيحتوي على محتوى تعليمي مفصل في مجال $categoryTitle',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}