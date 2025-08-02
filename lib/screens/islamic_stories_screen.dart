import 'package:flutter/material.dart';

class IslamicStoriesScreen extends StatefulWidget {
  @override
  _IslamicStoriesScreenState createState() => _IslamicStoriesScreenState();
}

class _IslamicStoriesScreenState extends State<IslamicStoriesScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<StoryCategory> _categories = [
    StoryCategory(
      title: 'قصص الأنبياء',
      subtitle: 'قصص الأنبياء والرسل عليهم السلام',
      icon: Icons.person,
      color: Colors.blue[700]!,
      stories: [
        Story(
          title: 'قصة سيدنا محمد ﷺ',
          subtitle: 'سيرة النبي محمد صلى الله عليه وسلم',
          description: 'قصة حياة النبي محمد صلى الله عليه وسلم من مولده إلى وفاته',
        ),
        Story(
          title: 'قصة سيدنا إبراهيم عليه السلام',
          subtitle: 'خليل الرحمن',
          description: 'قصة النبي إبراهيم عليه السلام وبناء الكعبة',
        ),
        Story(
          title: 'قصة سيدنا موسى عليه السلام',
          subtitle: 'كليم الله',
          description: 'قصة النبي موسى عليه السلام وفرعون',
        ),
        Story(
          title: 'قصة سيدنا عيسى عليه السلام',
          subtitle: 'روح الله',
          description: 'قصة النبي عيسى عليه السلام ومعجزاته',
        ),
      ],
    ),
    StoryCategory(
      title: 'قصص الصحابة',
      subtitle: 'قصص الصحابة رضي الله عنهم',
      icon: Icons.group,
      color: Colors.green[700]!,
      stories: [
        Story(
          title: 'قصة أبو بكر الصديق رضي الله عنه',
          subtitle: 'الصديق الأول',
          description: 'قصة أول خليفة في الإسلام',
        ),
        Story(
          title: 'قصة عمر بن الخطاب رضي الله عنه',
          subtitle: 'الفاروق',
          description: 'قصة الخليفة العادل عمر بن الخطاب',
        ),
        Story(
          title: 'قصة عثمان بن عفان رضي الله عنه',
          subtitle: 'ذي النورين',
          description: 'قصة الخليفة عثمان بن عفان',
        ),
        Story(
          title: 'قصة علي بن أبي طالب رضي الله عنه',
          subtitle: 'أمير المؤمنين',
          description: 'قصة الخليفة علي بن أبي طالب',
        ),
      ],
    ),
    StoryCategory(
      title: 'قصص تاريخية',
      subtitle: 'قصص من التاريخ الإسلامي',
      icon: Icons.history,
      color: Colors.orange[700]!,
      stories: [
        Story(
          title: 'فتح مكة',
          subtitle: 'الفتح الأعظم',
          description: 'قصة فتح مكة المكرمة',
        ),
        Story(
          title: 'معركة بدر',
          subtitle: 'غزوة الفرقان',
          description: 'قصة أول معركة في الإسلام',
        ),
        Story(
          title: 'صلح الحديبية',
          subtitle: 'الصلح العظيم',
          description: 'قصة صلح الحديبية',
        ),
        Story(
          title: 'فتح الأندلس',
          subtitle: 'فتح أوروبا',
          description: 'قصة فتح الأندلس',
        ),
      ],
    ),
    StoryCategory(
      title: 'قصص تربوية',
      subtitle: 'قصص تعليمية وتربوية',
      icon: Icons.school,
      color: Colors.purple[700]!,
      stories: [
        Story(
          title: 'قصة الأمانة',
          subtitle: 'الأمانة خلق الأنبياء',
          description: 'قصص عن الأمانة في الإسلام',
        ),
        Story(
          title: 'قصة الصدق',
          subtitle: 'الصدق منجاة',
          description: 'قصص عن الصدق وأهميته',
        ),
        Story(
          title: 'قصة الصبر',
          subtitle: 'الصبر مفتاح الفرج',
          description: 'قصص عن الصبر في الإسلام',
        ),
        Story(
          title: 'قصة التواضع',
          subtitle: 'التواضع من خلق المؤمنين',
          description: 'قصص عن التواضع',
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'القصص الإسلامية',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              return _buildCategoryCard(_categories[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(StoryCategory category) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _showStoriesDialog(context, category);
          },
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                // Category icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [category.color, category.color.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: category.color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    category.icon,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                SizedBox(width: 16),
                
                // Category details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        category.subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${category.stories.length} قصة',
                        style: TextStyle(
                          fontSize: 12,
                          color: category.color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Arrow icon
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showStoriesDialog(BuildContext context, StoryCategory category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: double.maxFinite,
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [category.color, category.color.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        category.icon,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              category.subtitle,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                
                // Stories list
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: category.stories.length,
                    itemBuilder: (context, index) {
                      return _buildStoryCard(category.stories[index], category.color);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStoryCard(Story story, Color categoryColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: categoryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(context).pop();
            _showStoryDetails(context, story, categoryColor);
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  story.subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: categoryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  story.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showStoryDetails(BuildContext context, Story story, Color categoryColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: double.maxFinite,
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [categoryColor, categoryColor.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              story.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              story.subtitle,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                
                // Content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'قريباً...',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'سيتم إضافة محتوى هذه القصة قريباً بإذن الله',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Icon(
                            Icons.construction,
                            size: 80,
                            color: Colors.grey[400],
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
      },
    );
  }
}

class StoryCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<Story> stories;

  StoryCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.stories,
  });
}

class Story {
  final String title;
  final String subtitle;
  final String description;

  Story({
    required this.title,
    required this.subtitle,
    required this.description,
  });
}