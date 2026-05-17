import '../extensions/string_extensions.dart';

class Validators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!value.isValidEmail) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    if (!value.isValidPhone) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? Function(String?)? minLength(int min) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'This field is required';
      }
      if (value.length < min) {
        return 'Minimum $min characters required';
      }
      return null;
    };
  }

  static String? Function(String?)? maxLength(int max) {
    return (String? value) {
      if (value != null && value.length > max) {
        return 'Maximum $max characters allowed';
      }
      return null;
    };
  }
}
