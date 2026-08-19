import '../../domain/models/user_model.dart';
import '../../domain/models/scheme_model.dart';
import 'eligibility_service.dart';

class RecommendationService {
  RecommendationService._();

  static List<SchemeModel> recommend(UserProfile profile, List<SchemeModel> schemes) {
    // 1. Filter only eligible schemes
    final eligibleSchemes = schemes.where((scheme) => EligibilityService.isEligible(profile, scheme)).toList();

    // 2. Rank based on rules: State level first, then nearest deadline
    eligibleSchemes.sort((a, b) {
      // 1. State-specific before Central
      if (a.level == 'state' && b.level == 'central') {
        return -1;
      }
      if (a.level == 'central' && b.level == 'state') {
        return 1;
      }

      // 2. Nearest deadline first
      if (a.deadline != null && b.deadline == null) {
        return -1;
      }
      if (a.deadline == null && b.deadline != null) {
        return 1;
      }
      if (a.deadline != null && b.deadline != null) {
        return a.deadline!.compareTo(b.deadline!);
      }

      // Default equal
      return 0;
    });

    return eligibleSchemes;
  }
}
