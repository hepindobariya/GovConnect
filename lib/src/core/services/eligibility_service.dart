import '../../domain/models/user_model.dart';
import '../../domain/models/scheme_model.dart';

class EligibilityService {
  EligibilityService._();

  static bool isEligible(UserProfile profile, SchemeModel scheme) {
    if (profile.age < scheme.minAge || profile.age > scheme.maxAge) return false;
    if (profile.income > scheme.maxIncome) return false;
    if (scheme.genders.isNotEmpty && !scheme.genders.contains(profile.gender)) return false;
    
    // Check state eligibility (scheme states includes 'ALL' or the profile's state)
    if (scheme.states.isNotEmpty && 
        !scheme.states.contains('ALL') && 
        !scheme.states.contains(profile.state)) {
      return false;
    }
    
    if (scheme.categories.isNotEmpty && !scheme.categories.contains(profile.category)) return false;
    if (scheme.requiresFarmer && !profile.isFarmer) return false;
    if (scheme.requiresDisability && !profile.isDisabled) return false;
    if (scheme.requiresMinority && !profile.isMinority) return false;
    if (scheme.requiresBusinessOwner && !profile.isBusinessOwner) return false;

    return true;
  }

  static List<String> eligibilityReasons(UserProfile profile, SchemeModel scheme) {
    final reasons = <String>[];

    if (profile.age >= scheme.minAge && profile.age <= scheme.maxAge) {
      reasons.add('Age is between ${scheme.minAge} and ${scheme.maxAge}');
    }
    if (profile.income <= scheme.maxIncome) {
      reasons.add('Annual income is below ₹${scheme.maxIncome}');
    }
    if (scheme.genders.isEmpty || scheme.genders.contains(profile.gender)) {
      reasons.add('Gender matches criteria');
    }
    if (scheme.states.isEmpty || scheme.states.contains('ALL') || scheme.states.contains(profile.state)) {
      reasons.add('Applicable in your state');
    }
    if (scheme.categories.isEmpty || scheme.categories.contains(profile.category)) {
      reasons.add('Caste/Social Category fits rules');
    }
    if (scheme.requiresFarmer && profile.isFarmer) {
      reasons.add('Registered Farmer benefit');
    }
    if (scheme.requiresDisability && profile.isDisabled) {
      reasons.add('Physically Challenged (PwD) resource');
    }
    if (scheme.requiresMinority && profile.isMinority) {
      reasons.add('Minority community support');
    }
    if (scheme.requiresBusinessOwner && profile.isBusinessOwner) {
      reasons.add('Business Owner / MSME subsidy');
    }

    return reasons;
  }
}
