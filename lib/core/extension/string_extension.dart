import 'package:event_reminder_app/core/utils/date_formatter.dart';

extension StringExtension on String {
  String? get dateFormat => DateFormatter().convertDateFormat(this);
}
