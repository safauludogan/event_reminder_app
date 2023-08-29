import 'package:event_reminder_app/core/init/toast/toast_service.dart';
import 'package:event_reminder_app/features/home/events_page/event_state.dart';
import 'package:event_reminder_app/product/components/loading/loading_dialog.dart';
import 'package:event_reminder_app/product/model/notes.dart';
import 'package:event_reminder_app/product/model/tag.dart';
import 'package:event_reminder_app/product/utility/enum/firebase_collections.dart';
import 'package:event_reminder_app/product/utility/firebase_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class EventProvider extends StateNotifier<EventState>
    with FirebaseManager {
  EventProvider()
      : super(
          const EventState(
            notes: [],
            tags: [],
          ),
        ) {
    getDataFromFirebase();
    getTagsFromFirebase();
  }
  List<Note> notes = [];

  Future<void> getDataFromFirebase() async {
    try {
      LoadingDialog(context).show();
      notes.clear();
      final response =
          await read<Note>(FirebaseCollections.notes.reference, Note());

      if (response.docs.isNotEmpty) {
        response.docs.map((e) {
          if (e.data().startDate!.compareTo(DateTime.now()) == -1) {
            notes.add(e.data());
          }
        }).toList();
        state = state.copyWith(notes: notes);
      }
    } finally {
      LoadingDialog(context).dissmis();
    }
  }

  Future<void> getTagsFromFirebase() async {
    final response = await read(FirebaseCollections.tags.reference, Tag());
    if (response.docs.isNotEmpty) {
      final tagList = response.docs.map((e) => e.data()).toList();
      state = state.copyWith(tags: tagList);
    }
  }

  Tag getTagDetail(String tagsId) {
    var tag = Tag();
    state.tags!.map((element) {
      if (tagsId == element.id) {
        tag = element;
      }
    }).toList();
    return tag;
  }
}



/*
  final _loginHiveOperation = LoginHiveOperation();

  Future<void> getLoginData() async {
    await _loginHiveOperation.open();
    final result = _loginHiveOperation.getItem(LoginResponseModel().key);
  }
*/

/*
  TextButton(
              onPressed: () async => AuthenticationManager().logOut(),
              child: const Text(StringConstants.logout),
            ),
*/
