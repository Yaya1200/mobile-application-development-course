# Campus Companion

The running example app for *Mobile Applications Development*. Every lab
modifies this app; this folder always holds the state at the end of the most
recently published week.

## Features and when they arrive

| Feature | Week introduced | Data source |
|---|---|---|
| App shell, theme, home | 1–2 | — |
| Events feed (static) | 3 | in-memory |
| Navigation shell (bottom nav, drawer, tabs) | 4 | — |
| Notes (Riverpod, feature-first) | 5 | in-memory → drift (week 8) |
| Events feed (live) | 9 | REST backend in `backend/` (repository root) |
| Lost & found | 10 | Firebase Auth + Cloud Firestore |
| Photo, location, shake-to-refresh | 11 | device sensors, Firebase Storage |
| AI note summary | 13 | provider-agnostic interface with offline stub |
| Profile, settings, Amharic locale, release build | 14 | shared_preferences |

## Run

```bash
flutter --version      # expect 3.47.7
flutter pub get
flutter run -d chrome  # or an Android emulator / device
flutter test
flutter analyze --fatal-infos
```

## Current state

**End of week 4** — `go_router` with a four-branch bottom-navigation shell (Events, Notes, Lost & found, Profile), drawer (Check-in, About), deep-linkable event detail route with `BottomAppBar` and docked FAB, edit-profile route returning a result, Upcoming/Past tabs on the feed.
