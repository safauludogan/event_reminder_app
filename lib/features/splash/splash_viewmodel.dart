import 'dart:async';
import 'package:event_reminder_app/features/splash/splash_view.dart';
import 'package:event_reminder_app/main.dart';
import 'package:event_reminder_app/product/navigator/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class SplashViewModel extends State<SplashView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    FirebaseAuth.instance.authStateChanges().listen((User? event) async {
      if (event != null) {
        unawaited(getIt<AppRouter>().replace(const HomeRoute()));
      } else {
        unawaited(getIt<AppRouter>().replace(const SignInRoute()));
      }
    });
  }
}
