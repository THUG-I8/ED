import 'package:flutter/material.dart';

class SurahListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> surahs = [
    {'number': 1, 'name': 'الفاتحة', 'arabicName': 'الفاتحة', 'verses': 7, 'type': 'مكية'},
    {'number': 2, 'name': 'البقرة', 'arabicName': 'البقرة', 'verses': 286, 'type': 'مدنية'},
    {'number': 3, 'name': 'آل عمران', 'arabicName': 'آل عمران', 'verses': 200, 'type': 'مدنية'},
    {'number': 4, 'name': 'النساء', 'arabicName': 'النساء', 'verses': 176, 'type': 'مدنية'},
    {'number': 5, 'name': 'المائدة', 'arabicName': 'المائدة', 'verses': 120, 'type': 'مدنية'},
    {'number': 6, 'name': 'الأنعام', 'arabicName': 'الأنعام', 'verses': 165, 'type': 'مكية'},
    {'number': 7, 'name': 'الأعراف', 'arabicName': 'الأعراف', 'verses': 206, 'type': 'مكية'},
    {'number': 8, 'name': 'الأنفال', 'arabicName': 'الأنفال', 'verses': 75, 'type': 'مدنية'},
    {'number': 9, 'name': 'التوبة', 'arabicName': 'التوبة', 'verses': 129, 'type': 'مدنية'},
    {'number': 10, 'name': 'يونس', 'arabicName': 'يونس', 'verses': 109, 'type': 'مكية'},
    {'number': 11, 'name': 'هود', 'arabicName': 'هود', 'verses': 123, 'type': 'مكية'},
    {'number': 12, 'name': 'يوسف', 'arabicName': 'يوسف', 'verses': 111, 'type': 'مكية'},
    {'number': 13, 'name': 'الرعد', 'arabicName': 'الرعد', 'verses': 43, 'type': 'مدنية'},
    {'number': 14, 'name': 'إبراهيم', 'arabicName': 'إبراهيم', 'verses': 52, 'type': 'مكية'},
    {'number': 15, 'name': 'الحجر', 'arabicName': 'الحجر', 'verses': 99, 'type': 'مكية'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة السور'),
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
          child: Column(
            children: [
              // معلومات عامة
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildInfoCard('عدد السور', '114', Icons.book),
                    _buildInfoCard('عدد الآيات', '6236', Icons.text_fields),
                    _buildInfoCard('عدد الأجزاء', '30', Icons.folder),
                  ],
                ),
              ),
              
              // قائمة السور
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: surahs.length,
                  itemBuilder: (context, index) {
                    final surah = surahs[index];
                    return _buildSurahCard(context, surah);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 25,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Cairo',
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }

  Widget _buildSurahCard(BuildContext context, Map<String, dynamic> surah) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(20),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              '${surah['number']}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ),
        title: Text(
          surah['arabicName'],
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Cairo',
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text(
              surah['name'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
                fontFamily: 'Cairo',
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: surah['type'] == 'مكية' ? Colors.orange : Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    surah['type'],
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '${surah['verses']} آية',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.7),
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        onTap: () {
          // سيتم إضافة الانتقال لصفحة السورة لاحقاً
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('سيتم إضافة محتوى سورة ${surah['arabicName']} قريباً'),
              backgroundColor: Color(0xFF2E7D32),
            ),
          );
        },
      ),
    );
  }
}