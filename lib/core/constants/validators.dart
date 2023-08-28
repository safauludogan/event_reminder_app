import 'package:event_reminder_app/core/constants/string_constants.dart';

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return StringConstants.wrongEmail;
  }
  if (!RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(value)) {
    return StringConstants.wrongEmail;
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return StringConstants.passwordIsEmpty;
  }

  return null;
}

String? validateTitle(String? value) {
  if (value == null || value.isEmpty) {
    return StringConstants.titleCannotEmpty;
  }

  return null;
}

String? validateLocation(String? value) {
  if (value == null || value.isEmpty) {
    return StringConstants.locationCannotEmpty;
  }

  return null;
}

String? validateNote(String? value) {
  if (value == null || value.isEmpty) {
    return StringConstants.noteCannotEmpty;
  }

  return null;
}
