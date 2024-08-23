String generateToken() {
  final random = List.generate(
      24,
      (index) =>
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
              .codeUnitAt(index % 62));
  return String.fromCharCodes(random);
}
