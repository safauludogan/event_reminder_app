// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:event_reminder_app/product/utility/base/base_firebase_model.dart';
import 'package:flutter/material.dart';

class Tag extends BaseFirebaseModel<Tag> implements IdModel {
  Tag({
    this.title,
    this.id,
    this.color,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      title: json['title'] as String?,
      id: json['id'] as String?,
      color:
          Color(int.parse((json['color'] as String).replaceAll('#', '0xff'))),
    );
  }
  String? title;
  @override
  final String? id;
  final Color? color;

  Tag copyWith({
    String? id,
    String? title,
    Color? color,
  }) {
    return Tag(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'color': color,
    };
  }

  @override
  Tag fromJson(Map<String, dynamic> json) => Tag.fromJson(json);
}
