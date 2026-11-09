import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/event.dart';
import 'sample_events.dart';

part 'events_repository.g.dart';

/// What the app needs from an events data source. The UI and providers
/// depend on this interface; week 9 adds a REST implementation and
/// nothing above this line changes.
abstract interface class EventsRepository {
  Future<List<Event>> fetchAll();
  Future<Event?> fetchById(String id);
}

/// In-memory implementation with a small artificial delay so the loading
/// state is visible.
class InMemoryEventsRepository implements EventsRepository {
  InMemoryEventsRepository({
    List<Event>? events,
    this.delay = const Duration(milliseconds: 400),
  }) : _events = events ?? sampleEvents;

  final List<Event> _events;
  final Duration delay;

  @override
  Future<List<Event>> fetchAll() async {
    await Future<void>.delayed(delay);
    return List.unmodifiable(_events);
  }

  @override
  Future<Event?> fetchById(String id) async {
    await Future<void>.delayed(delay);
    return _events.where((e) => e.id == id).firstOrNull;
  }
}

/// The repository as a provider. Tests override it with a fake:
/// `eventsRepositoryProvider.overrideWithValue(FakeRepo())`.
@riverpod
EventsRepository eventsRepository(Ref ref) => InMemoryEventsRepository();
