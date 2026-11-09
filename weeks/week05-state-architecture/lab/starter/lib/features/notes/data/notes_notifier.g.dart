// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The list of notes and the operations on it.
///
/// A Notifier owns mutable state and exposes methods that replace it. The
/// state is an *unmodifiable* list: every change builds a new list and
/// assigns it to `state`, which is how Riverpod knows to notify listeners.
/// Mutating the list in place (`state.add(...)`) would change nothing on
/// screen — and here it throws, so the mistake is caught immediately.

@ProviderFor(Notes)
final notesProvider = NotesProvider._();

/// The list of notes and the operations on it.
///
/// A Notifier owns mutable state and exposes methods that replace it. The
/// state is an *unmodifiable* list: every change builds a new list and
/// assigns it to `state`, which is how Riverpod knows to notify listeners.
/// Mutating the list in place (`state.add(...)`) would change nothing on
/// screen — and here it throws, so the mistake is caught immediately.
final class NotesProvider extends $NotifierProvider<Notes, List<Note>> {
  /// The list of notes and the operations on it.
  ///
  /// A Notifier owns mutable state and exposes methods that replace it. The
  /// state is an *unmodifiable* list: every change builds a new list and
  /// assigns it to `state`, which is how Riverpod knows to notify listeners.
  /// Mutating the list in place (`state.add(...)`) would change nothing on
  /// screen — and here it throws, so the mistake is caught immediately.
  NotesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notesHash();

  @$internal
  @override
  Notes create() => Notes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Note> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Note>>(value),
    );
  }
}

String _$notesHash() => r'114201e86d3b532b53a66dfd1c0576601b36d48d';

/// The list of notes and the operations on it.
///
/// A Notifier owns mutable state and exposes methods that replace it. The
/// state is an *unmodifiable* list: every change builds a new list and
/// assigns it to `state`, which is how Riverpod knows to notify listeners.
/// Mutating the list in place (`state.add(...)`) would change nothing on
/// screen — and here it throws, so the mistake is caught immediately.

abstract class _$Notes extends $Notifier<List<Note>> {
  List<Note> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Note>, List<Note>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Note>, List<Note>>,
              List<Note>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Derived state: pinned first, then most recently updated. Recomputed
/// only when [notesProvider] changes.

@ProviderFor(sortedNotes)
final sortedNotesProvider = SortedNotesProvider._();

/// Derived state: pinned first, then most recently updated. Recomputed
/// only when [notesProvider] changes.

final class SortedNotesProvider
    extends $FunctionalProvider<List<Note>, List<Note>, List<Note>>
    with $Provider<List<Note>> {
  /// Derived state: pinned first, then most recently updated. Recomputed
  /// only when [notesProvider] changes.
  SortedNotesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortedNotesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortedNotesHash();

  @$internal
  @override
  $ProviderElement<List<Note>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Note> create(Ref ref) {
    return sortedNotes(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Note> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Note>>(value),
    );
  }
}

String _$sortedNotesHash() => r'055dbb5b6448480d9ac5b91b1f6c16f1a3143f5f';

/// One note by id, or null. A family provider.

@ProviderFor(noteById)
final noteByIdProvider = NoteByIdFamily._();

/// One note by id, or null. A family provider.

final class NoteByIdProvider extends $FunctionalProvider<Note?, Note?, Note?>
    with $Provider<Note?> {
  /// One note by id, or null. A family provider.
  NoteByIdProvider._({
    required NoteByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'noteByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$noteByIdHash();

  @override
  String toString() {
    return r'noteByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Note?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Note? create(Ref ref) {
    final argument = this.argument as String;
    return noteById(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Note? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Note?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NoteByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$noteByIdHash() => r'e3af00a4877ef51d55c93a4ce9b8ef296a294fed';

/// One note by id, or null. A family provider.

final class NoteByIdFamily extends $Family
    with $FunctionalFamilyOverride<Note?, String> {
  NoteByIdFamily._()
    : super(
        retry: null,
        name: r'noteByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One note by id, or null. A family provider.

  NoteByIdProvider call(String id) =>
      NoteByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'noteByIdProvider';
}
