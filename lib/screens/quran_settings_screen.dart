import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quran_settings_provider.dart';

class QuranSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إعدادات المصحف'),
        centerTitle: true,
      ),
      body: Consumer<QuranSettingsProvider>(
        builder: (context, settings, child) {
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              // نوع الخط
              _buildSection(
                'نوع الخط',
                DropdownButton<String>(
                  value: settings.fontFamily,
                  isExpanded: true,
                  items: QuranSettingsProvider.availableFonts.map((font) {
                    return DropdownMenuItem(
                      value: font,
                      child: Text(font),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      settings.setFontFamily(value);
                    }
                  },
                ),
              ),
              
              SizedBox(height: 20),
              
              // حجم الخط
              _buildSection(
                'حجم الخط: ${settings.fontSize.toInt()}',
                Slider(
                  value: settings.fontSize,
                  min: 16.0,
                  max: 40.0,
                  divisions: 24,
                  onChanged: (value) {
                    settings.setFontSize(value);
                  },
                ),
              ),
              
              SizedBox(height: 20),
              
              // المسافة بين الأسطر
              _buildSection(
                'المسافة بين الأسطر: ${settings.lineSpacing.toStringAsFixed(1)}',
                Slider(
                  value: settings.lineSpacing,
                  min: 1.0,
                  max: 3.0,
                  divisions: 20,
                  onChanged: (value) {
                    settings.setLineSpacing(value);
                  },
                ),
              ),
              
              SizedBox(height: 20),
              
              // لون الخلفية
              _buildSection(
                'لون الخلفية',
                Wrap(
                  spacing: 8,
                  children: QuranSettingsProvider.availableColors.map((color) {
                    return GestureDetector(
                      onTap: () {
                        settings.setBackgroundColor(color);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          border: Border.all(
                            color: settings.backgroundColor == color
                                ? Colors.green
                                : Colors.grey,
                            width: settings.backgroundColor == color ? 3 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              
              SizedBox(height: 20),
              
              // إظهار الترجمة
              _buildSection(
                'إظهار الترجمة',
                Switch(
                  value: settings.showTranslation,
                  onChanged: (value) {
                    settings.toggleTranslation();
                  },
                ),
              ),
              
              SizedBox(height: 30),
              
              // معاينة
              _buildPreviewSection(settings),
              
              SizedBox(height: 30),
              
              // إعادة تعيين
              ElevatedButton(
                onPressed: () {
                  settings.resetToDefaults();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تم إعادة تعيين الإعدادات'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'إعادة تعيين الإعدادات',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildPreviewSection(QuranSettingsProvider settings) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: settings.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معاينة',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 12),
          Text(
            'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
            style: TextStyle(
              fontFamily: settings.fontFamily,
              fontSize: settings.fontSize,
              color: settings.textColor,
              height: settings.lineSpacing,
            ),
            textDirection: TextDirection.rtl,
          ),
          if (settings.showTranslation) ...[
            SizedBox(height: 8),
            Text(
              'In the name of Allah, the Entirely Merciful, the Especially Merciful',
              style: TextStyle(
                fontSize: settings.fontSize * 0.8,
                color: Colors.grey[600],
                height: settings.lineSpacing * 0.9,
              ),
            ),
          ],
        ],
      ),
    );
  }
}