import 'package:intl/intl.dart';

class DateFormatter {
  String? convertDateFormat(String? date) {
    if (date != null && DateTime.tryParse(date) != null) {
      return DateFormat('dd-MM-yyyy').format(
        DateTime.parse(date),
      );
    }
    throw Exception('$this date format cannot convert');
  }

  DateTime? convertDateTimeFormat(String? time) {
    if (time != null) {
      return DateFormat('HH:mm').parse(time);
    }
    throw Exception('$this date time format cannot convert');
  }

  String? convertTimeMMM(String? time) {
    if (time != null && DateTime.tryParse(time) != null) {
      return DateFormat.MMM('en_US').format(DateTime.parse(time));
    }
    throw Exception('$this date time format cannot convert');
  }
}
