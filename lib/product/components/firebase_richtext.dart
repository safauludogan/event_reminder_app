import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class FirebaseRichText extends StatelessWidget {
  const FirebaseRichText(
      {required this.title, required this.subtitle, super.key});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: context.textTheme.labelMedium?.copyWith(
          color: Colors.black45,
          letterSpacing: 1,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: subtitle,
            style: context.textTheme.labelMedium?.copyWith(
              wordSpacing: 2,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
