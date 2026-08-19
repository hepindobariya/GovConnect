class UserProfile {
  final int age;
  final String gender; // 'male' | 'female' | 'other'
  final int income; // Annual income in ₹
  final String state; // State code (e.g. 'GJ')
  final String occupation; // e.g. 'student', 'farmer', 'unemployed', 'self-employed', 'salaried'
  final String category; // 'SC' | 'ST' | 'OBC' | 'GENERAL'
  final String education; // e.g. 'none', 'under_matric', 'matric', 'higher_secondary', 'graduate', 'post_graduate'
  final bool isDisabled;
  final bool isMinority;
  final bool isFarmer;
  final bool isBusinessOwner;

  UserProfile({
    required this.age,
    required this.gender,
    required this.income,
    required this.state,
    required this.occupation,
    required this.category,
    required this.education,
    required this.isDisabled,
    required this.isMinority,
    required this.isFarmer,
    required this.isBusinessOwner,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      age: json['age'] as int? ?? 0,
      gender: json['gender'] as String? ?? 'other',
      income: json['income'] as int? ?? 0,
      state: json['state'] as String? ?? 'GJ',
      occupation: json['occupation'] as String? ?? 'other',
      category: json['category'] as String? ?? 'GENERAL',
      education: json['education'] as String? ?? 'none',
      isDisabled: json['isDisabled'] as bool? ?? false,
      isMinority: json['isMinority'] as bool? ?? false,
      isFarmer: json['isFarmer'] as bool? ?? false,
      isBusinessOwner: json['isBusinessOwner'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'gender': gender,
      'income': income,
      'state': state,
      'occupation': occupation,
      'category': category,
      'education': education,
      'isDisabled': isDisabled,
      'isMinority': isMinority,
      'isFarmer': isFarmer,
      'isBusinessOwner': isBusinessOwner,
    };
  }

  UserProfile copyWith({
    int? age,
    String? gender,
    int? income,
    String? state,
    String? occupation,
    String? category,
    String? education,
    bool? isDisabled,
    bool? isMinority,
    bool? isFarmer,
    bool? isBusinessOwner,
  }) {
    return UserProfile(
      age: age ?? this.age,
      gender: gender ?? this.gender,
      income: income ?? this.income,
      state: state ?? this.state,
      occupation: occupation ?? this.occupation,
      category: category ?? this.category,
      education: education ?? this.education,
      isDisabled: isDisabled ?? this.isDisabled,
      isMinority: isMinority ?? this.isMinority,
      isFarmer: isFarmer ?? this.isFarmer,
      isBusinessOwner: isBusinessOwner ?? this.isBusinessOwner,
    );
  }
}
