import 'dart:async';
import 'package:event_reminder_app/core/constants/string_constants.dart';
import 'package:event_reminder_app/core/init/cache/locale_manager.dart';
import 'package:event_reminder_app/core/init/toast/toast_service.dart';
import 'package:event_reminder_app/product/exceptions/firebase_exception.dart';
import 'package:event_reminder_app/product/manager/database/operations/login_hive_operation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationManager {
  Future<void> logOut() async {
    await LocaleManager.instance.clearAll();
    await FirebaseAuth.instance.signOut();
    ToastService.info.show(text: StringConstants.logoutSuccess);
  }

  Future<void> login(
    User? user, {
    bool isOAuth = false,
  }) async {
    if (user == null) return;
    if (isOAuth) {
      await updateUserEmail(user)
          .then((value) async => sendEmailVerification(user));
    } else {
      await sendEmailVerification(user);
    }
  }

  Future<void> sendEmailVerification(User user) async {
    if (user.emailVerified) return;
    try {
      await user.sendEmailVerification();
      ToastService.info.show(text: StringConstants.verifyEmailAddress);
    } on FirebaseAuthException catch (e) {
      throw FirebaseCustomExceptions(e.toString());
    }
  }

  Future<void> updateUserEmail(User user) async {
    if (user.providerData.first.email == null) return;
    await user.updateEmail(
      user.providerData.first.email!,
    );
  }

  Future<void> addDataToHiveDataBase() async {
    final loginHiveOperation = LoginHiveOperation();
    await loginHiveOperation.open();
    //await loginHiveOperation.addOrUpdateItem(loginResponseModel);
  }
}
