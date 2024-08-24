class TFirebaseAuthException implements Exception {
  final String code;

  TFirebaseAuthException(this.code);
  String get message{
    switch (code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'too-many-requests':
        return 'Too many requests. Try again later.';
      case 'operation-not-allowed':
        return 'Operation not allowed. Please enable it in the Firebase console.';
      case 'invalid-email':
        return 'Invalid email address.';
      default:
        return 'An error occurred while authenticating. Please try again later.';
    }

  }
}

class TFirebaseException implements Exception {
  final String code;

  TFirebaseException(this.code);
  String get message{
     switch (code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'Operation not allowed. Please enable it in the Firebase console.';
      case 'invalid-email':
        return 'Invalid email address.';
      default:
        return 'An error occurred while authenticating. Please try again later.';
    }
  }
}

class TFormatException implements Exception {
  final String message;

  TFormatException(this.message);
}

class TPlatformException implements Exception {
  final String message;

  TPlatformException(this.message);
}