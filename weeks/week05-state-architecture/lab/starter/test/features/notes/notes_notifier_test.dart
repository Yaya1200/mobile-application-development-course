import 'package:campus_companion/features/notes/data/notes_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // A ProviderContainer is a ProviderScope without widgets: the way to
  // unit-test providers.
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer.test();
  });

  test('starts empty', () {
    expect(container.read(notesProvider), isEmpty);
  });

  test('add appends a note with a generated id', () {
    final notifier = container.read(notesProvider.notifier);

    final note = notifier.add(title: 'Buy milk', body: '2 litres');

    expect(note.id, 'n1');
    expect(container.read(notesProvider), [note]);
    expect(notifier.add(title: 'Second', body: '').id, 'n2');
  });

  test('update replaces the note and bumps updatedAt', () {
    final notifier = container.read(notesProvider.notifier);
    final note = notifier.add(title: 'Old', body: '', now: DateTime(2026, 1, 1));

    notifier.update(note.copyWith(title: 'New'), now: DateTime(2026, 1, 2));

    final stored = container.read(noteByIdProvider(note.id))!;
    expect(stored.title, 'New');
    expect(stored.updatedAt, DateTime(2026, 1, 2));
  });

  test('remove deletes by id and leaves others', () {
    final notifier = container.read(notesProvider.notifier);
    final a = notifier.add(title: 'A', body: '');
    final b = notifier.add(title: 'B', body: '');

    notifier.remove(a.id);

    expect(container.read(notesProvider), [b]);
    expect(container.read(noteByIdProvider(a.id)), isNull);
  });

  test('togglePinned flips the flag', () {
    final notifier = container.read(notesProvider.notifier);
    final a = notifier.add(title: 'A', body: '');

    notifier.togglePinned(a.id);
    expect(container.read(noteByIdProvider(a.id))!.isPinned, isTrue);

    notifier.togglePinned(a.id);
    expect(container.read(noteByIdProvider(a.id))!.isPinned, isFalse);
  });

  test('sortedNotes puts pinned first, then most recently updated', () {
    final notifier = container.read(notesProvider.notifier);
    final old = notifier.add(title: 'old', body: '', now: DateTime(2026, 1, 1));
    final newer = notifier.add(title: 'newer', body: '', now: DateTime(2026, 1, 3));
    final pinned = notifier.add(title: 'pinned', body: '', now: DateTime(2026, 1, 2));
    notifier.togglePinned(pinned.id);

    final sorted = container.read(sortedNotesProvider).map((n) => n.title);

    expect(sorted, ['pinned', 'newer', 'old']);
    expect(old.updatedAt.isBefore(newer.updatedAt), isTrue);
  });

  test('state is immutable: the exposed list cannot be mutated', () {
    final notifier = container.read(notesProvider.notifier);
    notifier.add(title: 'A', body: '');

    expect(
      () => container.read(notesProvider).clear(),
      throwsUnsupportedError,
    );
  });
}
