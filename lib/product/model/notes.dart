// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:event_reminder_app/product/utility/base/base_firebase_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notes.g.dart';

@JsonSerializable()
class Note extends BaseFirebaseModel<Note> implements IdModel {
  Note({
    this.id,
    this.title,
    this.note,
    this.imagePath,
    this.isAllDay,
    this.createdDate,
    this.startDate,
    this.endDate,
    this.tagsId,
  });

  final String? title;
  final String? note;
  final String? imagePath;
  final bool? isAllDay;
  final DateTime? createdDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String>? tagsId;
  @JsonKey(includeToJson: false)
  @override
  final String? id;

  Note copyWith({
    String? id,
    String? title,
    String? note,
    String? imagePath,
    bool? isAllDay,
    DateTime? createdDate,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? tagsId,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      imagePath: imagePath ?? this.imagePath,
      isAllDay: isAllDay ?? this.isAllDay,
      createdDate: createdDate ?? this.createdDate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      tagsId: tagsId ?? this.tagsId,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$NoteToJson(this);
  }

  @override
  factory Note.fromJson(Map<String, dynamic> json) {
    return _$NoteFromJson(json);
  }

  @override
  Note fromJson(Map<String, dynamic> json) {
    return Note.fromJson(json);
  }

  @override
  String toString() {
    return 'Note(title: $title, note: $note, imagePath: $imagePath, isAllDay: $isAllDay, createdDate: $createdDate, startDate: $startDate, endDate: $endDate, tagsId: $tagsId, id: $id)';
  }
}
