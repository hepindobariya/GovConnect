import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/recommendation_service.dart';
import '../../../data/repositories/schemes_repository.dart';
import '../../../domain/models/scheme_model.dart';
import '../../quiz/providers/user_profile_provider.dart';

final recommendedSchemesProvider = Provider<AsyncValue<List<SchemeModel>>>((ref) {
  final userProfile = ref.watch(userProfileProvider);
  final schemesAsync = ref.watch(schemesFutureProvider);

  return schemesAsync.when(
    data: (schemes) {
      if (userProfile == null) {
        // Return all schemes if questionnaire is not completed yet
        return AsyncValue.data(schemes);
      }
      final recommended = RecommendationService.recommend(userProfile, schemes);
      return AsyncValue.data(recommended);
    },
    error: (err, stack) => AsyncValue.error(err, stack),
    loading: () => const AsyncValue.loading(),
  );
});
