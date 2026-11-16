class Validators {
  Validators._();

  static String? username(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Username is required';
    if (text.contains(' ')) return 'Username cannot contain spaces';
    return null;
  }

  /// Only checks presence; the server decides what a valid password is.
  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    return null;
  }
}
