import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum LottiePath {
  alertLoading('lottie_alert_loading');

  const LottiePath(this.value);
  final String value;
}

extension LottiePathExtension on LottiePath {
  Widget toWidget({double? size}) {
    return Lottie.asset(withPath(value), width: size, height: size);
  }

  String withPath(String value) => 'assets/lottie/$value.json';
}
