import 'package:equatable/equatable.dart';
import 'package:event_reminder_app/core/init/toast/toast_service.dart';
import 'package:event_reminder_app/product/model/tag.dart';
import 'package:flutter/material.dart';

@immutable
final class CreateNoteState extends Equatable {
  const CreateNoteState({
    required this.tagsLoading,
    required this.isAllDayEventSelect,
    required this.isRepetitiveEventSelect,
    required this.startDate,
    required this.endDate,
    required this.tags,
    this.startTime,
    this.endTime,
    this.chipValues,
  });
  final bool tagsLoading;
  final bool isAllDayEventSelect;
  final bool isRepetitiveEventSelect;
  final DateTime startDate;
  final String? startTime;
  final DateTime endDate;
  final String? endTime;
  final List<Tag>? tags;
  final List<bool>? chipValues;

  CreateNoteState copyWith({
    bool? tagsLoading,
    bool? isAllDayEventSelect,
    bool? isRepetitiveEventSelect,
    DateTime? startDate,
    String? startTime,
    DateTime? endDate,
    String? endTime,
    List<Tag>? tags,
    List<ChoiceChip>? chips,
    List<bool>? chipValues,
  }) {
    return CreateNoteState(
      isAllDayEventSelect: isAllDayEventSelect ?? this.isAllDayEventSelect,
      isRepetitiveEventSelect:
          isRepetitiveEventSelect ?? this.isRepetitiveEventSelect,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      endDate: endDate ?? this.endDate,
      endTime: endTime ?? this.endTime,
      tags: tags ?? this.tags,
      tagsLoading: tagsLoading ?? this.tagsLoading,
      chipValues: chipValues ?? this.chipValues,
    );
  }

  CreateNoteState clear() {
    return CreateNoteState(
      isAllDayEventSelect: false,
      isRepetitiveEventSelect: false,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      startTime: TimeOfDay.now().format(context),
      endTime: TimeOfDay.now().format(context),
      tagsLoading: false,
      tags: tags,
      chipValues: chipValues,
    );
  }

  @override
  List<Object?> get props => [
        tagsLoading,
        isAllDayEventSelect,
        isRepetitiveEventSelect,
        startDate,
        startTime,
        endDate,
        endTime,
        tags,
        chipValues,
      ];
}
