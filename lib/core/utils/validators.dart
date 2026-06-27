class Validators {
  static String? required(String? value, [String field = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  static String? word(String? value) {
    if (value == null || value.trim().isEmpty) return 'Word is required';
    if (value.length > 100) return 'Max 100 characters';
    return null;
  }

  static String? meaning(String? value) {
    if (value == null || value.trim().isEmpty) return 'Meaning is required';
    return null;
  }

  static String? verbForm(String? value, String form) {
    if (value == null || value.trim().isEmpty) return '$form is required';
    if (value.length > 50) return 'Max 50 characters';
    return null;
  }
}
