import 'package:event_reminder_app/core/constants/project_variables.dart';
import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

@immutable
final class BaseTextFormField extends TextFormField {
  BaseTextFormField({
    required this.context,
    required super.controller,
    this.suffixText,
    super.key,
    super.initialValue,
    super.focusNode,
    String? hintText,
    super.keyboardType,
    super.textCapitalization = TextCapitalization.none,
    super.autofocus = false,
    super.obscuringCharacter = '•',
    super.obscureText = false,
    super.autocorrect = true,
    super.enableSuggestions = true,
    super.maxLines = 1,
    super.minLines, // when multiline = true, minLines = 6
    super.expands = false,
    super.maxLength = ProjectVaribles.textMaxLength,
    super.onChanged,
    super.onTap,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onSaved,
    super.validator,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth = 2.0,
    super.enableInteractiveSelection = true,
    super.autofillHints,
    super.autovalidateMode,
    super.textInputAction = TextInputAction.next,
  }) : super(
          decoration: customDecoration(context, hintText, suffixText),
        );
  late final BuildContext context;
  String? suffixText;
}

InputDecoration customDecoration(
  BuildContext context,
  String? hintText,
  String? suffixText,
) {
  return InputDecoration(
    hintStyle: context.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.w500,
      color: Colors.grey,
    ),
    contentPadding: const EdgeInsets.only(
      left: 8,
      right: 8,
      top: 8,
      bottom: 8,
    ),
    suffixText: suffixText,
    hintText: hintText,
    fillColor: Colors.white,
    filled: true,
    focusedErrorBorder: customBorder,
    disabledBorder: customBorder,
    focusedBorder: customBorder,
    border: customBorder,
    enabledBorder: customBorder,
    errorBorder: customBorder,
    counterText: '',
  );
}

OutlineInputBorder get customBorder => OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueGrey.withOpacity(0.2)),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );
