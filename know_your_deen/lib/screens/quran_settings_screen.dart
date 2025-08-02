import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quran_settings_provider.dart';
import '../models/quran_settings.dart';

class QuranSettingsScreen extends StatelessWidget {
  const QuranSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات المصحف'),
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<QuranSettingsProvider>().resetToDefault();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إعادة تعيين الإعدادات')),
              );
            },
            tooltip: 'إعادة تعيين',
          ),
        ],
      ),
      body: Consumer<QuranSettingsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('الخط وحجمه'),
                _buildFontFamilySelector(context, provider),
                _buildFontSizeSelector(context, provider),
                _buildLineSpacingSelector(context, provider),
                
                const SizedBox(height: 24),
                _buildSectionTitle('الألوان'),
                _buildBackgroundColorSelector(context, provider),
                _buildTextColorSelector(context, provider),
                
                const SizedBox(height: 24),
                _buildSectionTitle('الترجمة'),
                _buildTranslationSettings(context, provider),
                
                const SizedBox(height: 24),
                _buildPreviewSection(context, provider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2C3E50),
        ),
      ),
    );
  }

  Widget _buildFontFamilySelector(BuildContext context, QuranSettingsProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('نوع الخط', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: provider.settings.fontFamily,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: QuranSettings.availableFonts.map((font) {
                return DropdownMenuItem(
                  value: font.family,
                  child: Text(
                    font.name,
                    style: TextStyle(fontFamily: font.family),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  provider.updateFontFamily(value);
                }
              },
            ),
            const SizedBox(height: 8),
            Text(
              provider.getCurrentFont()?.description ?? '',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFontSizeSelector(BuildContext context, QuranSettingsProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('حجم الخط', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Text(
                  '${provider.settings.fontSize.toInt()}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: provider.canDecreaseFontSize()
                      ? () => provider.updateFontSize(provider.getPreviousFontSize())
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                  color: provider.canDecreaseFontSize() ? Colors.blue : Colors.grey,
                ),
                Expanded(
                  child: Slider(
                    value: provider.settings.fontSize,
                    min: QuranSettings.availableFontSizes.first,
                    max: QuranSettings.availableFontSizes.last,
                    divisions: QuranSettings.availableFontSizes.length - 1,
                    onChanged: (value) {
                      provider.updateFontSize(value);
                    },
                  ),
                ),
                IconButton(
                  onPressed: provider.canIncreaseFontSize()
                      ? () => provider.updateFontSize(provider.getNextFontSize())
                      : null,
                  icon: const Icon(Icons.add_circle_outline),
                  color: provider.canIncreaseFontSize() ? Colors.blue : Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'صغير',
                  style: TextStyle(
                    fontSize: QuranSettings.availableFontSizes.first,
                    fontFamily: provider.settings.fontFamily,
                  ),
                ),
                Text(
                  'كبير',
                  style: TextStyle(
                    fontSize: QuranSettings.availableFontSizes.last,
                    fontFamily: provider.settings.fontFamily,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineSpacingSelector(BuildContext context, QuranSettingsProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('المسافة بين الأسطر', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Text(
                  '${provider.settings.lineSpacing.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Slider(
              value: provider.settings.lineSpacing,
              min: QuranSettings.availableLineSpacings.first,
              max: QuranSettings.availableLineSpacings.last,
              divisions: QuranSettings.availableLineSpacings.length - 1,
              onChanged: (value) {
                provider.updateLineSpacing(value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundColorSelector(BuildContext context, QuranSettingsProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('لون الخلفية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: QuranSettings.availableBackgroundColors.map((color) {
                final isSelected = provider.settings.backgroundColor == color;
                return GestureDetector(
                  onTap: () => provider.updateBackgroundColor(color),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey,
                        width: isSelected ? 3 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 20)
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextColorSelector(BuildContext context, QuranSettingsProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('لون النص', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: QuranSettings.availableTextColors.map((color) {
                final isSelected = provider.settings.textColor == color;
                return GestureDetector(
                  onTap: () => provider.updateTextColor(color),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey,
                        width: isSelected ? 3 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 20)
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTranslationSettings(BuildContext context, QuranSettingsProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('إظهار الترجمة'),
              value: provider.settings.showTranslation,
              onChanged: (value) {
                provider.toggleTranslation();
              },
            ),
            if (provider.settings.showTranslation) ...[
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: provider.settings.translationLanguage,
                decoration: const InputDecoration(
                  labelText: 'لغة الترجمة',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'ar', child: Text('العربية')),
                  DropdownMenuItem(value: 'en', child: Text('الإنجليزية')),
                  DropdownMenuItem(value: 'ur', child: Text('الأردية')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    provider.updateTranslationLanguage(value);
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewSection(BuildContext context, QuranSettingsProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('معاينة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: provider.settings.backgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                    style: TextStyle(
                      fontFamily: provider.settings.fontFamily,
                      fontSize: provider.settings.fontSize,
                      color: provider.settings.textColor,
                      height: provider.settings.lineSpacing,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
                    style: TextStyle(
                      fontFamily: provider.settings.fontFamily,
                      fontSize: provider.settings.fontSize,
                      color: provider.settings.textColor,
                      height: provider.settings.lineSpacing,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}