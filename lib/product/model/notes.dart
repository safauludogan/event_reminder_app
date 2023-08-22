import 'package:event_reminder_app/product/utility/base/base_firebase_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notes.g.dart';

@JsonSerializable()
class Notes extends BaseFirebaseModel<Notes> implements IdModel {
  Notes({
    this.id,
    this.title,
    this.note,
    this.imagePath,
    this.createdDate,
    this.reminderDate,
    this.tagsId,
  });

  final String? title;
  final String? note;
  final String? imagePath;
  final DateTime? createdDate;
  final DateTime? reminderDate;
  final List<String>? tagsId;
  @override
  final String? id;

  Notes copyWith({
    String? id,
    String? title,
    String? note,
    String? imagePath,
    DateTime? createdDate,
    DateTime? reminderDate,
    List<String>? tagsId,
  }) {
    return Notes(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      imagePath: imagePath ?? this.imagePath,
      createdDate: createdDate ?? this.createdDate,
      reminderDate: reminderDate ?? this.reminderDate,
      tagsId: tagsId ?? this.tagsId,
    );
  }

  Map<String, dynamic> toJson() {
    return _$NotesToJson(this);
  }

  @override
  factory Notes.fromJson(Map<String, dynamic> json) {
    return _$NotesFromJson(json);
  }

  @override
  Notes fromJson(Map<String, dynamic> json) {
    return Notes.fromJson(json);
  }

  @override
  String toString() {
    return 'Notes(title: $title, note: $note, imagePath: $imagePath, createdDate: $createdDate, reminderDate: $reminderDate, tagsId: $tagsId, id: $id)';
  }
}
