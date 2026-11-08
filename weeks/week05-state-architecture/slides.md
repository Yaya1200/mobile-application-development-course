---
marp: true
theme: course
title: "Week 5 — State management and app architecture"
paginate: true
footer: "Mobile Applications Development · Week 5 · Betsegaw Lemma · AAU"
---

<!-- _class: lead -->
<!-- _paginate: false -->

# State management and app architecture

Week 5 · Mobile Applications Development
B.Sc. Computer Science · Addis Ababa University

---

## Lecture topics

1. The problem: state that many widgets share
2. The options: Provider, Riverpod, BLoC
3. Riverpod: providers, notifiers, AsyncValue, overrides
4. Feature-first architecture, layers, freezed
5. Lab preview

---

<!-- _class: lead -->

# 1 · The problem

---

## Two kinds of state

| Ephemeral (UI) state | App state |
|---|---|
| a text field's contents | the signed-in user |
| selected tab, switch on/off | the notes list |
| animation progress | cached server data |
| **one widget cares** | **many widgets, across screens, over time** |
| `setState` — keep it | must live **above** the widgets |

---

## The problem in Campus Companion

```dart
// week 4: lib/screens/profile_screen.dart
class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'Sara Bekele';   // no other widget can read this
  …
}
```

- The drawer, the app bar, a greeting on Events — none can show the name
- Switch tabs and come back: still there. Restart the app: gone
- Notes have the same problem: list, editor, and (week 8) database all need one list

---

## Passing state through every widget

```
Root(notes)
 └── Shell(notes)
      └── NotesTab(notes)
           └── NotesList(notes)
                └── NoteTile(note)
```

Every widget passes something it does not use.
Add one field ⇒ change ten files.
(This problem is often called "prop drilling".)

---

## InheritedWidget: Flutter's built-in answer

- A widget high in the tree that any descendant can look up via `context`
- You have used it since week 3: `Theme.of(context)`, `MediaQuery.of(context)`
- Descendants that call `of(context)` rebuild when the data changes

Raw `InheritedWidget` is verbose and says nothing about **where to mutate**.
The packages package the pattern.

---

<!-- _class: lead -->

# 2 · The options

---

## Provider · Riverpod · BLoC

| | Provider | **Riverpod** | BLoC / Cubit |
|---|---|---|---|
| idea | InheritedWidget + ChangeNotifier | global providers, resolved by `ref` | events → states via streams |
| repetitive code | low | low (code generation) | high |
| safety | runtime errors | compile-time, no context | good |
| async | limited | `AsyncValue` built in | via states |
| testing | good | excellent (overrides) | excellent |
| where | older code | new apps, Flutter documentation | enterprise, job advertisements |

**This course: Riverpod.** The concepts apply to BLoC as well. See `guides/state-management-comparison.md`.

---

<!-- _class: lead -->

# 3 · Riverpod

---

## Setup

```dart
// lab/solution/lib/main.dart
void main() {
  runApp(const ProviderScope(child: CampusCompanionApp()));
}
```

`ProviderScope` **stores** every provider's state. One at the root.

---

## A provider without the generator (read only)

```dart
// lab/starter/lib/exercises/lecture_check_in_by_hand.dart
class CheckInCounter extends Notifier<int> {
  @override
  int build() => 0;                    // first state

  void checkIn() => state = state + 1; // assign a new state
  void reset() => state = 0;
}

final checkInCounterProvider =
    NotifierProvider.autoDispose<CheckInCounter, int>(CheckInCounter.new);
```

- **notifier**: the state and the methods that change it
- **provider**: the global name widgets and tests use to find it
- **The generator writes this line for you.**

---

## The same provider with the generator

```dart
// lab/starter/lib/exercises/lecture_check_in.dart
part 'lecture_check_in.g.dart';

@riverpod
class CheckInCounter extends _$CheckInCounter {
  @override
  int build() => 0;

  void checkIn() => state = state + 1;
  void reset() => state = 0;
}
```

`dart run build_runner watch -d` ⇒ `lecture_check_in.g.dart` with
`checkInCounterProvider` and the base class `_$CheckInCounter`.
`part` joins the two files into one library. Never edit a `.g.dart` file.

---

## A provider computes a value

```dart
// lab/solution/lib/features/events/data/events_repository.dart
@riverpod
EventsRepository eventsRepository(Ref ref) => InMemoryEventsRepository();
```

Generates `eventsRepositoryProvider`:

- **lazy** — created on first use
- **cached** — one instance while watched
- **overridable** — tests swap in a fake

---

## Reading from widgets

```dart
// lab/starter/lib/exercises/lecture_check_in.dart
class CheckInPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(checkInCounterProvider);         // subscribe
    …
    onPressed: () =>
        ref.read(checkInCounterProvider.notifier).checkIn(), // one-off
```

| | where | effect |
|---|---|---|
| `ref.watch(p)` | `build` | rebuild when `p` changes |
| `ref.read(p)` | callbacks, `initState` | read once |
| `ref.listen(p, cb)` | `build` | side effects (snackbar) |
| `ref.invalidate(p)` | anywhere | drop cache, recompute |

---

<!-- _class: pause -->

## What goes wrong?

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final open = ref.read(openRemindersProvider);
  return ListView(children: [for (final r in open) Text(r.text)]);
}
```

The user adds a reminder. What does the list show?

---

## Notifier: state + the methods that change it

```dart
// lab/starter/lib/exercises/lecture_reminders.dart
@riverpod
class Reminders extends _$Reminders {
  int _nextId = 1;

  @override
  List<Reminder> build() => const [];              // initial state

  Reminder add(String text, {required DateTime due}) {
    final reminder = Reminder(id: 'r${_nextId++}', text: text, due: due);
    state = List.unmodifiable([...state, reminder]); // ASSIGN a new list
    return reminder;
  }

  void markDone(String id) {
    state = List.unmodifiable([
      for (final r in state)
        if (r.id == id) r.copyWith(done: true) else r,
    ]);
  }
}
```

---

## Assign, never mutate

```dart
state.add(reminder);        // ✗ same list object ⇒ nothing rebuilds
                            //   (throws here: the list is unmodifiable)

state = [...state, reminder];   // ✓ new object ⇒ watchers notified
```

Riverpod compares old and new with `==`. That is why:

- models are **immutable** (`copyWith`)
- lists are rebuilt with **collection literals**

Naming: `class Reminders` ⇒ `remindersProvider` · `class ProfileNotifier` ⇒ `profileProvider`

---

## Derived state and families

```dart
// lab/starter/lib/exercises/lecture_reminders.dart
@riverpod
List<Reminder> openReminders(Ref ref) {
  final open = ref.watch(remindersProvider).where((r) => !r.done).toList();
  open.sort((a, b) => a.due.compareTo(b.due));   // sorts the copy
  return open;
}

@riverpod                                        // a family
Reminder? reminderById(Ref ref, String id) {
  return ref.watch(remindersProvider).where((r) => r.id == id).firstOrNull;
}

// ref.watch(reminderByIdProvider('r3'))
```

Providers watch providers. Logic lives here, testable without widgets.

---

## Async providers

```dart
// lab/solution/lib/features/events/data/events_providers.dart
@riverpod
Future<List<Event>> events(Ref ref) {
  return ref.watch(eventsRepositoryProvider).fetchAll();
}
```

Watching it gives an **`AsyncValue<List<Event>>`**:

```
AsyncValue<T>  =  AsyncLoading | AsyncData(value) | AsyncError(error, stack)
```

A sealed type. You **must** handle all three.

---

## AsyncValue.when

```dart
// lab/solution/lib/features/events/presentation/events_screen.dart
final eventsAsync = ref.watch(eventsProvider);

return eventsAsync.when(
  loading: () => const Center(child: CircularProgressIndicator()),
  error: (error, stack) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
    Text('Could not load events: $error'),
    FilledButton(onPressed: () => ref.invalidate(eventsProvider),
                 child: const Text('Retry')),
  ])),
  data: (events) => /* tabs and lists */,
);
```

No `isLoading` booleans you forget to reset. Week 9: swap the repo for REST — **this file does not change**.

---

## Overrides: replacing providers in tests

```dart
// lab/solution/test/helpers.dart
ProviderScope(
  overrides: [
    routerProvider.overrideWithValue(createRouter(initialLocation: initialLocation)),
    eventsRepositoryProvider.overrideWithValue(FakeEventsRepository()),
    nowProvider.overrideWithValue(testClock),
  ],
  child: const CampusCompanionApp(),
)
```

Fake repo, no delay · fixed clock · start at any route.
Screens depend on **providers**, not concrete classes ⇒ replaceable.

---

## An override gives a test known data

```dart
// lab/starter/test/exercises/lecture_reminders_test.dart
await tester.pumpWidget(
  ProviderScope(
    overrides: [
      remindersProvider.overrideWithValue([
        Reminder(id: 'x', text: 'Second', due: DateTime(2026, 3, 2)),
        Reminder(id: 'y', text: 'First', due: DateTime(2026, 3, 1)),
      ]),
    ],
    child: const RemindersApp(),
  ),
);
```

The page starts with these two reminders. The test then checks their order.

---

## Unit-testing a notifier — no widgets

```dart
// lab/starter/test/exercises/lecture_reminders_test.dart
container = ProviderContainer.test();
reminders = container.read(remindersProvider.notifier);

final r = reminders.add('Return books', due: DateTime(2026, 3, 2));

expect(r.id, 'r1');
expect(container.read(remindersProvider), [r]);
```

`ProviderContainer` = a `ProviderScope` without widgets. Fast, precise.

---

<!-- _class: pause -->

## Which widgets rebuild?

```dart
// lecture_reminders.dart; r1 and r2 exist, neither is done
// A watches remindersProvider
// B watches openRemindersProvider
// C watches reminderByIdProvider('r1')
ref.read(remindersProvider.notifier).markDone('r2');
```

---

<!-- _class: lead -->

# 4 · Feature-first architecture

---

## From type folders to feature folders

```
lib/screens/  lib/widgets/  lib/models/           ← works for 5 files

lib/
├── core/         router/  theme/  presentation/   ← shared
└── features/
    ├── events/   domain/  data/  presentation/
    ├── notes/    domain/  data/  presentation/
    ├── profile/  domain/  data/  presentation/
    └── …
```

Everything about **notes** is in one folder. To delete a feature, delete its folder.

---

## Three layers, one rule

```
presentation  ──►  data  ──►  domain
 widgets,          providers,      models,
 ref.watch         notifiers,      business rules,
                   repositories    pure Dart
```

Dependencies point **inward**. Never the reverse.

- domain imports Flutter ⇒ warning sign
- presentation constructs a repository ⇒ warning sign

---

## Repositories: the screen never knows where data comes from

```dart
// lab/solution/lib/features/events/data/events_repository.dart
abstract interface class EventsRepository {
  Future<List<Event>> fetchAll();
  Future<Event?> fetchById(String id);
}

class InMemoryEventsRepository implements EventsRepository { … }   // now
// week 9:  class RestEventsRepository implements EventsRepository
// week 10: class FirestoreLostFoundRepository implements …
```

Swap the implementation in **one provider**. UI untouched. Tests use a fake.

---

## freezed: generated model code

```dart
// lab/solution/lib/features/events/domain/event.dart
@freezed
abstract class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    required DateTime start,
    required Venue venue,
    @Default('') String description,
    @Default(true) bool isFree,
  }) = _Event;

  const Event._();                       // enables methods below
  bool isUpcoming({DateTime? now}) => start.isAfter(now ?? DateTime.now());
}
```

`part 'event.freezed.dart';` + `build_runner` ⇒ constructor, `copyWith`, `==`, `hashCode`, `toString`.
Week 8: `fromJson` with one more line.

---

## Lab topics

0. Read the folder structure and the generated provider (`notes_notifier.g.dart`)
1. Implement `NotesNotifier` against its tests
2. Connect `NotesScreen` and the editor to the providers
3. Profile on `profileProvider` — write the override test first
4. Your own design: bookmarks that three widgets share
5. Extra tasks: search; run the generator yourself

Checkpoint A after Task 2, Checkpoint B after Task 4 (lab numbering).
The lab ends with a short exit task on paper.

---

## Before the next lecture

- Read *Testing Flutter apps* overview (docs.flutter.dev/testing)
- Nothing new to install — `mocktail` is added through `pubspec.yaml`
- **Milestone 1** is due after week 6: screens + navigation + Riverpod + tests

---

<!-- _class: lead -->
<!-- _paginate: false -->

# Questions?

Notes, lab and quiz: github.com/betsegawlemma/mobile-application-development-course
