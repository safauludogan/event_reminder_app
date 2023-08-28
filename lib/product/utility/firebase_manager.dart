import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_reminder_app/product/utility/base/base_firebase_model.dart';

mixin FirebaseManager {
  Future<QuerySnapshot<T>> read<T extends BaseFirebaseModel>(
    CollectionReference reference,
    T model,
  ) async {
    final response = await reference.withConverter<T>(
      fromFirestore: (snapshot, options) {
        return model.fromFirebase(snapshot) as T;
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    ).get();
    return response;
  }

  Future<bool> write<T extends BaseFirebaseModel>(
    CollectionReference reference,
    T model,
  ) async {
    await reference.add(model.toJson());
    return true;
  }
}
