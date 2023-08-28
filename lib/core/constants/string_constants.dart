import 'package:flutter/material.dart';

@immutable
class StringConstants {
  const StringConstants._();

  static const String baseUrl = 'ss';
  static const String login = 'SignIn';
  static const String logout = 'Logout';
  static const String register = 'Register';
  static const String noInternetConnection = 'No internet connection!!!';
  static const String success = 'Success';
  static const String error = 'Error';
  static const String info = 'Information';
  static const String warning = 'Warning';
  static const String facebook = 'Facebook';
  static const String google = 'Google';
  static const String apple = 'Apple';
  static const String loginSuccess = 'Login successs';
  static const String logoutSuccess = 'Logout successs';
  static const String enterEmail = 'E-mail address';
  static const String password = 'Password';
  static const String search = 'Search';
  static const String wrongEmail = 'Wrong e-mail address';
  static const String passwordIsEmpty = 'Type a password';
  static const String somethingError = 'Something error';
  static const String noConnectionServer = 'Server connection failed';
  static const String dontYouHaveAnAcc = "Don't you have an account?";
  static const String donYouHaveAnAcc = 'Do you have an account?';
  static const String verifyEmailAddress =
      'Please verify your mail address\nWe sent a link!';
  static const String newEvent = 'New event';
  static const String title = 'Title';
  static const String locationOrMeetingUrl = 'Location or meeting URL';
  static const String allDayEvent = 'All day event';
  static const String repetitiveEvent = 'Repetitive event';
  static const String start = 'Start';
  static const String end = 'End';
  static const String tags = 'Tags';
  static const String notes = 'Notes';
  static const String create = 'Create';
  static const String noteCreated = 'Note creata success';
  static const String titleCannotEmpty = 'Title cannot empty';
  static const String locationCannotEmpty = 'Location cannot empty';
  static const String noteCannotEmpty = 'Note cannot empty';
}

@immutable
class FirebaseStrings {
  const FirebaseStrings._();
  static const String googleClientId =
      '535678825171-1nqisrnl1v5pu156e9k07nh1soae3g0f.apps.googleusercontent.com';
}
