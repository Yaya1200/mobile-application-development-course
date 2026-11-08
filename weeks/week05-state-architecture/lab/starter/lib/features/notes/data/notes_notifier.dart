import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/note.dart';

part 'notes_notifier.g.dart';

/// The list of notes and the operations on it.
///
/// A Notifier owns mutable state and exposes methods that replace it. The
/// state is an *unmodifiable* list: every change builds a new list and
/// assigns it to `state`, which is how Riverpod knows to notify listeners.
/// Mutating the list in place (`state.add(...)`) would change nothing on
/// screen — and here it throws, so the mistake is caught immediately.
@riverpod
class Notes extends _$Notes {
  // TODO(lab): Task 1 — implement add, update, remove and togglePinned.
  // The contract is test/features/notes/notes_notifier_test.dart.

  // ignore: prefer_final_fields — incremented once Task 1 is done
  int _nextId = 1;

  @override
  List<Note> build() => const [];

  /// Adds a note with id `'n$_nextId'` (then increments) and returns it.
  Note add({required String title, required String body, DateTime? now}) {
    throw UnimplementedError('add: next id would be n$_nextId');
  }

  /// Replaces the note with the same id, setting updatedAt to [now].
  void update(Note updated, {DateTime? now}) {
    throw UnimplementedError();
  }

  /// Removes the note with this id. Other notes stay.
  void remove(String id) {
    throw UnimplementedError();
  }

  /// Flips `isPinned` of the note with this id.
  void togglePinned(String id) {
    throw UnimplementedError();
  }
}

/// Derived state: pinned first, then most recently updated. Recomputed
/// only when [notesProvider] changes.
@riverpod
List<Note> sortedNotes(Ref ref) {
  // TODO(lab): Task 1 — return the notes in this order, without changing
  // the list that notesProvider holds.
  return ref.watch(notesProvider);
}

/// One note by id, or null. A family provider.
@riverpod
Note? noteById(Ref ref, String id) {
  return ref.watch(notesProvider).where((n) => n.id == id).firstOrNull;
}
