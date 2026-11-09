import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';

/// A personal note. Immutable; changes go through `copyWith`.
@freezed
abstract class Note with _$Note {
  const factory Note({
    required String id,
    required String title,
    required String body,
    required DateTime updatedAt,
    @Default(false) bool isPinned,
  }) = _Note;

  const Note._();

  bool get isEmpty => title.trim().isEmpty && body.trim().isEmpty;
}
