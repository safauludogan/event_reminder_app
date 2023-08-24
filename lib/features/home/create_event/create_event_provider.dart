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
            endDate: DateTime.now(),
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

  void setStartTime(String time) {
    state = state.copyWith(startTime: time);
  }

   void setEndDate(DateTime date) {
    state = state.copyWith(endDate: date);
  }

  void setEndTime(String time) {
    state = state.copyWith(endTime: time);
  }
}

@immutable
final class CreateNoteState extends Equatable {
  final bool isAllDayEventSelect;
  final bool isRepetitiveEventSelect;
  final DateTime startDate;
  final String? startTime;
  final DateTime endDate;
  final String? endTime;

  const CreateNoteState({
    required this.isAllDayEventSelect,
    required this.isRepetitiveEventSelect,
    required this.startDate,
    required this.endDate,
    this.startTime,
    this.endTime,
  });

  CreateNoteState copyWith({
    bool? isAllDayEventSelect,
    bool? isRepetitiveEventSelect,
    DateTime? startDate,
    String? startTime,
    DateTime? endDate,
    String? endTime,
  }) {
    return CreateNoteState(
      isAllDayEventSelect: isAllDayEventSelect ?? this.isAllDayEventSelect,
      isRepetitiveEventSelect:
          isRepetitiveEventSelect ?? this.isRepetitiveEventSelect,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      endDate: endDate ?? this.endDate,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  List<Object?> get props => [
        isAllDayEventSelect,
        isRepetitiveEventSelect,
        startDate,
        startTime,
        endDate,
        endTime
      ];
}
