import 'package:event_reminder_app/features/home/create_event/create_event_view.dart';
import 'package:flutter/material.dart';

abstract class CreateEventViewModel extends State<CreateEventView> {
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    locationController.dispose();
    noteController.dispose();
  }

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final noteController = TextEditingController();

  bool itemSelect = false;
}
