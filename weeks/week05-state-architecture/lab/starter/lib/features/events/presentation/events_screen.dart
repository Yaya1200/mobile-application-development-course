import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/router.dart';
import '../data/events_providers.dart';
import '../domain/event.dart';
import 'event_card.dart';

/// The events feed. A ConsumerWidget: `ref.watch` subscribes to providers
/// and rebuilds this widget when they change.
class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  static const wideBreakpoint = 600.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsProvider);
    final now = ref.watch(nowProvider);

    // AsyncValue.when forces you to handle all three states.
    return eventsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Could not load events: $error'),
            const SizedBox(height: 8),
            FilledButton(
              // invalidate drops the cached value; the next watch refetches.
              onPressed: () => ref.invalidate(eventsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (events) {
        final upcoming = events.where((e) => e.isUpcoming(now: now)).toList();
        final past = events.where((e) => !e.isUpcoming(now: now)).toList();
        return DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Past'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _EventList(
                      events: upcoming,
                      emptyText: 'No upcoming events',
                    ),
                    _EventList(events: past, emptyText: 'No past events'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EventList extends StatelessWidget {
  const _EventList({required this.events, required this.emptyText});

  final List<Event> events;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Center(child: Text(emptyText));
    }

    Widget item(BuildContext context, int index) {
      final event = events[index];
      return EventCard(
        event: event,
        onTap: () => context.push(Routes.eventDetailFor(event.id)),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= EventsScreen.wideBreakpoint) {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 480,
              mainAxisExtent: 200,
            ),
            itemCount: events.length,
            itemBuilder: item,
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: events.length,
          itemBuilder: item,
        );
      },
    );
  }
}
