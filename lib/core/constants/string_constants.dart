import 'package:flutter/material.dart';

@immutable
class StringConstants {
  const StringConstants._();

  static const String baseUrl = 'ss';
  static const String login = 'Giriş yap';
  static const String noInternetConnection = 'İnternet bağlantısı yok!!!';
  static const String success = 'Başarılı';
  static const String error = 'Hata';
  static const String info = 'Bilgi';
  static const String warning = 'Uyarı';
  static const String facebook = 'Facebook';
  static const String google = 'Google';
  static const String apple = 'Apple';
  static const String loginSuccess = 'Giriş başarılı';
  static const String enterEmail = 'E-posta adresi';
  static const String password = 'Şifre';
  static const String search = 'Arama';
  static const String wrongEmail = 'Hatalı e-posta girişi';
  static const String passwordIsEmpty = 'Şifrenizi giriniz';
  static const String somethingError = 'Bir hata oluştu';
  static const String noConnectionServer = 'Sunucu bağlantısı sağlanamadı';
}

@immutable
class FirebaseStrings {
  const FirebaseStrings._();
  static const String googleClientId =
      '535678825171-1nqisrnl1v5pu156e9k07nh1soae3g0f.apps.googleusercontent.com';
}
