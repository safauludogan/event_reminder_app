import 'dart:async';

import 'package:flutter/material.dart';

class LoadingDialog {
  LoadingDialog(this.context);
  final BuildContext context;

  void show() {
    unawaited(
      showDialog<bool>(
        barrierDismissible: false,
        context: context,
        builder: showLoaderDialog,
      ),
    );
  }

  void dissmis() {
    Navigator.pop(context);
  }

  Widget showLoaderDialog(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
