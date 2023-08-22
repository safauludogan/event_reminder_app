import 'dart:async';
import 'package:event_reminder_app/core/constants/string_constants.dart';
import 'package:event_reminder_app/core/init/toast/toast_service.dart';
import 'package:event_reminder_app/features/splash/splash_view.dart';
import 'package:event_reminder_app/main.dart';
import 'package:event_reminder_app/product/components/loading/loading_dialog.dart';
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
        LoadingDialog(context).show();
        unawaited(getIt<AppRouter>().replace(const HomeRoute()));
        ToastService.success.show(text: StringConstants.loginSuccess);
        LoadingDialog(context).dissmis();
      } else {
        unawaited(getIt<AppRouter>().replace(const SignInRoute()));
      }
    });
  }
}
