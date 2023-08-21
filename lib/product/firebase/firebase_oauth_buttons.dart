// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:event_reminder_app/core/constants/string_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';

typedef OAuthButtonListener = bool? Function(
  AuthState oldState,
  AuthState newState,
  OAuthController controller,
);
typedef SignedInCallback = void Function(UserCredential credential);

abstract class IFirebaseAuthButton {
  IFirebaseAuthButton(this.onSignedIn);
  SignedInCallback? onSignedIn;
  Widget child();
}

class GoogleAuthButton implements IFirebaseAuthButton {
  GoogleAuthButton({
    this.onSignedIn,
  });

  @override
  SignedInCallback? onSignedIn;

  @override
  Widget child() => GoogleSignInIconButton(
        onError: (exception) {
          throw Exception('$this $exception');
        },
        clientId: FirebaseStrings.googleClientId,
        loadingIndicator: const CircularProgressIndicator(),
        onSignedIn: onSignedIn,
      );
}

class AppleAuthButton implements IFirebaseAuthButton {
  AppleAuthButton({
    this.onSignedIn,
  });

  @override
  SignedInCallback? onSignedIn;

  @override
  Widget child() => AppleSignInIconButton(
        onError: (exception) {
          throw Exception('$this $exception');
        },
        loadingIndicator: const CircularProgressIndicator(),
        onSignedIn: onSignedIn,
      );
}

class FirebaseSocialIconButton extends StatelessWidget {
  const FirebaseSocialIconButton({
    required this.firebaseAuthButton,
    required this.listener,
    super.key,
  });
  final IFirebaseAuthButton firebaseAuthButton;
  final OAuthButtonListener listener;
  @override
  Widget build(BuildContext context) {
    return AuthStateListener<OAuthController>(
      listener: listener,
      child: firebaseAuthButton.child(),
    );
  }
}
