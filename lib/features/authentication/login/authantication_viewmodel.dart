import 'dart:async';

import 'package:event_reminder_app/core/authentication_manager/authentication_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthanticationViewModel<T extends StatefulWidget>
    extends State<T> {
  late StreamSubscription<User?> authStateListener;

  @override
  void initState() {
    super.initState();
    authListener();
  }

  @override
  void dispose() {
    super.dispose();
    killStream();
  }

  Future<void> authListener() async {
    authStateListener =
        FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        await AuthenticationManager().login(user, isOAuth: user.email == null);
        await killStream();
      }
    });
  }

  Future<void> killStream() async {
    await authStateListener.cancel();
  }
}
