import 'package:event_reminder_app/core/components/base/base_custom_textfield.dart';
import 'package:event_reminder_app/core/constants/project_variables.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    required this.controller,
    required this.hintText,
    this.maxLines,
    this.maxLength = ProjectVaribles.textMaxLength,
    super.key,
  });
  final TextEditingController controller;
  final String hintText;
  final int? maxLength;
  final int? maxLines;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  int textLength = 0;
  void onChange(String value) {
    setState(() {
      textLength = value.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseTextFormField(
      context: context,
      controller: widget.controller,
      maxLines: widget.maxLines,
      hintText: widget.hintText,
      maxLength: widget.maxLength,
      suffixText: '  $textLength/${widget.maxLength}',
      onChanged: onChange,
    );
  }
}
