import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/event.dart';
import 'events_repository.dart';

part 'events_providers.g.dart';

/// All events. A `Future` provider: widgets watch it as an `AsyncValue`
/// with loading / data / error states. Cached until invalidated.
@riverpod
Future<List<Event>> events(Ref ref) {
  return ref.watch(eventsRepositoryProvider).fetchAll();
}

/// One event by id. A *family*: `ref.watch(eventProvider('e1'))`.
@riverpod
Future<Event?> event(Ref ref, String id) {
  return ref.watch(eventsRepositoryProvider).fetchById(id);
}

/// The clock, as a provider, so screens that split upcoming/past can be
/// tested with a fixed time.
@riverpod
DateTime now(Ref ref) => DateTime.now();
