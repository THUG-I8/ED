import 'package:flutter/material.dart';

class QuranSettingsScreen extends StatefulWidget {
  @override
  _QuranSettingsScreenState createState() => _QuranSettingsScreenState();
}

class _QuranSettingsScreenState extends State<QuranSettingsScreen> {
  double _fontSize = 24.0;
  double _lineSpacing = 1.5;
  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;
  bool _showTranslation = true;
  String _selectedFont = 'Cairo';

  final List<String> _fonts = [
    'Cairo',
    'Amiri',
    'Noto Naskh Arabic',
    'Noto Sans Arabic',
    'Almarai',
  ];

  final List<Color> _backgroundColors = [
    Colors.white,
    Color(0xFFF8F6F1),
    Color(0xFFE6F3FF),
    Color(0xFFFFF8E1),
    Color(0xFFF3E5F5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إعدادات القرآن'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2E7D32),
              Color(0xFF388E3C),
              Color(0xFF4CAF50),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // معاينة النص
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'معاينة النص',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _textColor,
                          fontFamily: _selectedFont,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                        style: TextStyle(
                          fontSize: _fontSize,
                          color: _textColor,
                          fontFamily: _selectedFont,
                          height: _lineSpacing,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (_showTranslation) ...[
                        SizedBox(height: 10),
                        Text(
                          'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
                          style: TextStyle(
                            fontSize: _fontSize * 0.8,
                            color: _textColor.withOpacity(0.7),
                            fontFamily: _selectedFont,
                            height: _lineSpacing * 0.9,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 30),
                
                // إعدادات الخط
                Expanded(
                  child: ListView(
                    children: [
                      _buildSettingCard(
                        'حجم الخط',
                        Slider(
                          value: _fontSize,
                          min: 16.0,
                          max: 40.0,
                          divisions: 24,
                          activeColor: Colors.white,
                          inactiveColor: Colors.white.withOpacity(0.3),
                          onChanged: (value) {
                            setState(() {
                              _fontSize = value;
                            });
                          },
                        ),
                        '${_fontSize.toInt()}',
                      ),
                      
                      _buildSettingCard(
                        'المسافة بين الأسطر',
                        Slider(
                          value: _lineSpacing,
                          min: 1.0,
                          max: 3.0,
                          divisions: 20,
                          activeColor: Colors.white,
                          inactiveColor: Colors.white.withOpacity(0.3),
                          onChanged: (value) {
                            setState(() {
                              _lineSpacing = value;
                            });
                          },
                        ),
                        '${_lineSpacing.toStringAsFixed(1)}',
                      ),
                      
                      _buildSettingCard(
                        'نوع الخط',
                        DropdownButton<String>(
                          value: _selectedFont,
                          dropdownColor: Color(0xFF2E7D32),
                          style: TextStyle(color: Colors.white),
                          underline: Container(),
                          items: _fonts.map((font) {
                            return DropdownMenuItem(
                              value: font,
                              child: Text(font),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedFont = value!;
                            });
                          },
                        ),
                        '',
                      ),
                      
                      _buildSettingCard(
                        'لون الخلفية',
                        Container(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _backgroundColors.length,
                            itemBuilder: (context, index) {
                              final color = _backgroundColors[index];
                              final isSelected = _backgroundColor == color;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _backgroundColor = color;
                                  });
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: isSelected ? Colors.white : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        '',
                      ),
                      
                      _buildSettingCard(
                        'إظهار الترجمة',
                        Switch(
                          value: _showTranslation,
                          activeColor: Colors.white,
                          activeTrackColor: Colors.white.withOpacity(0.3),
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey.withOpacity(0.3),
                          onChanged: (value) {
                            setState(() {
                              _showTranslation = value;
                            });
                          },
                        ),
                        _showTranslation ? 'مفعل' : 'معطل',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingCard(String title, Widget control, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cairo',
                ),
              ),
              if (value.isNotEmpty)
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                    fontFamily: 'Cairo',
                  ),
                ),
            ],
          ),
          SizedBox(height: 15),
          control,
        ],
      ),
    );
  }
}