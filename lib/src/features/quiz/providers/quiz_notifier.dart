import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/user_model.dart';

class QuizState {
  final int currentStep; // 0 to 7 (8 steps total)
  final int age;
  final String gender;
  final int income;
  final String state;
  final String occupation;
  final String category;
  final String education;
  final bool isDisabled;
  final bool isMinority;
  final bool isFarmer;
  final bool isBusinessOwner;

  QuizState({
    this.currentStep = 0,
    this.age = 18,
    this.gender = 'other',
    this.income = 150000,
    this.state = 'GJ',
    this.occupation = 'student',
    this.category = 'GENERAL',
    this.education = 'matric',
    this.isDisabled = false,
    this.isMinority = false,
    this.isFarmer = false,
    this.isBusinessOwner = false,
  });

  QuizState copyWith({
    int? currentStep,
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
    return QuizState(
      currentStep: currentStep ?? this.currentStep,
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

  UserProfile toProfile() {
    return UserProfile(
      age: age,
      gender: gender,
      income: income,
      state: state,
      occupation: occupation,
      category: category,
      education: education,
      isDisabled: isDisabled,
      isMinority: isMinority,
      isFarmer: isFarmer,
      isBusinessOwner: isBusinessOwner,
    );
  }
}

class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier() : super(QuizState());

  void setAge(int age) => state = state.copyWith(age: age);
  void setGender(String gender) => state = state.copyWith(gender: gender);
  void setIncome(int income) => state = state.copyWith(income: income);
  void setStateCode(String stateCode) => state = state.copyWith(state: stateCode);
  void setOccupation(String occupation) => state = state.copyWith(occupation: occupation);
  void setCategory(String category) => state = state.copyWith(category: category);
  void setEducation(String education) => state = state.copyWith(education: education);
  
  void setFlags({
    bool? isDisabled,
    bool? isMinority,
    bool? isFarmer,
    bool? isBusinessOwner,
  }) {
    state = state.copyWith(
      isDisabled: isDisabled ?? state.isDisabled,
      isMinority: isMinority ?? state.isMinority,
      isFarmer: isFarmer ?? state.isFarmer,
      isBusinessOwner: isBusinessOwner ?? state.isBusinessOwner,
    );
  }

  void nextStep() {
    if (state.currentStep < 7) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void reset() {
    state = QuizState();
  }
}

final quizNotifierProvider = StateNotifierProvider<QuizNotifier, QuizState>((ref) {
  return QuizNotifier();
});
