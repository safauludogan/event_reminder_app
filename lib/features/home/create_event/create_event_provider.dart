// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateNoteProvider extends StateNotifier<CreateNoteState> {
  CreateNoteProvider()
      : super(
          CreateNoteState(
            isAllDayEventSelect: false,
            isRepetitiveEventSelect: false,
            startDate: DateTime.now(),
            startTime: TimeOfDay.now(),
          ),
        );

  void changeAllDayEventSelect(bool value) {
    state = state.copyWith(isAllDayEventSelect: value);
  }

  void changeRepetitiveEventSelect(bool value) {
    state = state.copyWith(isRepetitiveEventSelect: value);
  }

  void setStartDate(DateTime date) {
    state = state.copyWith(startDate: date);
  }

  void setStartTime(TimeOfDay time) {
    state = state.copyWith(startTime: time);
  }
}

@immutable
final class CreateNoteState extends Equatable {
  final bool isAllDayEventSelect;
  final bool isRepetitiveEventSelect;
  final DateTime startDate;
  final TimeOfDay startTime;
  const CreateNoteState({
    required this.isAllDayEventSelect,
    required this.isRepetitiveEventSelect,
    required this.startDate,
    required this.startTime,
  });

  CreateNoteState copyWith({
    bool? isAllDayEventSelect,
    bool? isRepetitiveEventSelect,
    DateTime? startDate,
    TimeOfDay? startTime,
  }) {
    return CreateNoteState(
      isAllDayEventSelect: isAllDayEventSelect ?? this.isAllDayEventSelect,
      isRepetitiveEventSelect:
          isRepetitiveEventSelect ?? this.isRepetitiveEventSelect,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
    );
  }

  @override
  List<Object?> get props =>
      [isAllDayEventSelect, isRepetitiveEventSelect, startDate, startTime];
}
