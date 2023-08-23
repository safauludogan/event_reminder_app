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

  Future<TimeOfDay?> pickTime({required BuildContext context}) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return selectedTime;
  }
}
