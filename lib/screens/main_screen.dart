import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../constants/app_colors.dart';
import 'home_screen.dart';
import 'stories_screen.dart';
import 'tasbih_screen.dart';
import 'quran_screen.dart';
import 'more_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const HomeScreen(),
    const StoriesScreen(),
    const TasbihScreen(),
    const QuranScreen(),
    const MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.home_rounded, 0),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.auto_stories_rounded, 1),
            label: AppStrings.stories,
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.radio_button_checked_rounded, 2),
            label: AppStrings.tasbih,
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.menu_book_rounded, 3),
            label: AppStrings.quran,
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.more_horiz_rounded, 4),
            label: AppStrings.more,
          ),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    final isSelected = _currentIndex == index;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected 
            ? AppColors.primaryDark.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        size: 24,
        color: isSelected
            ? AppColors.primaryDark
            : AppColors.mediumGray,
      ),
    );
  }
}