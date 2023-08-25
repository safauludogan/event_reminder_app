import 'package:event_reminder_app/core/authentication_manager/authentication_manager.dart';
import 'package:event_reminder_app/core/constants/string_constants.dart';
import 'package:event_reminder_app/core/extension/context_extension.dart';
import 'package:event_reminder_app/features/authentication/login/model/login_response_model.dart';
import 'package:event_reminder_app/product/manager/database/operations/login_hive_operation.dart';
import 'package:event_reminder_app/product/manager/theme/theme_manager.dart';
import 'package:event_reminder_app/product/model/notes.dart';
import 'package:event_reminder_app/product/utility/enum/firebase_collections.dart';
import 'package:flutter/material.dart';

class EventsView extends StatefulWidget {
  const EventsView({super.key});

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  @override
  void initState() {
    super.initState();
    getDataFromFirebase();
    //getLoginData();
  }

  Future<void> getDataFromFirebase() async {
    final response =
        await FirebaseCollections.notes.reference.withConverter<Note>(
      fromFirestore: (snapshot, options) {
        return Note().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    ).get();

    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      for (final data in values) {
        //print(data);
      }
    }
    /* final notes2 = FirebaseFirestore.instance.collection('notes');
    final result = await notes2.doc("cpGJsPMaeRYAijexiY5s").get();
    final data = result.data() as Map<String, dynamic>;
    print("?" * 100);
    print(data['tagsId'].runtimeType);
    print("?" * 100);*/
  }

  Future<void> getLoginData() async {
    await _loginHiveOperation.open();
    final result = _loginHiveOperation.getItem(LoginResponseModel().key);
  }

  final _loginHiveOperation = LoginHiveOperation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async => AuthenticationManager().logOut(),
              child: const Text(StringConstants.logout),
            ),
            TextButton(
              onPressed: () async {
                await _loginHiveOperation.clear();
              },
              child: Text('Delete', style: context.textTheme.bodySmall),
            )
          ],
        ),
      ),
    );
  }
}
