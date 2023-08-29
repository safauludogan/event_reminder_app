import 'package:event_reminder_app/core/constants/string_constants.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog {
  CustomAlertDialog(this.whenRemove);
  final Function(bool)? whenRemove;
  void showAlertDialog(BuildContext context) {
    // set up the buttons
    final cancelButton = TextButton(
      child: const Text(StringConstants.cancel),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    final continueButton = TextButton(
      child: const Text(StringConstants.delete),
      onPressed: () {
        whenRemove?.call(true);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    final alert = AlertDialog(
      title: const Text(StringConstants.deleteNote),
      content: const Text(StringConstants.deleteNoteSure),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
