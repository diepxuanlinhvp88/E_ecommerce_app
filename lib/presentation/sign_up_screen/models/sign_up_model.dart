import '../../../core/app_export.dart';
import 'package:untitled/data/models/selection_popup_model.dart';

class SignUpModel {
  List<SelectionPopupModel> nationalityList = [
    SelectionPopupModel(
      id: 1,
      title: "Vietnam",
      isSelected: true,
    ),
    SelectionPopupModel(
      id: 1,
      title: "England",
    ),
    SelectionPopupModel(
      id: 1,
      title: "America",
    )
  ];

  List<SelectionPopupModel> genderList = [
    SelectionPopupModel(
      id: 1,
      title: "Male",
      isSelected: true,
    ),
    SelectionPopupModel(
      id: 1,
      title: "Female",
    ),
    SelectionPopupModel(
      id: 1,
      title: "Others",
    )
  ];

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter a password';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  bool validateTerms(bool acceptedTerms) {
    return acceptedTerms;
  }
}