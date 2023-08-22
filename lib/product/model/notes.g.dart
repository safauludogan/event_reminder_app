// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notes _$NotesFromJson(Map<String, dynamic> json) => Notes(
      id: json['id'] as String?,
      title: json['title'] as String?,
      note: json['note'] as String?,
      imagePath: json['imagePath'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      reminderDate: json['reminderDate'] == null
          ? null
          : DateTime.parse(json['reminderDate'] as String),
      tagsId:
          (json['tagsId'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$NotesToJson(Notes instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'note': instance.note,
      'imagePath': instance.imagePath,
      'createdDate': instance.createdDate?.toIso8601String(),
      'reminderDate': instance.reminderDate?.toIso8601String(),
      'tagsId': instance.tagsId,
    };
