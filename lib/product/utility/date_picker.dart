import 'package:flutter/material.dart';

class DatePicker {
  Future<DateTime?> pickDate({required BuildContext context}) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 50),
    );
    return selectedDate;
  }

  Future<String?> pickTime({required BuildContext context}) async {
    final selectedTime = await showTimePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData(useMaterial3: true),
          child: child!,
        );
      },
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null && context.mounted) {
      return selectedTime.format(context);
    }
    if (!context.mounted) return '';
    return TimeOfDay.now().format(context);
  }
}
