import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class TitleView extends StatefulWidget {
  const TitleView({required this.text, super.key});
  final String text;
  @override
  State<TitleView> createState() => TitleViewState();
}

class TitleViewState extends State<TitleView> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: context.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
