import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/theme.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguageCode = 'en';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pre-select current language from context
    _selectedLanguageCode = context.locale.languageCode;
  }

  void _selectLanguage(String langCode) {
    setState(() {
      _selectedLanguageCode = langCode;
    });
  }

  Future<void> _saveAndContinue() async {
    await context.setLocale(Locale(_selectedLanguageCode));
    if (mounted) {
      context.go('/quiz');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.neutralLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.ashokaBlue.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.translate_rounded,
                    size: 48,
                    color: AppTheme.ashokaBlue,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'select_language'.tr(),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.neutralDark,
                ),
              ),
              const SizedBox(height: 48),
              // English Card
              _buildLanguageCard(
                langName: 'English',
                langSub: 'Find schemes in English',
                langCode: 'en',
              ),
              const SizedBox(height: 16),
              // Hindi Card
              _buildLanguageCard(
                langName: 'हिंदी',
                langSub: 'हिंदी में योजनाएं खोजें',
                langCode: 'hi',
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _saveAndContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.deepSaffron, // Secondary accent CTA
                  elevation: 2,
                ),
                child: Text('continue_text'.tr()),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard({
    required String langName,
    required String langSub,
    required String langCode,
  }) {
    final isSelected = _selectedLanguageCode == langCode;
    return GestureDetector(
      onTap: () => _selectLanguage(langCode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.ashokaBlue : Colors.transparent,
            width: 2.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppTheme.ashokaBlue.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    langName,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.neutralDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    langSub,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppTheme.neutralMid,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppTheme.ashokaBlue,
                size: 28,
              )
            else
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.neutralMid.withValues(alpha: 0.5),
                    width: 2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
