class SchemeModel {
  final String schemeId;
  final String titleEn;
  final String titleHi;
  final String descriptionEn;
  final String descriptionHi;
  final String? category;
  final String level; // 'central' | 'state'
  final String? state;
  final String? benefits;
  final List<String> documents;

  // Eligibility Rules
  final int minAge;
  final int maxAge;
  final int maxIncome;
  final List<String> genders;
  final List<String> states;
  final List<String> categories;
  final bool requiresFarmer;
  final bool requiresDisability;
  final bool requiresMinority;
  final bool requiresBusinessOwner;

  final String? officialUrl;
  final DateTime? deadline;
  final String? iconUrl;
  final bool isActive;

  SchemeModel({
    required this.schemeId,
    required this.titleEn,
    required this.titleHi,
    required this.descriptionEn,
    required this.descriptionHi,
    this.category,
    required this.level,
    this.state,
    this.benefits,
    required this.documents,
    required this.minAge,
    required this.maxAge,
    required this.maxIncome,
    required this.genders,
    required this.states,
    required this.categories,
    required this.requiresFarmer,
    required this.requiresDisability,
    required this.requiresMinority,
    required this.requiresBusinessOwner,
    this.officialUrl,
    this.deadline,
    this.iconUrl,
    required this.isActive,
  });

  factory SchemeModel.fromJson(Map<String, dynamic> json) {
    return SchemeModel(
      schemeId: json['scheme_id'] as String,
      titleEn: json['title_en'] as String? ?? '',
      titleHi: json['title_hi'] as String? ?? '',
      descriptionEn: json['description_en'] as String? ?? '',
      descriptionHi: json['description_hi'] as String? ?? '',
      category: json['category'] as String?,
      level: json['level'] as String? ?? 'central',
      state: json['state'] as String?,
      benefits: json['benefits'] as String?,
      documents: (json['documents'] as List?)?.map((e) => e as String).toList() ?? const [],
      minAge: json['min_age'] as int? ?? 0,
      maxAge: json['max_age'] as int? ?? 150,
      maxIncome: json['max_income'] as int? ?? 9999999,
      genders: (json['genders'] as List?)?.map((e) => e as String).toList() ?? const [],
      states: (json['states'] as List?)?.map((e) => e as String).toList() ?? const [],
      categories: (json['categories'] as List?)?.map((e) => e as String).toList() ?? const [],
      requiresFarmer: json['requires_farmer'] as bool? ?? false,
      requiresDisability: json['requires_disability'] as bool? ?? false,
      requiresMinority: json['requires_minority'] as bool? ?? false,
      requiresBusinessOwner: json['requires_business_owner'] as bool? ?? false,
      officialUrl: json['official_url'] as String?,
      deadline: json['deadline'] != null ? DateTime.tryParse(json['deadline'] as String) : null,
      iconUrl: json['icon_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scheme_id': schemeId,
      'title_en': titleEn,
      'title_hi': titleHi,
      'description_en': descriptionEn,
      'description_hi': descriptionHi,
      'category': category,
      'level': level,
      'state': state,
      'benefits': benefits,
      'documents': documents,
      'min_age': minAge,
      'max_age': maxAge,
      'max_income': maxIncome,
      'genders': genders,
      'states': states,
      'categories': categories,
      'requires_farmer': requiresFarmer,
      'requires_disability': requiresDisability,
      'requires_minority': requiresMinority,
      'requires_business_owner': requiresBusinessOwner,
      'official_url': officialUrl,
      'deadline': deadline?.toIso8601String(),
      'icon_url': iconUrl,
      'is_active': isActive,
    };
  }
}
