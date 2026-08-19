import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/state_model.dart';
import '../../domain/models/scheme_model.dart';

class SchemesRepository {
  final SupabaseClient _client;

  SchemesRepository(this._client);

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await _client
          .from('categories')
          .select()
          .order('sort_order', ascending: true);
      
      return (response as List)
          .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  Future<List<StateModel>> fetchStates() async {
    try {
      final response = await _client
          .from('states')
          .select()
          .eq('is_active', true);
      
      return (response as List)
          .map((json) => StateModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch states: $e');
    }
  }

  Future<List<SchemeModel>> fetchSchemes() async {
    try {
      final response = await _client
          .from('schemes')
          .select()
          .eq('is_active', true);
      
      return (response as List)
          .map((json) => SchemeModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch schemes: $e');
    }
  }
}

// Riverpod Providers
final schemesRepositoryProvider = Provider<SchemesRepository>((ref) {
  return SchemesRepository(Supabase.instance.client);
});

final categoriesFutureProvider = FutureProvider<List<CategoryModel>>((ref) async {
  final repo = ref.watch(schemesRepositoryProvider);
  return repo.fetchCategories();
});

final statesFutureProvider = FutureProvider<List<StateModel>>((ref) async {
  final repo = ref.watch(schemesRepositoryProvider);
  return repo.fetchStates();
});

final schemesFutureProvider = FutureProvider<List<SchemeModel>>((ref) async {
  final repo = ref.watch(schemesRepositoryProvider);
  return repo.fetchSchemes();
});
