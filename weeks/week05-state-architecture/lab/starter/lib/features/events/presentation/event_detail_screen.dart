import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/events_providers.dart';
import '../domain/event.dart';

/// Full-screen detail for one event, loaded by id through a family
/// provider so a deep link works even before the feed has loaded.
class EventDetailScreen extends ConsumerWidget {
  const EventDetailScreen({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventProvider(eventId));

    return eventAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Could not load event: $error')),
      ),
      data: (event) => event == null
          ? Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text('Event not found')),
            )
          : _EventDetail(event: event),
    );
  }
}

class _EventDetail extends StatelessWidget {
  const _EventDetail({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(event.title, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule),
            title: Text('${event.start}'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.place),
            title: Text(event.venue.label),
            subtitle: Text(event.venue.location),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.confirmation_number),
            title: Text(event.isFree ? 'Free' : 'Paid'),
          ),
          if (event.description.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(event.description, style: theme.textTheme.bodyLarge),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registered for ${event.title}')),
          );
        },
        icon: const Icon(Icons.how_to_reg),
        label: const Text('Register'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(
              tooltip: 'Share',
              icon: const Icon(Icons.share),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Add to calendar',
              icon: const Icon(Icons.calendar_month),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Bookmark',
              icon: const Icon(Icons.bookmark_border),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
