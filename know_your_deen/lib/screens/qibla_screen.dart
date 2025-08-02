import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({Key? key}) : super(key: key);

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen>
    with TickerProviderStateMixin {
  late AnimationController _compassController;
  late AnimationController _pulseController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;
  
  double _currentDirection = 0.0;
  double _qiblaDirection = 135.0; // اتجاه القبلة من القاهرة
  bool _isCalibrating = false;

  @override
  void initState() {
    super.initState();
    
    _compassController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _compassController,
      curve: Curves.easeInOut,
    ));
    
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _startCompass();
  }

  @override
  void dispose() {
    _compassController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _startCompass() {
    _compassController.repeat();
    _pulseController.repeat(reverse: true);
  }

  void _calibrateCompass() {
    setState(() {
      _isCalibrating = true;
    });
    
    // محاكاة معايرة البوصلة
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isCalibrating = false;
        _currentDirection = _qiblaDirection;
      });
    });
  }

  double _getQiblaAngle() {
    return (_qiblaDirection - _currentDirection) * (math.pi / 180);
  }

  bool _isPointingToQibla() {
    final angleDiff = (_qiblaDirection - _currentDirection).abs();
    return angleDiff < 10 || angleDiff > 350; // هامش 10 درجات
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
              Color(0xFF1565C0), // أزرق داكن
              Color(0xFF1976D2), // أزرق متوسط
              Color(0xFF42A5F5), // أزرق فاتح
              Color(0xFF90CAF9), // أزرق فاتح جداً
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _buildCompass(),
              ),
              _buildControls(),
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
          // أيقونة البوصلة
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
              Icons.explore,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          
          // العنوان
          const Text(
            'اتجاه القبلة',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 10),
          
          // الحالة
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: _isPointingToQibla() 
                  ? Colors.green.withOpacity(0.3)
                  : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: _isPointingToQibla() 
                    ? Colors.green
                    : Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              _isPointingToQibla() ? '🎯 تشير إلى القبلة' : '📍 جاري البحث عن القبلة',
              style: TextStyle(
                fontSize: 16,
                color: _isPointingToQibla() ? Colors.green : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompass() {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // البوصلة الخارجية
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
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
              child: CustomPaint(
                painter: CompassPainter(),
              ),
            ),
            
            // السهم المتحرك
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _getQiblaAngle(),
                  child: Container(
                    width: 200,
                    height: 200,
                    child: CustomPaint(
                      painter: ArrowPainter(
                        isPointingToQibla: _isPointingToQibla(),
                      ),
                    ),
                  ),
                );
              },
            ),
            
            // النقطة المركزية
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _isPointingToQibla() ? Colors.green : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            // مؤشر القبلة
            if (_isPointingToQibla())
              Positioned(
                top: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 16),
                      SizedBox(width: 5),
                      Text(
                        'القبلة',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
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

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // معلومات الاتجاه
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDirectionInfo('الاتجاه الحالي', '${_currentDirection.toInt()}°'),
                _buildDirectionInfo('اتجاه القبلة', '${_qiblaDirection.toInt()}°'),
                _buildDirectionInfo('المسافة', '${(_qiblaDirection - _currentDirection).abs().toInt()}°'),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // أزرار التحكم
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _isCalibrating ? null : _calibrateCompass,
                icon: _isCalibrating 
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.refresh),
                label: Text(_isCalibrating ? 'معايرة...' : 'معايرة'),
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
                onPressed: () {
                  HapticFeedback.lightImpact();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم تحديد اتجاه القبلة'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.location_on),
                label: const Text('تحديد الموقع'),
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
          
          const SizedBox(height: 20),
          
          // معلومات إضافية
          Container(
            padding: const EdgeInsets.all(15),
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
                  '💡 نصيحة',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'قم بمعايرة البوصلة قبل الاستخدام للحصول على دقة أفضل',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectionInfo(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class CompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    
    // رسم دوائر متحدة المركز
    for (int i = 1; i <= 3; i++) {
      canvas.drawCircle(center, radius * i / 4, paint);
    }
    
    // رسم خطوط الاتجاهات
    final directions = ['N', 'E', 'S', 'W'];
    final angles = [0, 90, 180, 270];
    
    for (int i = 0; i < directions.length; i++) {
      final angle = angles[i] * (math.pi / 180);
      final startPoint = Offset(
        center.dx + (radius - 20) * math.cos(angle),
        center.dy + (radius - 20) * math.sin(angle),
      );
      final endPoint = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      
      canvas.drawLine(startPoint, endPoint, paint);
      
      // كتابة الاتجاهات
      final textPainter = TextPainter(
        text: TextSpan(
          text: directions[i],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      
      final textOffset = Offset(
        center.dx + (radius - 40) * math.cos(angle) - textPainter.width / 2,
        center.dy + (radius - 40) * math.sin(angle) - textPainter.height / 2,
      );
      textPainter.paint(canvas, textOffset);
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ArrowPainter extends CustomPainter {
  final bool isPointingToQibla;
  
  ArrowPainter({required this.isPointingToQibla});
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = isPointingToQibla ? Colors.green : Colors.white
      ..style = PaintingStyle.fill;
    
    // رسم السهم
    final path = Path();
    path.moveTo(center.dx, center.dy - size.height / 2 + 20);
    path.lineTo(center.dx - 10, center.dy - size.height / 2 + 40);
    path.lineTo(center.dx + 10, center.dy - size.height / 2 + 40);
    path.close();
    
    canvas.drawPath(path, paint);
    
    // رسم خط السهم
    final linePaint = Paint()
      ..color = isPointingToQibla ? Colors.green : Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    
    canvas.drawLine(
      center,
      Offset(center.dx, center.dy - size.height / 2 + 20),
      linePaint,
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}