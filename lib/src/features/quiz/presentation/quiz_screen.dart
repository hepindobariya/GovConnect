import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/theme.dart';
import '../providers/quiz_notifier.dart';
import '../providers/user_profile_provider.dart';

class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizNotifierProvider);
    final notifier = ref.read(quizNotifierProvider.notifier);

    final totalSteps = 8;
    final progress = (quizState.currentStep + 1) / totalSteps;

    return Scaffold(
      backgroundColor: AppTheme.neutralLight,
      appBar: AppBar(
        title: Text('Eligibility Questionnaire (${quizState.currentStep + 1}/$totalSteps)'),
        leading: quizState.currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: notifier.previousStep,
              )
            : IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => context.go('/home'),
              ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppTheme.neutralMid.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.deepSaffron),
              minHeight: 6,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildStepContent(context, quizState, notifier, ref),
                ),
              ),
            ),
            // Bottom Action Bar
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  if (quizState.currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: notifier.previousStep,
                        child: Text('back'.tr()),
                      ),
                    ),
                  if (quizState.currentStep > 0) const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () => _handleNext(context, quizState, notifier, ref),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.deepSaffron,
                      ),
                      child: Text(
                        quizState.currentStep == totalSteps - 1
                            ? 'Finish & Match'
                            : 'next'.tr(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNext(
    BuildContext context,
    QuizState quizState,
    QuizNotifier notifier,
    WidgetRef ref,
  ) async {
    if (quizState.currentStep < 7) {
      notifier.nextStep();
    } else {
      // Save profile locally
      final profile = quizState.toProfile();
      await ref.read(userProfileProvider.notifier).saveProfile(profile);
      if (context.mounted) {
        context.go('/home');
      }
    }
  }

  Widget _buildStepContent(
    BuildContext context,
    QuizState state,
    QuizNotifier notifier,
    WidgetRef ref,
  ) {
    switch (state.currentStep) {
      case 0:
        return _buildAgeStep(context, state, notifier);
      case 1:
        return _buildGenderStep(context, state, notifier);
      case 2:
        return _buildIncomeStep(context, state, notifier);
      case 3:
        return _buildStateStep(context, state, notifier);
      case 4:
        return _buildOccupationStep(context, state, notifier);
      case 5:
        return _buildCategoryStep(context, state, notifier);
      case 6:
        return _buildEducationStep(context, state, notifier);
      case 7:
        return _buildFlagsStep(context, state, notifier);
      default:
        return const SizedBox.shrink();
    }
  }

  // Step 0: Age
  Widget _buildAgeStep(BuildContext context, QuizState state, QuizNotifier notifier) {
    return Column(
      key: const ValueKey(0),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestionHeader('What is your age?', 'Age is used to filter youth scholarships and senior citizen pensions.'),
        const SizedBox(height: 32),
        Center(
          child: Text(
            '${state.age} Years',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppTheme.ashokaBlue,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Slider(
          value: state.age.toDouble(),
          min: 1,
          max: 100,
          divisions: 99,
          activeColor: AppTheme.ashokaBlue,
          inactiveColor: AppTheme.neutralMid.withOpacity(0.2),
          onChanged: (val) => notifier.setAge(val.toInt()),
        ),
      ],
    );
  }

  // Step 1: Gender
  Widget _buildGenderStep(BuildContext context, QuizState state, QuizNotifier notifier) {
    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestionHeader('What is your gender?', 'Certain welfare schemes are exclusively designed to support women or other genders.'),
        const SizedBox(height: 32),
        _buildSelectableCard('Male 👨', 'male', state.gender == 'male', () => notifier.setGender('male')),
        const SizedBox(height: 16),
        _buildSelectableCard('Female 👩', 'female', state.gender == 'female', () => notifier.setGender('female')),
        const SizedBox(height: 16),
        _buildSelectableCard('Other / Third Gender ⚧️', 'other', state.gender == 'other', () => notifier.setGender('other')),
      ],
    );
  }

  // Step 2: Income
  Widget _buildIncomeStep(BuildContext context, QuizState state, QuizNotifier notifier) {
    return Column(
      key: const ValueKey(2),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestionHeader('What is your annual family income?', 'Most welfare subsidies are designed for lower and middle-income families.'),
        const SizedBox(height: 32),
        Center(
          child: Text(
            '₹${NumberFormat('#,##,###').format(state.income)}',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppTheme.ashokaBlue,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Slider(
          value: state.income.toDouble(),
          min: 0,
          max: 1500000,
          divisions: 60,
          activeColor: AppTheme.ashokaBlue,
          inactiveColor: AppTheme.neutralMid.withOpacity(0.2),
          onChanged: (val) => notifier.setIncome(val.toInt()),
        ),
        Center(
          child: Text(
            'Slide to adjust (Max ₹15 Lakhs)',
            style: GoogleFonts.inter(color: AppTheme.neutralMid, fontSize: 12),
          ),
        ),
      ],
    );
  }

  // Step 3: State
  Widget _buildStateStep(BuildContext context, QuizState state, QuizNotifier notifier) {
    return Column(
      key: const ValueKey(3),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestionHeader('Select your residential state', 'Welfare schemes vary by state. This prototype is focused on Gujarat and Central schemes.'),
        const SizedBox(height: 32),
        _buildSelectableCard('Gujarat (Default) 🇮🇳', 'GJ', state.state == 'GJ', () => notifier.setStateCode('GJ')),
        const SizedBox(height: 16),
        _buildSelectableCard('Other State / UT', 'OTHER', state.state == 'OTHER', () => notifier.setStateCode('OTHER')),
      ],
    );
  }

  // Step 4: Occupation
  Widget _buildOccupationStep(BuildContext context, QuizState state, QuizNotifier notifier) {
    return Column(
      key: const ValueKey(4),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestionHeader('What is your primary occupation?', 'Subsidies and grants are tailored for farmers, students, or MSME business owners.'),
        const SizedBox(height: 24),
        _buildSelectableCard('Student 🎓', 'student', state.occupation == 'student', () => notifier.setOccupation('student')),
        const SizedBox(height: 12),
        _buildSelectableCard('Farmer 🌾', 'farmer', state.occupation == 'farmer', () {
          notifier.setOccupation('farmer');
          notifier.setFlags(isFarmer: true);
        }),
        const SizedBox(height: 12),
        _buildSelectableCard('Unemployed / Job Seeker 💼', 'unemployed', state.occupation == 'unemployed', () => notifier.setOccupation('unemployed')),
        const SizedBox(height: 12),
        _buildSelectableCard('Business Owner / Self-Employed 🏭', 'self-employed', state.occupation == 'self-employed', () {
          notifier.setOccupation('self-employed');
          notifier.setFlags(isBusinessOwner: true);
        }),
        const SizedBox(height: 12),
        _buildSelectableCard('Salaried Employee 🏢', 'salaried', state.occupation == 'salaried', () => notifier.setOccupation('salaried')),
      ],
    );
  }

  // Step 5: Social Category
  Widget _buildCategoryStep(BuildContext context, QuizState state, QuizNotifier notifier) {
    return Column(
      key: const ValueKey(5),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestionHeader('Select your social category', 'Many reservations, educational stipends, and farming assist programs are category-specific.'),
        const SizedBox(height: 24),
        _buildSelectableCard('General Category (Open)', 'GENERAL', state.category == 'GENERAL', () => notifier.setCategory('GENERAL')),
        const SizedBox(height: 12),
        _buildSelectableCard('OBC (Other Backward Classes)', 'OBC', state.category == 'OBC', () => notifier.setCategory('OBC')),
        const SizedBox(height: 12),
        _buildSelectableCard('SC (Scheduled Caste)', 'SC', state.category == 'SC', () => notifier.setCategory('SC')),
        const SizedBox(height: 12),
        _buildSelectableCard('ST (Scheduled Tribe)', 'ST', state.category == 'ST', () => notifier.setCategory('ST')),
      ],
    );
  }

  // Step 6: Education
  Widget _buildEducationStep(BuildContext context, QuizState state, QuizNotifier notifier) {
    return Column(
      key: const ValueKey(6),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestionHeader('What is your highest educational level?', 'Scholarships and skill training schemes depend on your educational status.'),
        const SizedBox(height: 24),
        _buildSelectableCard('Below 10th Class', 'under_matric', state.education == 'under_matric', () => notifier.setEducation('under_matric')),
        const SizedBox(height: 12),
        _buildSelectableCard('10th Pass (Matriculation)', 'matric', state.education == 'matric', () => notifier.setEducation('matric')),
        const SizedBox(height: 12),
        _buildSelectableCard('12th Pass / Diploma', 'higher_secondary', state.education == 'higher_secondary', () => notifier.setEducation('higher_secondary')),
        const SizedBox(height: 12),
        _buildSelectableCard('Undergraduate (Bachelor Degree)', 'graduate', state.education == 'graduate', () => notifier.setEducation('graduate')),
        const SizedBox(height: 12),
        _buildSelectableCard('Postgraduate or higher', 'post_graduate', state.education == 'post_graduate', () => notifier.setEducation('post_graduate')),
      ],
    );
  }

  // Step 7: Additional Flags & Consent
  Widget _buildFlagsStep(BuildContext context, QuizState state, QuizNotifier notifier) {
    return Column(
      key: const ValueKey(7),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestionHeader('Additional eligibility parameters', 'Check the options that apply to you. This unlocks highly specific welfare resources.'),
        const SizedBox(height: 24),
        _buildCheckboxTile('Physically Disabled / PwD', state.isDisabled, (val) => notifier.setFlags(isDisabled: val)),
        const SizedBox(height: 12),
        _buildCheckboxTile('Religious or Linguistic Minority', state.isMinority, (val) => notifier.setFlags(isMinority: val)),
        const SizedBox(height: 12),
        _buildCheckboxTile('Registered Farmer', state.isFarmer, (val) => notifier.setFlags(isFarmer: val)),
        const SizedBox(height: 12),
        _buildCheckboxTile('Small Business Owner / MSME', state.isBusinessOwner, (val) => notifier.setFlags(isBusinessOwner: val)),
        const SizedBox(height: 24),
        // Consent Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.amberWarning.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.amberWarning.withOpacity(0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.security_rounded, color: AppTheme.amberWarning),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Consent to share sensitive attributes',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppTheme.neutralDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Attributes like social caste and physical disability are strictly processed locally to filter scheme criteria and are never stored on public servers without encryption.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppTheme.neutralMid,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper Widget: Header
  Widget _buildQuestionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.neutralDark,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppTheme.neutralMid,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // Helper Widget: Option Card
  Widget _buildSelectableCard(
    String label,
    String value,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.ashokaBlue : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: AppTheme.neutralDark,
                ),
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
              color: isSelected ? AppTheme.ashokaBlue : AppTheme.neutralMid,
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget: Checkbox Tile
  Widget _buildCheckboxTile(String title, bool value, ValueChanged<bool?> onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: CheckboxListTile(
        title: Text(
          title,
          style: GoogleFonts.inter(fontSize: 16, color: AppTheme.neutralDark),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.ashokaBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }
}
