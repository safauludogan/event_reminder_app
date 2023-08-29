import 'package:equatable/equatable.dart';
import 'package:event_reminder_app/product/model/notes.dart';
import 'package:event_reminder_app/product/model/tag.dart';

class EventState extends Equatable {
  const EventState({
    this.eventLoading,
    this.notes,
    this.tags,
  });

  final bool? eventLoading;
  final List<Note>? notes;
  final List<Tag>? tags;

  EventState copyWith({
    bool? eventLoading,
    List<Note>? notes,
    List<Tag>? tags,
  }) {
    return EventState(
      eventLoading: eventLoading ?? this.eventLoading,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [eventLoading, notes, tags];

  @override
  bool get stringify => true;
}
