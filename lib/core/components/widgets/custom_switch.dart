import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({required this.value, this.onChanged, super.key});
  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      filterQuality: FilterQuality.high,
      scale: 0.65,
      child: Switch(
        inactiveThumbColor: Colors.grey,
        activeColor: Colors.blue,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
