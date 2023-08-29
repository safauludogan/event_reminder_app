// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:event_reminder_app/core/init/toast/toast_service.dart';
import 'package:event_reminder_app/features/home/event_detail/utils/calendar_data_source.dart';
import 'package:event_reminder_app/product/components/loading/loading_dialog.dart';
import 'package:event_reminder_app/product/model/notes.dart';
import 'package:event_reminder_app/product/utility/enum/firebase_collections.dart';
import 'package:event_reminder_app/product/utility/firebase_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDetailProvider extends StateNotifier<EventDetailState>
    with FirebaseManager {
  EventDetailProvider() : super(const EventDetailState()) {
    calendarController
      ..displayDate = DateTime.now()
      ..selectedDate = DateTime.now();
    getNotesFromFirebase();
  }
  Map<DateTime, List<Appointment>>? dataCollection;
  CalendarController calendarController = CalendarController();
  CalendarDataSource? calendarDataSource;
  String currentYear = DateTime.now().year.toString();
  String currentMonth = DateTime.now().month.toString();
  DateTime displayDate = DateTime.now();
  List<Note> noteList = [];

  void disp() {
    calendarController.dispose();
    calendarDataSource?.dispose();
  }

  Future<void> getNotesFromFirebase() async {
    state = state.copyWith(isLoading: true);
    await fetchNotes();
    calendarDataSource = NoteDataSource(<Appointment>[], dataCollection);
    state = state.copyWith(calendarDataSource: calendarDataSource);
    state = state.copyWith(isLoading: false);
  }

  Future<void> fetchNotes() async {
    try {
      LoadingDialog(context).show();
      noteList.clear();
      final response =
          await read<Note>(FirebaseCollections.notes.reference, Note());

      if (response.docs.isNotEmpty) {
        noteList = response.docs.map((e) => e.data()).toList();
        dataCollection = generateCalendarData();
      }
    } finally {
      LoadingDialog(context).dissmis();
    }
  }

  Map<DateTime, List<Appointment>> generateCalendarData() {
    final dataCollection = <DateTime, List<Appointment>>{};
    for (final item in noteList) {
      final date = DateTime(
        item.startDate!.year,
        item.startDate!.month,
        item.startDate!.day,
      );
      final note = Appointment(
        subject: item.note.toString(),
        notes: item.title,
        startTime: date.add(
          Duration(
            hours: item.startDate!.hour,
            minutes: item.startDate!.minute,
          ),
        ),
        endTime: date.add(
          Duration(hours: item.endDate!.hour, minutes: item.endDate!.hour),
        ),
        color: Colors.red,
      );

      if (dataCollection.containsKey(date)) {
        final notes = dataCollection[date]!;
        notes.add(note);
        dataCollection[date] = notes;
      } else {
        dataCollection[date] = [note];
      }
    }
    return dataCollection;
  }
}

class EventDetailState extends Equatable {
  final bool? isLoading;
  final CalendarDataSource? calendarDataSource;

  const EventDetailState({
    this.isLoading,
    this.calendarDataSource,
  });

  EventDetailState copyWith({
    bool? isLoading,
    CalendarDataSource? calendarDataSource,
  }) {
    return EventDetailState(
      isLoading: isLoading ?? this.isLoading,
      calendarDataSource: calendarDataSource ?? this.calendarDataSource,
    );
  }

  @override
  String toString() => 'EventDetailState(isLoading: $isLoading)';

  @override
  List<Object?> get props => [isLoading, calendarDataSource];
}
