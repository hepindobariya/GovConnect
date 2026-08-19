class StateModel {
  final String stateCode;
  final String nameEn;
  final String nameHi;
  final bool isActive;

  StateModel({
    required this.stateCode,
    required this.nameEn,
    required this.nameHi,
    required this.isActive,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      stateCode: json['state_code'] as String,
      nameEn: json['name_en'] as String,
      nameHi: json['name_hi'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'state_code': stateCode,
      'name_en': nameEn,
      'name_hi': nameHi,
      'is_active': isActive,
    };
  }
}
