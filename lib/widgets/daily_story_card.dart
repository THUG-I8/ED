import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../providers/story_provider.dart';
import '../screens/story_detail_screen.dart';

class DailyStoryCard extends StatelessWidget {
  const DailyStoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryProvider>(
      builder: (context, storyProvider, child) {
        if (storyProvider.isLoading) {
          return _buildLoadingCard();
        }

        if (storyProvider.error != null) {
          return _buildErrorCard(storyProvider.error!);
        }

        final todayStory = storyProvider.todayStory;
        if (todayStory == null) {
          return _buildEmptyCard();
        }

        return _buildStoryCard(context, todayStory, storyProvider);
      },
    );
  }

  Widget _buildStoryCard(BuildContext context, story, StoryProvider provider) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.goldGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.cardShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => StoryDetailScreen(story: story),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان والتصنيف
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        AppStrings.storyOfTheDay,
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.emeraldGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 14,
                            color: AppColors.emeraldGreen,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${story.readingTimeMinutes} دقائق',
                            style: GoogleFonts.cairo(
                              fontSize: 11,
                              color: AppColors.emeraldGreen,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // عنوان القصة
                Text(
                  story.title,
                  style: GoogleFonts.amiri(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                    height: 1.3,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // نبذة عن القصة
                Text(
                  _getStoryPreview(story.content),
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    color: AppColors.darkGray,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 16),
                
                // أزرار التفاعل
                Row(
                  children: [
                    _buildActionButton(
                      icon: Icons.play_circle_outline_rounded,
                      label: AppStrings.readStory,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StoryDetailScreen(story: story),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(width: 12),
                    
                    if (story.audioUrl != null)
                      _buildActionButton(
                        icon: Icons.headphones_rounded,
                        label: AppStrings.listenStory,
                        onTap: () {
                          // تشغيل الصوت
                        },
                      ),
                    
                    const Spacer(),
                    
                    // أيقونة المفضلة
                    IconButton(
                      onPressed: () {
                        provider.toggleFavorite(story.id);
                      },
                      icon: Icon(
                        story.isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: story.isFavorite
                            ? Colors.red[400]
                            : AppColors.mediumGray,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primaryDark.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: AppColors.primaryDark,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.lightGray.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryDark),
        ),
      ),
    );
  }

  Widget _buildErrorCard(String error) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.error.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: AppColors.error,
            size: 32,
          ),
          const SizedBox(height: 12),
          Text(
            'حدث خطأ في تحميل القصة',
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: GoogleFonts.cairo(
              fontSize: 14,
              color: AppColors.darkGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lightGray.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            Icons.auto_stories_outlined,
            color: AppColors.mediumGray,
            size: 32,
          ),
          const SizedBox(height: 12),
          Text(
            'لا توجد قصة متاحة اليوم',
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.mediumGray,
            ),
          ),
        ],
      ),
    );
  }

  String _getStoryPreview(String content) {
    // إزالة الفقرات الفارغة والمسافات الزائدة
    final cleanContent = content
        .replaceAll(RegExp(r'\n\s*\n'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    
    // أخذ أول 150 حرف
    if (cleanContent.length <= 150) {
      return cleanContent;
    }
    
    return '${cleanContent.substring(0, 150)}...';
  }
}