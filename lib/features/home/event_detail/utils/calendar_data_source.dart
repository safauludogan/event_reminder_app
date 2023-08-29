import 'package:syncfusion_flutter_calendar/calendar.dart';

class NoteDataSource extends CalendarDataSource {
  NoteDataSource(
    List<Appointment> source,
    Map<DateTime, List<Appointment>>? collection,
  ) {
    appointments = source;
    dataCollection = collection;
  }
  Map<DateTime, List<Appointment>>? dataCollection;

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final notes = <Appointment>[];
    var date = DateTime(startDate.year, startDate.month, startDate.day);
    final appEndDate =
        DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);

    while (date.isBefore(appEndDate)) {
      final data = dataCollection?[date];
      if (data == null) {
        date = date.add(const Duration(days: 1));
        continue;
      }

      for (final note in data) {
        if (appointments!.contains(note)) {
          continue;
        }
        notes.add(note);
      }
      date = date.add(const Duration(days: 1));
    }
    appointments!.addAll(notes);
    notifyListeners(CalendarDataSourceAction.add, notes);
  }
}
