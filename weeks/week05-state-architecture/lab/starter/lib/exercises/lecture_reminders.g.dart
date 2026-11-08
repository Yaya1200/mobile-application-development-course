// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_reminders.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Reminders)
final remindersProvider = RemindersProvider._();

final class RemindersProvider
    extends $NotifierProvider<Reminders, List<Reminder>> {
  RemindersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remindersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remindersHash();

  @$internal
  @override
  Reminders create() => Reminders();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Reminder> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Reminder>>(value),
    );
  }
}

String _$remindersHash() => r'10cc145cfa2b9c06aa45834846da2e03ee43cc23';

abstract class _$Reminders extends $Notifier<List<Reminder>> {
  List<Reminder> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Reminder>, List<Reminder>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Reminder>, List<Reminder>>,
              List<Reminder>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Derived state: the reminders that are not done, soonest first.

@ProviderFor(openReminders)
final openRemindersProvider = OpenRemindersProvider._();

/// Derived state: the reminders that are not done, soonest first.

final class OpenRemindersProvider
    extends $FunctionalProvider<List<Reminder>, List<Reminder>, List<Reminder>>
    with $Provider<List<Reminder>> {
  /// Derived state: the reminders that are not done, soonest first.
  OpenRemindersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openRemindersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openRemindersHash();

  @$internal
  @override
  $ProviderElement<List<Reminder>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Reminder> create(Ref ref) {
    return openReminders(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Reminder> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Reminder>>(value),
    );
  }
}

String _$openRemindersHash() => r'7f8765f475e11cf165bf5421c48e1e0fd7a624e4';

/// A family: one cached value per id.

@ProviderFor(reminderById)
final reminderByIdProvider = ReminderByIdFamily._();

/// A family: one cached value per id.

final class ReminderByIdProvider
    extends $FunctionalProvider<Reminder?, Reminder?, Reminder?>
    with $Provider<Reminder?> {
  /// A family: one cached value per id.
  ReminderByIdProvider._({
    required ReminderByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'reminderByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reminderByIdHash();

  @override
  String toString() {
    return r'reminderByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Reminder?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Reminder? create(Ref ref) {
    final argument = this.argument as String;
    return reminderById(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Reminder? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Reminder?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ReminderByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reminderByIdHash() => r'f6ab822929cbe65382b1d1472c197289598ab3c6';

/// A family: one cached value per id.

final class ReminderByIdFamily extends $Family
    with $FunctionalFamilyOverride<Reminder?, String> {
  ReminderByIdFamily._()
    : super(
        retry: null,
        name: r'reminderByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A family: one cached value per id.

  ReminderByIdProvider call(String id) =>
      ReminderByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'reminderByIdProvider';
}
