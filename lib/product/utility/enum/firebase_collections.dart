import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  notes;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
