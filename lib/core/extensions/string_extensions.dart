extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String capitalizeWords() {
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r'^\+?[\d\s-]{7,15}$');
    return phoneRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    return length >= 6;
  }

  String toPhoneFormat() {
    final cleaned = replaceAll(RegExp(r'\s+'), '');
    if (cleaned.length <= 3) return cleaned;
    if (cleaned.length <= 7) return '${cleaned.substring(0, 3)} ${cleaned.substring(3)}';
    return '${cleaned.substring(0, 3)} ${cleaned.substring(3, 7)} ${cleaned.substring(7)}';
  }

  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }
}
