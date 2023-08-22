import 'dart:async';

import 'package:event_reminder_app/core/components/widgets/lottie_widget.dart';
import 'package:event_reminder_app/core/extension/context_extension.dart';
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
      child: AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Center(
          child: LottiePath.alertLoading
              .toWidget(size: context.dynamicHeight(0.2)),
        ),
      ),
    );
  }
}
