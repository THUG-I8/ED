import 'package:flutter/material.dart';

class IslamicEducationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التعليم الإسلامي'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green[50]!,
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildEducationCard(
              'أركان الإسلام',
              'الأركان الخمسة للإسلام',
              Icons.mosque,
              Colors.green[700]!,
              () => _showArkanDialog(context),
            ),
            _buildEducationCard(
              'أركان الإيمان',
              'الأركان الستة للإيمان',
              Icons.favorite,
              Colors.blue[700]!,
              () => _showImanDialog(context),
            ),
            _buildEducationCard(
              'أحكام الطهارة',
              'أحكام الوضوء والغسل',
              Icons.water_drop,
              Colors.cyan[700]!,
              () => _showTaharaDialog(context),
            ),
            _buildEducationCard(
              'أحكام الصلاة',
              'كيفية أداء الصلاة',
              Icons.access_time,
              Colors.orange[700]!,
              () => _showPrayerDialog(context),
            ),
            _buildEducationCard(
              'أحكام الصيام',
              'أحكام رمضان والصيام',
              Icons.sunny,
              Colors.amber[700]!,
              () => _showFastingDialog(context),
            ),
            _buildEducationCard(
              'أحكام الحج',
              'مناسك الحج والعمرة',
              Icons.location_on,
              Colors.purple[700]!,
              () => _showHajjDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: color,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showArkanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('أركان الإسلام'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildArkanItem('1', 'شهادة أن لا إله إلا الله وأن محمداً رسول الله'),
            _buildArkanItem('2', 'إقامة الصلاة'),
            _buildArkanItem('3', 'إيتاء الزكاة'),
            _buildArkanItem('4', 'صوم رمضان'),
            _buildArkanItem('5', 'حج البيت لمن استطاع إليه سبيلاً'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  Widget _buildArkanItem(String number, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.green[700],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _showImanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('أركان الإيمان'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildArkanItem('1', 'الإيمان بالله'),
            _buildArkanItem('2', 'الإيمان بالملائكة'),
            _buildArkanItem('3', 'الإيمان بالكتب'),
            _buildArkanItem('4', 'الإيمان بالرسل'),
            _buildArkanItem('5', 'الإيمان باليوم الآخر'),
            _buildArkanItem('6', 'الإيمان بالقدر خيره وشره'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showTaharaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('أحكام الطهارة'),
        content: Text('سيتم إضافة محتوى مفصل عن أحكام الطهارة قريباً...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showPrayerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('أحكام الصلاة'),
        content: Text('سيتم إضافة محتوى مفصل عن أحكام الصلاة قريباً...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showFastingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('أحكام الصيام'),
        content: Text('سيتم إضافة محتوى مفصل عن أحكام الصيام قريباً...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showHajjDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('أحكام الحج'),
        content: Text('سيتم إضافة محتوى مفصل عن أحكام الحج قريباً...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
        ],
      ),
    );
  }
}