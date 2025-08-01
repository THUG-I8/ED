import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../providers/dhikr_provider.dart';

class DailyDhikrCard extends StatelessWidget {
  const DailyDhikrCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DhikrProvider>(
      builder: (context, dhikrProvider, child) {
        final todayDhikr = dhikrProvider.getTodayDhikr();
        
        if (todayDhikr == null) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.emeraldGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.emeraldGreen.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: AppColors.emeraldGreen,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    AppStrings.todaysWird,
                    style: GoogleFonts.amiri(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.emeraldGreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                todayDhikr.arabic,
                style: GoogleFonts.amiri(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                  height: 1.8,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                todayDhikr.translation,
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  color: AppColors.darkGray,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              if (todayDhikr.benefit != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.lightGold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'الفائدة: ${todayDhikr.benefit}',
                    style: GoogleFonts.cairo(
                      fontSize: 13,
                      color: AppColors.darkGray,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}