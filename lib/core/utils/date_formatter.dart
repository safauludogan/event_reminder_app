import 'package:intl/intl.dart';

class DateFormatter {
  String? convertDateFormat(String? date) {
    print(date);
    if (date != null && DateTime.tryParse(date) != null) {
      return DateFormat('dd-MM-yyyy').format(
        DateTime.parse(date),
      );
    }
    throw Exception('$this date formatte cannot convert');
  }
}
