import 'dart:ffi';

class FormValidators {
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập $fieldName';
    }
    return null;
  }

  static bool isEmailValid(String value) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(value.trim());
  }

  static String? validateEmail(String? value) {
    final requiredError = validateRequired(value, 'email');
    if (requiredError != null) {
      return requiredError;
    }

    if (!isEmailValid(value!.trim())) {
      return 'Email khong hop le';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final requiredError = validateRequired(value, 'mat khau');
    if (requiredError != null) {
      return requiredError;
    } else if (value!.length < 6) {
      return 'Mat khau phai co it nhat 6 ky tu';
    }
    return validateRequired(value, 'mật khẩu');
  }

  static bool isPassword(String value){
    if(value.length < 6){
      return false;
    }
    return true;
  }
}

