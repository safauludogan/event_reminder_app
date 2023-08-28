// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:event_reminder_app/core/constants/string_constants.dart';
import 'package:event_reminder_app/core/extension/string_extension.dart';
import 'package:event_reminder_app/core/init/toast/toast_service.dart';
import 'package:event_reminder_app/product/components/loading/loading_dialog.dart';
import 'package:event_reminder_app/product/model/notes.dart';
import 'package:event_reminder_app/product/model/tag.dart';
import 'package:event_reminder_app/product/utility/enum/firebase_collections.dart';
import 'package:event_reminder_app/product/utility/firebase_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateNoteProvider extends StateNotifier<CreateNoteState>
    with FirebaseManager {
  CreateNoteProvider(BuildContext context)
      : super(
          CreateNoteState(
            isAllDayEventSelect: false,
            isRepetitiveEventSelect: false,
            startDate: DateTime.now(),
            endDate: DateTime.now(),
            startTime: TimeOfDay.now().format(context),
            endTime: TimeOfDay.now().format(context),
            tags: null,
            tagsLoading: true,
          ),
        ) {
    getTags();
  }

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final noteController = TextEditingController();

  void disp() {
    titleController.dispose();
    locationController.dispose();
    noteController.dispose();
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
    setStartTime('00:00');
    setEndTime('23:59');
  }

  void changeRepetitiveEventSelect(bool value) {
    state = state.copyWith(isRepetitiveEventSelect: value);
  }

  void setStartDate(DateTime date) {
    state = state.copyWith(startDate: date);
    if (state.isAllDayEventSelect) {
      setEndDate(date);
    }
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

  Future<List<Tag>?> getTagsFromFirebase() async {
    final response = await read(FirebaseCollections.tags.reference, Tag());
    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      return values;
    }
    return null;
  }

  Future<void> postDataToFirebase() async {
    if (!globalKey.currentState!.validate()) return;
    try {
      LoadingDialog(context).show();
      final tagIdList = addChipsListToModel();

      startAndEndTimeParser();
      await write(
        FirebaseCollections.notes.reference,
        Note(
          createdDate: DateTime.now(),
          imagePath: '',
          isAllDay: state.isAllDayEventSelect,
          note: noteController.text,
          startDate: state.startDate,
          endDate: state.endDate,
          tagsId: tagIdList,
          title: titleController.text,
        ),
      );
      ToastService.success.show(text: StringConstants.noteCreated);
    } finally {
      clearAllPage();
      LoadingDialog(context).dissmis();
    }
  }

  List<String> addChipsListToModel() {
    if (state.chipValues == null) return [];
    // ignore: omit_local_variable_types, prefer_final_locals
    List<String> tagIdList = <String>[];

    state.chipValues?.asMap().forEach((index, e) {
      if (e && state.tags![index].id != null) {
        tagIdList.add(state.tags![index].id.toString());
      }
    });
    return tagIdList;
  }

  void startAndEndTimeParser() {
    state = state.copyWith(
      startDate: DateTime(
        state.startDate.year,
        state.startDate.month,
        state.startDate.day,
        state.startTime!.dateTimeFormat!.hour,
        state.startTime!.dateTimeFormat!.minute,
      ),
    );

    ///
    state = state.copyWith(
      endDate: DateTime(
        state.endDate.year,
        state.endDate.month,
        state.endDate.day,
        state.endTime!.dateTimeFormat!.hour,
        state.endTime!.dateTimeFormat!.minute,
      ),
    );
  }

  void clearAllPage() {
    noteController.clear();
    titleController.clear();
    locationController.clear();
    state = state.clear();
  }
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

  CreateNoteState clear() {
    return CreateNoteState(
      isAllDayEventSelect: false,
      isRepetitiveEventSelect: false,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      startTime: TimeOfDay.now().format(context),
      endTime: TimeOfDay.now().format(context),
      tags: null,
      tagsLoading: false,
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
