class CategoryModel {
  final String categoryId;
  final String nameEn;
  final String nameHi;
  final String? iconUrl;
  final int sortOrder;

  CategoryModel({
    required this.categoryId,
    required this.nameEn,
    required this.nameHi,
    this.iconUrl,
    required this.sortOrder,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['category_id'] as String,
      nameEn: json['name_en'] as String,
      nameHi: json['name_hi'] as String,
      iconUrl: json['icon_url'] as String?,
      sortOrder: json['sort_order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'name_en': nameEn,
      'name_hi': nameHi,
      'icon_url': iconUrl,
      'sort_order': sortOrder,
    };
  }
}
