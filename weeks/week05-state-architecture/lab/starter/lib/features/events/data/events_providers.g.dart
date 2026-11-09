// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// All events. A `Future` provider: widgets watch it as an `AsyncValue`
/// with loading / data / error states. Cached until invalidated.

@ProviderFor(events)
final eventsProvider = EventsProvider._();

/// All events. A `Future` provider: widgets watch it as an `AsyncValue`
/// with loading / data / error states. Cached until invalidated.

final class EventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Event>>,
          List<Event>,
          FutureOr<List<Event>>
        >
    with $FutureModifier<List<Event>>, $FutureProvider<List<Event>> {
  /// All events. A `Future` provider: widgets watch it as an `AsyncValue`
  /// with loading / data / error states. Cached until invalidated.
  EventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsHash();

  @$internal
  @override
  $FutureProviderElement<List<Event>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Event>> create(Ref ref) {
    return events(ref);
  }
}

String _$eventsHash() => r'ea279552634df66691fc0641fb75e385c23daea6';

/// One event by id. A *family*: `ref.watch(eventProvider('e1'))`.

@ProviderFor(event)
final eventProvider = EventFamily._();

/// One event by id. A *family*: `ref.watch(eventProvider('e1'))`.

final class EventProvider
    extends $FunctionalProvider<AsyncValue<Event?>, Event?, FutureOr<Event?>>
    with $FutureModifier<Event?>, $FutureProvider<Event?> {
  /// One event by id. A *family*: `ref.watch(eventProvider('e1'))`.
  EventProvider._({
    required EventFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventHash();

  @override
  String toString() {
    return r'eventProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Event?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Event?> create(Ref ref) {
    final argument = this.argument as String;
    return event(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EventProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventHash() => r'6dbd4f455403e7c190716f0eee4c78e0c22b01c2';

/// One event by id. A *family*: `ref.watch(eventProvider('e1'))`.

final class EventFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Event?>, String> {
  EventFamily._()
    : super(
        retry: null,
        name: r'eventProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One event by id. A *family*: `ref.watch(eventProvider('e1'))`.

  EventProvider call(String id) => EventProvider._(argument: id, from: this);

  @override
  String toString() => r'eventProvider';
}

/// The clock, as a provider, so screens that split upcoming/past can be
/// tested with a fixed time.

@ProviderFor(now)
final nowProvider = NowProvider._();

/// The clock, as a provider, so screens that split upcoming/past can be
/// tested with a fixed time.

final class NowProvider
    extends $FunctionalProvider<DateTime, DateTime, DateTime>
    with $Provider<DateTime> {
  /// The clock, as a provider, so screens that split upcoming/past can be
  /// tested with a fixed time.
  NowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nowHash();

  @$internal
  @override
  $ProviderElement<DateTime> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DateTime create(Ref ref) {
    return now(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$nowHash() => r'cd84bcb298b7b9e78457b899f2d2445afe8d297f';
