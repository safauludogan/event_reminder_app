class FirebaseCustomExceptions implements Exception {
  FirebaseCustomExceptions(this.description);
  final String description;

  @override
  String toString() {
    return '$this $description';
  }
}
