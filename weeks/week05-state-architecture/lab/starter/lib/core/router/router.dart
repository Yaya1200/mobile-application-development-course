import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/check_in/presentation/check_in_screen.dart';
import '../../features/events/presentation/event_detail_screen.dart';
import '../../features/events/presentation/events_screen.dart';
import '../../features/lost_found/presentation/lost_found_screen.dart';
import '../../features/notes/presentation/note_editor_screen.dart';
import '../../features/notes/presentation/notes_screen.dart';
import '../../features/profile/presentation/edit_profile_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../presentation/about_screen.dart';
import 'app_shell.dart';

part 'router.g.dart';

/// Route paths in one place so screens never hard-code strings twice.
abstract final class Routes {
  static const events = '/events';
  static const eventDetail = '/events/:id';
  static const notes = '/notes';
  static const newNote = '/notes/new';
  static const noteDetail = '/notes/:id';
  static const lostFound = '/lost-found';
  static const profile = '/profile';
  static const editProfile = '/profile/edit';
  static const checkIn = '/check-in';
  static const about = '/about';

  static String eventDetailFor(String id) => '/events/$id';
  static String noteFor(String id) => '/notes/$id';
}

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// The router as a provider: screens can be given providers, and tests can
/// override the initial location.
@riverpod
GoRouter router(Ref ref) => createRouter();

GoRouter createRouter({String initialLocation = Routes.events}) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialLocation,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.events,
                builder: (context, state) => const EventsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) =>
                        EventDetailScreen(eventId: state.pathParameters['id']!),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.notes,
                builder: (context, state) => const NotesScreen(),
                routes: [
                  // Order matters: 'new' must come before ':id' or "new"
                  // would be captured as an id.
                  GoRoute(
                    path: 'new',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const NoteEditorScreen(),
                  ),
                  GoRoute(
                    path: ':id',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) =>
                        NoteEditorScreen(noteId: state.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.lostFound,
                builder: (context, state) => const LostFoundScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile,
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'edit',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => EditProfileScreen(
                      initialName: state.uri.queryParameters['name'] ?? '',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Routes.checkIn,
        builder: (context, state) => const CheckInScreen(),
      ),
      GoRoute(
        path: Routes.about,
        builder: (context, state) => const AboutScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Not found')),
      body: Center(child: Text('No route for ${state.uri}')),
    ),
  );
}
