// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:event_reminder_app/product/model/tag.dart';
import 'package:event_reminder_app/product/utility/enum/firebase_collections.dart';
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
            tags: null,
            tagsLoading: true,
          ),
        ) {
    getTags();
  }

  Future<void> getTags() async {
    state = state.copyWith(tagsLoading: true);
    final response = await getTagsFromFirebase();
    state = state.copyWith(tags: response);
    if (response != null && response.isNotEmpty) {
      state = state.copyWith(chipValues: _generateChipsValues(response));
    }
    state = state.copyWith(tagsLoading: false);
  }

  List<bool> _generateChipsValues(List<Tag> tags) {
    return List<bool>.generate(tags.length, (index) => false);
  }

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

  void updateChipValue(int index, bool value) {
    state.chipValues![index] = value;
    state = state.copyWith(chipValues: state.chipValues);
  }
}

Future<List<Tag>?> getTagsFromFirebase() async {
  final response = await FirebaseCollections.tags.reference.withConverter<Tag>(
    fromFirestore: (snapshot, options) {
      return Tag().fromFirebase(snapshot);
    },
    toFirestore: (value, options) {
      return value.toJson();
    },
  ).get();

  if (response.docs.isNotEmpty) {
    final values = response.docs.map((e) => e.data()).toList();
    return values;
  }
  return null;
}

@immutable
final class CreateNoteState extends Equatable {
  final bool tagsLoading;
  final bool isAllDayEventSelect;
  final bool isRepetitiveEventSelect;
  final DateTime startDate;
  final String? startTime;
  final DateTime endDate;
  final String? endTime;
  final List<Tag>? tags;
  final List<bool>? chipValues;

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
