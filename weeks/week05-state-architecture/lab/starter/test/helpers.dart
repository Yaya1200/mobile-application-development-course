import 'package:campus_companion/app.dart';
import 'package:campus_companion/core/router/router.dart';
import 'package:campus_companion/features/events/data/events_providers.dart';
import 'package:campus_companion/features/events/data/events_repository.dart';
import 'package:campus_companion/features/events/data/sample_events.dart';
import 'package:campus_companion/features/events/domain/event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
// `Override` (the type of a provider override) lives in misc.dart in
// Riverpod 3.
import 'package:riverpod/misc.dart' show Override;

/// A repository with no delay and optional failure, for tests.
class FakeEventsRepository implements EventsRepository {
  FakeEventsRepository({List<Event>? events, this.fail = false})
      : events = events ?? sampleEvents;

  final List<Event> events;
  final bool fail;

  @override
  Future<List<Event>> fetchAll() async {
    if (fail) throw Exception('network down');
    return events;
  }

  @override
  Future<Event?> fetchById(String id) async {
    if (fail) throw Exception('network down');
    return events.where((e) => e.id == id).firstOrNull;
  }
}

/// A clock before every sample event, so all of them are "upcoming".
final testClock = DateTime(2026, 1, 1);

/// Pumps the whole app with fast fakes. Extra [overrides] win over the
/// defaults here because they come later in the list.
Future<void> pumpApp(
  WidgetTester tester, {
  String initialLocation = Routes.events,
  List<Override> overrides = const [],
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        routerProvider.overrideWithValue(
          createRouter(initialLocation: initialLocation),
        ),
        eventsRepositoryProvider.overrideWithValue(FakeEventsRepository()),
        nowProvider.overrideWithValue(testClock),
        ...overrides,
      ],
      child: const CampusCompanionApp(),
    ),
  );
  await tester.pumpAndSettle();
}
