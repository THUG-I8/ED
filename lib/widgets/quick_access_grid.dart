import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class QuickAccessGrid extends StatelessWidget {
  const QuickAccessGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildQuickAccessItem(
          icon: Icons.radio_button_checked_rounded,
          title: AppStrings.tasbih,
          subtitle: 'السبحة الإلكترونية',
          color: AppColors.emeraldGreen,
          onTap: () {},
        ),
        _buildQuickAccessItem(
          icon: Icons.schedule_rounded,
          title: AppStrings.prayerTimes,
          subtitle: 'مواقيت الصلاة',
          color: AppColors.lightGold,
          onTap: () {},
        ),
        _buildQuickAccessItem(
          icon: Icons.auto_awesome_rounded,
          title: AppStrings.morningAdhkar,
          subtitle: 'أذكار الصباح',
          color: AppColors.info,
          onTap: () {},
        ),
        _buildQuickAccessItem(
          icon: Icons.explore_rounded,
          title: AppStrings.qiblaDirection,
          subtitle: 'اتجاه القبلة',
          color: AppColors.success,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildQuickAccessItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.softShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    color: AppColors.mediumGray,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}