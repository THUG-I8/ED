import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../providers/prayer_time_provider.dart';

class PrayerTimesWidget extends StatelessWidget {
  const PrayerTimesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PrayerTimeProvider>(
      builder: (context, prayerProvider, child) {
        if (prayerProvider.isLoading) {
          return _buildLoadingWidget();
        }

        if (prayerProvider.error != null) {
          return _buildErrorWidget(prayerProvider.error!);
        }

        return _buildPrayerTimesCard(prayerProvider);
      },
    );
  }

  Widget _buildPrayerTimesCard(PrayerTimeProvider provider) {
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
                Icons.schedule_rounded,
                color: AppColors.primaryDark,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                AppStrings.prayerTimes,
                style: GoogleFonts.amiri(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('مواقيت الصلاة ستظهر هنا بعد تفعيل الموقع'),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lightGray.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text('خطأ: $error'),
    );
  }
}