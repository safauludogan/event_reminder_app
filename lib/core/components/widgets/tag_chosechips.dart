import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class TagChoseChips extends StatelessWidget {
  const TagChoseChips(
      {required this.labelString,
      required this.isSelected,
      required this.onSelected,
      this.selectedColor,
      super.key});
  final Color? selectedColor;
  final String labelString;
  final bool isSelected;
  final void Function(bool selected)? onSelected;
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selectedColor: selectedColor,
      backgroundColor: Colors.grey.shade300,
      label: Text(
        labelString,
        style: context.textTheme.labelMedium?.copyWith(
          color: isSelected ? Colors.white : Colors.grey,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: context.borderRadiusHigh,
      ),
      selected: isSelected,
      onSelected: onSelected,
    );
  }
}
