import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  // Create a 1024x1024 canvas for the app icon
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final size = Size(1024, 1024);
  
  // Create a gradient background (green to represent Islam)
  final paint = Paint()
    ..shader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF2E7D32), // Dark green
        Color(0xFF4CAF50), // Medium green
        Color(0xFF81C784), // Light green
      ],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
  
  canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  
  // Draw a crescent moon
  final moonPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;
  
  // Draw the crescent moon
  final moonPath = Path();
  moonPath.addOval(Rect.fromCenter(
    center: Offset(size.width * 0.6, size.height * 0.4),
    width: size.width * 0.4,
    height: size.height * 0.4,
  ));
  
  final innerMoonPath = Path();
  innerMoonPath.addOval(Rect.fromCenter(
    center: Offset(size.width * 0.5, size.height * 0.4),
    width: size.width * 0.4,
    height: size.height * 0.4,
  ));
  
  moonPath.op(innerMoonPath, PathOperation.difference);
  canvas.drawPath(moonPath, moonPaint);
  
  // Draw a star
  final starPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;
  
  final starPath = Path();
  final starCenter = Offset(size.width * 0.3, size.height * 0.6);
  final starRadius = size.width * 0.15;
  
  for (int i = 0; i < 5; i++) {
    final angle = (i * 2 * 3.14159) / 5 - 3.14159 / 2;
    final x = starCenter.dx + starRadius * cos(angle);
    final y = starCenter.dy + starRadius * sin(angle);
    
    if (i == 0) {
      starPath.moveTo(x, y);
    } else {
      starPath.lineTo(x, y);
    }
    
    final innerAngle = angle + 3.14159 / 5;
    final innerX = starCenter.dx + starRadius * 0.4 * cos(innerAngle);
    final innerY = starCenter.dy + starRadius * 0.4 * sin(innerAngle);
    starPath.lineTo(innerX, innerY);
  }
  starPath.close();
  canvas.drawPath(starPath, starPaint);
  
  // Add Arabic text "اعرف دينك"
  final textPainter = TextPainter(
    text: TextSpan(
      text: 'اعرف دينك',
      style: TextStyle(
        color: Colors.white,
        fontSize: size.width * 0.12,
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
      ),
    ),
    textDirection: TextDirection.rtl,
  );
  textPainter.layout();
  textPainter.paint(
    canvas,
    Offset(
      (size.width - textPainter.width) / 2,
      size.height * 0.8,
    ),
  );
  
  final picture = recorder.endRecording();
  final image = await picture.toImage(1024, 1024);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final bytes = byteData!.buffer.asUint8List();
  
  // Save the icon
  final file = File('assets/images/app_icon.png');
  await file.writeAsBytes(bytes);
  
  print('App icon generated successfully at assets/images/app_icon.png');
}