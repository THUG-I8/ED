import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({Key? key}) : super(key: key);

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen>
    with TickerProviderStateMixin {
  int _count = 0;
  int _target = 33;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final List<Map<String, dynamic>> _tasbihTypes = [
    {
      'name': 'سبحان الله',
      'arabic': 'سُبْحَانَ اللَّهِ',
      'target': 33,
      'color': const Color(0xFFE74C3C),
      'icon': Icons.auto_awesome,
    },
    {
      'name': 'الحمد لله',
      'arabic': 'الْحَمْدُ لِلَّهِ',
      'target': 33,
      'color': const Color(0xFF3498DB),
      'icon': Icons.favorite,
    },
    {
      'name': 'الله أكبر',
      'arabic': 'اللَّهُ أَكْبَرُ',
      'target': 33,
      'color': const Color(0xFF2ECC71),
      'icon': Icons.trending_up,
    },
    {
      'name': 'لا إله إلا الله',
      'arabic': 'لَا إِلَهَ إِلَّا اللَّهُ',
      'target': 100,
      'color': const Color(0xFF9B59B6),
      'icon': Icons.verified,
    },
    {
      'name': 'لا حول ولا قوة إلا بالله',
      'arabic': 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
      'target': 100,
      'color': const Color(0xFFF39C12),
      'icon': Icons.power,
    },
  ];

  int _selectedTasbihIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _updateTarget();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _updateTarget() {
    _target = _tasbihTypes[_selectedTasbihIndex]['target'];
  }

  void _incrementCount() {
    setState(() {
      _count++;
    });
    
    // تشغيل الاهتزاز
    HapticFeedback.lightImpact();
    
    // تشغيل الرسوم المتحركة
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    // التحقق من الوصول للهدف
    if (_count == _target) {
      _showCompletionDialog();
      _pulseController.repeat(reverse: true);
    }
  }

  void _resetCount() {
    setState(() {
      _count = 0;
    });
    _pulseController.stop();
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('أحسنت! 🎉'),
        content: Text(
          'لقد أكملت ${_tasbihTypes[_selectedTasbihIndex]['name']} ${_target} مرة',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetCount();
            },
            child: const Text('إعادة تعيين'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // الاستمرار في العد
            },
            child: const Text('متابعة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedTasbih = _tasbihTypes[_selectedTasbihIndex];
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              selectedTasbih['color'].withOpacity(0.8),
              selectedTasbih['color'].withOpacity(0.6),
              selectedTasbih['color'].withOpacity(0.4),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(selectedTasbih),
              Expanded(
                child: _buildMainContent(selectedTasbih),
              ),
              _buildTasbihSelector(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> selectedTasbih) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // أيقونة السبحة
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
            child: Icon(
              selectedTasbih['icon'],
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          
          // العنوان
          Text(
            'السبحة الإلكترونية',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 10),
          
          // نوع التسبيح المحدد
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              selectedTasbih['name'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(Map<String, dynamic> selectedTasbih) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // العداد الرئيسي
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _count == _target ? _pulseAnimation.value : 1.0,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: _incrementCount,
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$_count',
                                  style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'من ${selectedTasbih['target']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 30),
          
          // النص العربي
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              selectedTasbih['arabic'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
          ),
          
          const SizedBox(height: 30),
          
          // أزرار التحكم
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _resetCount,
                icon: const Icon(Icons.refresh),
                label: const Text('إعادة تعيين'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _incrementCount,
                icon: const Icon(Icons.add),
                label: const Text('تسبيح'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTasbihSelector() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'اختر نوع التسبيح',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _tasbihTypes.length,
              itemBuilder: (context, index) {
                final tasbih = _tasbihTypes[index];
                final isSelected = index == _selectedTasbihIndex;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTasbihIndex = index;
                      _count = 0;
                    });
                    _updateTarget();
                  },
                  child: Container(
                    width: 120,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? Colors.white.withOpacity(0.3)
                          : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected 
                            ? Colors.white
                            : Colors.white.withOpacity(0.3),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          tasbih['icon'],
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          tasbih['name'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${tasbih['target']} مرة',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}