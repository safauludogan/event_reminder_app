import 'package:event_reminder_app/core/constants/string_constants.dart';
import 'package:event_reminder_app/core/extension/string_extension.dart';
import 'package:event_reminder_app/core/init/toast/toast_service.dart';
import 'package:event_reminder_app/features/home/create_event/create_event_state.dart';
import 'package:event_reminder_app/product/components/loading/loading_dialog.dart';
import 'package:event_reminder_app/product/model/notes.dart';
import 'package:event_reminder_app/product/model/tag.dart';
import 'package:event_reminder_app/product/utility/enum/firebase_collections.dart';
import 'package:event_reminder_app/product/utility/firebase_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateNoteProvider extends StateNotifier<CreateNoteState>
    with FirebaseManager {
  CreateNoteProvider()
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
  List<Tag> tagList = [];
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
      tagList = response;
      state = state.copyWith(chipValues: _generateChipsValues(tagList));
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
    final tagIdList = <String>[];

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
    state = state.copyWith(chipValues: _generateChipsValues(tagList));
    noteController.clear();
    titleController.clear();
    locationController.clear();
    state = state.clear();
  }
}
