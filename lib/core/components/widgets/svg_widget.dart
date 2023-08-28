import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SvgPath {
  checked('checked'),
  denied('denied'),
  info('info'),
  noData('noData'),
  warning('warning');

  const SvgPath(this.value);
  final String value;
}

extension SvgPathExtension on SvgPath {
  Widget toWidget({required BuildContext context, double? size, Color? color}) {
    return SvgPicture.asset(
      withPath(value),
      color: color,
      height: size ?? 30,
      width: size ?? 30,
    );
  }

  String withPath(String path) => 'assets/svg/svg_$path.svg';
}
