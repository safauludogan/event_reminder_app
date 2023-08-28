import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_reminder_app/product/exceptions/firebase_exception.dart';

typedef DocSnapShot = DocumentSnapshot<Map<String, dynamic>>;

abstract class IdModel {
  String? get id;
}

abstract class BaseFirebaseModel<T extends IdModel> {
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  T fromFirebase(DocSnapShot snapshot) {
    final value = snapshot.data();
    if (value == null) {
      throw FirebaseCustomExceptions('$snapshot data is null');
    }
    value.addEntries([MapEntry('id', snapshot.id)]);
    return fromJson(value);
  }
}
