import 'package:flutter_test/flutter_test.dart';
import 'package:govconnect/src/domain/models/user_model.dart';
import 'package:govconnect/src/domain/models/scheme_model.dart';
import 'package:govconnect/src/core/services/eligibility_service.dart';
import 'package:govconnect/src/core/services/recommendation_service.dart';

void main() {
  group('EligibilityService Rules Tests', () {
    final sampleScheme = SchemeModel(
      schemeId: 'scheme-1',
      titleEn: 'PM-KISAN',
      titleHi: 'पीएम-किसान',
      descriptionEn: 'Support for farmers',
      descriptionHi: 'किसानों के लिए सहायता',
      level: 'central',
      minAge: 18,
      maxAge: 70,
      maxIncome: 200000,
      genders: ['male', 'female'],
      states: ['ALL'],
      categories: ['GENERAL', 'OBC'],
      requiresFarmer: true,
      requiresDisability: false,
      requiresMinority: false,
      requiresBusinessOwner: false,
      documents: ['Aadhaar', 'Land Record'],
      isActive: true,
    );

    test('User matches all rules -> Eligible', () {
      final eligibleProfile = UserProfile(
        age: 35,
        gender: 'female',
        income: 120000,
        state: 'GJ',
        occupation: 'farmer',
        category: 'OBC',
        education: 'matric',
        isDisabled: false,
        isMinority: false,
        isFarmer: true,
        isBusinessOwner: false,
      );

      final isEligible = EligibilityService.isEligible(eligibleProfile, sampleScheme);
      expect(isEligible, isTrue);
    });

    test('User income exceeds limit -> Ineligible', () {
      final richProfile = UserProfile(
        age: 35,
        gender: 'female',
        income: 250000, // Exceeds 200,000
        state: 'GJ',
        occupation: 'farmer',
        category: 'OBC',
        education: 'matric',
        isDisabled: false,
        isMinority: false,
        isFarmer: true,
        isBusinessOwner: false,
      );

      final isEligible = EligibilityService.isEligible(richProfile, sampleScheme);
      expect(isEligible, isFalse);
    });

    test('User age out of bounds -> Ineligible', () {
      final youngProfile = UserProfile(
        age: 15, // Below 18
        gender: 'female',
        income: 120000,
        state: 'GJ',
        occupation: 'farmer',
        category: 'OBC',
        education: 'matric',
        isDisabled: false,
        isMinority: false,
        isFarmer: true,
        isBusinessOwner: false,
      );

      final isEligible = EligibilityService.isEligible(youngProfile, sampleScheme);
      expect(isEligible, isFalse);
    });

    test('User is not a farmer -> Ineligible', () {
      final studentProfile = UserProfile(
        age: 22,
        gender: 'male',
        income: 50000,
        state: 'GJ',
        occupation: 'student',
        category: 'GENERAL',
        education: 'matric',
        isDisabled: false,
        isMinority: false,
        isFarmer: false, // Requires farmer
        isBusinessOwner: false,
      );

      final isEligible = EligibilityService.isEligible(studentProfile, sampleScheme);
      expect(isEligible, isFalse);
    });
  });

  group('RecommendationService Ranking Tests', () {
    final profile = UserProfile(
      age: 25,
      gender: 'male',
      income: 50000,
      state: 'GJ',
      occupation: 'student',
      category: 'GENERAL',
      education: 'graduate',
      isDisabled: false,
      isMinority: false,
      isFarmer: false,
      isBusinessOwner: false,
    );

    final centralScheme = SchemeModel(
      schemeId: 'c1',
      titleEn: 'Central Scholarship',
      titleHi: 'केंद्रीय छात्रवृत्ति',
      descriptionEn: 'Central scholarship description',
      descriptionHi: 'विवरण',
      level: 'central',
      minAge: 15,
      maxAge: 30,
      maxIncome: 100000,
      genders: [],
      states: ['ALL'],
      categories: [],
      requiresFarmer: false,
      requiresDisability: false,
      requiresMinority: false,
      requiresBusinessOwner: false,
      documents: [],
      isActive: true,
    );

    final stateSchemeNearDeadline = SchemeModel(
      schemeId: 's1',
      titleEn: 'State Scholarship (Near)',
      titleHi: 'राज्य छात्रवृत्ति (निकट)',
      descriptionEn: 'State description',
      descriptionHi: 'विवरण',
      level: 'state',
      minAge: 15,
      maxAge: 30,
      maxIncome: 100000,
      genders: [],
      states: ['GJ'],
      categories: [],
      requiresFarmer: false,
      requiresDisability: false,
      requiresMinority: false,
      requiresBusinessOwner: false,
      documents: [],
      deadline: DateTime.now().add(const Duration(days: 2)),
      isActive: true,
    );

    final stateSchemeFarDeadline = SchemeModel(
      schemeId: 's2',
      titleEn: 'State Scholarship (Far)',
      titleHi: 'राज्य छात्रवृत्ति (दूर)',
      descriptionEn: 'State description',
      descriptionHi: 'विवरण',
      level: 'state',
      minAge: 15,
      maxAge: 30,
      maxIncome: 100000,
      genders: [],
      states: ['GJ'],
      categories: [],
      requiresFarmer: false,
      requiresDisability: false,
      requiresMinority: false,
      requiresBusinessOwner: false,
      documents: [],
      deadline: DateTime.now().add(const Duration(days: 10)),
      isActive: true,
    );

    test('Rank state-level before central and sort by deadline proximity', () {
      final inputList = [centralScheme, stateSchemeFarDeadline, stateSchemeNearDeadline];
      
      final recommendations = RecommendationService.recommend(profile, inputList);
      
      // Expected order:
      // 1. stateSchemeNearDeadline (state level, nearest deadline: 2 days)
      // 2. stateSchemeFarDeadline (state level, further deadline: 10 days)
      // 3. centralScheme (central level, no deadline)
      expect(recommendations.length, 3);
      expect(recommendations[0].schemeId, 's1');
      expect(recommendations[1].schemeId, 's2');
      expect(recommendations[2].schemeId, 'c1');
    });
  });
}
