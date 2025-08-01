import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../providers/story_provider.dart';
import '../providers/dhikr_provider.dart';
import '../providers/prayer_time_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/daily_story_card.dart';
import '../widgets/quick_access_grid.dart';
import '../widgets/prayer_times_widget.dart';
import '../widgets/daily_dhikr_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryDark,
              AppColors.softWhite,
            ],
            stops: [0.0, 0.3],
          ),
        ),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // App Bar مخصص
            _buildCustomAppBar(padding),
            
            // المحتوى الرئيسي
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // رسالة الترحيب
                    _buildWelcomeMessage(),
                    
                    const SizedBox(height: 24),
                    
                    // بطاقة القصة اليومية
                    const DailyStoryCard(),
                    
                    const SizedBox(height: 24),
                    
                    // ذكر اليوم
                    const DailyDhikrCard(),
                    
                    const SizedBox(height: 24),
                    
                    // مواقيت الصلاة
                    const PrayerTimesWidget(),
                    
                    const SizedBox(height: 24),
                    
                    // الوصول السريع
                    _buildSectionTitle(AppStrings.quickAccess),
                    const SizedBox(height: 16),
                    const QuickAccessGrid(),
                    
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(EdgeInsets padding) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.primaryDark,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.appName,
                            style: GoogleFonts.amiri(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.lightGold,
                            ),
                          ),
                          Text(
                            _getGreetingMessage(),
                            style: GoogleFonts.cairo(
                              fontSize: 14,
                              color: AppColors.sandyBeige,
                            ),
                          ),
                        ],
                      ),
                      Consumer<SettingsProvider>(
                        builder: (context, settings, child) {
                          return IconButton(
                            onPressed: () {
                              settings.toggleDarkMode();
                            },
                            icon: Icon(
                              settings.isDarkMode 
                                  ? Icons.light_mode_rounded
                                  : Icons.dark_mode_rounded,
                              color: AppColors.lightGold,
                              size: 24,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return Consumer<PrayerTimeProvider>(
      builder: (context, prayerProvider, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppColors.cardShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _getTimeIcon(),
                    color: AppColors.primaryDark,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getGreetingMessage(),
                          style: GoogleFonts.cairo(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        Text(
                          _getCurrentDate(),
                          style: GoogleFonts.cairo(
                            fontSize: 14,
                            color: AppColors.mediumGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                _getMotivationalMessage(),
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  color: AppColors.darkGray,
                  height: 1.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.amiri(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
      ),
    );
  }

  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return AppStrings.goodMorning;
    } else if (hour < 18) {
      return 'أهلاً وسهلاً';
    } else {
      return AppStrings.goodEvening;
    }
  }

  IconData _getTimeIcon() {
    final hour = DateTime.now().hour;
    if (hour < 6 || hour > 18) {
      return Icons.nightlight_round;
    } else if (hour < 12) {
      return Icons.wb_sunny_rounded;
    } else {
      return Icons.wb_sunny_outlined;
    }
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE، d MMMM yyyy', 'ar');
    final hijriDate = context.read<PrayerTimeProvider>().getHijriDate();
    return '${formatter.format(now)} • $hijriDate';
  }

  String _getMotivationalMessage() {
    final messages = AppStrings.motivationalMessages;
    final today = DateTime.now();
    final dayOfYear = today.difference(DateTime(today.year, 1, 1)).inDays;
    final messageIndex = dayOfYear % messages.length;
    return messages[messageIndex];
  }
}