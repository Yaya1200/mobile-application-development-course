# Week 5 quiz — self-check

Answer on paper, without running code and before you open the answers or
any tool. Then open each answer to check. Item 11 is marked as an
exam-style question: it has the form of Part B of the mid exam
(`syllabus/exams.md`).

**1.** Classify each as ephemeral or app state: (a) the text in a search
box, (b) the list of notes, (c) which tab is selected, (d) the signed-in
user.

<details><summary>Answer</summary>
(a) ephemeral, (b) app, (c) ephemeral, (d) app.
</details>

**2.** What is the difference between `ref.watch` and `ref.read`, and
where does each belong?

<details><summary>Answer</summary>
`watch` subscribes and rebuilds the widget (or recomputes the provider)
when the value changes — use it in `build` and in provider bodies. `read`
gets the current value once with no subscription — use it in callbacks
and `initState`.
</details>

**3.** Find the error:
```dart
void add(Note note) {
  state.add(note);
}
```

<details><summary>Answer</summary>
Mutates the existing list; `state` is still the same object so Riverpod
does not notify anyone. Assign a new list: `state = [...state, note]`.
</details>

**4.** What three cases does `AsyncValue.when` require you to handle?

<details><summary>Answer</summary>
`loading`, `error` (with error and stack trace) and `data`.
</details>

**5.** Why does `EventsScreen` depend on `eventsRepositoryProvider`
instead of constructing `InMemoryEventsRepository()` itself?

<details><summary>Answer</summary>
So the implementation can be swapped — a REST repository in week 9, a
fake in tests — without changing the screen. Tests override the provider
in a `ProviderScope`.
</details>

**6.** Which layer may import `package:flutter/material.dart`: domain,
data or presentation?

<details><summary>Answer</summary>
Presentation only. Domain is pure Dart; data may import Riverpod and I/O
packages but has no widgets.
</details>

**7.** What does `freezed` generate for
```dart
@freezed
abstract class Profile with _$Profile {
  const factory Profile({required String name, @Default(3) int year}) = _Profile;
}
```

<details><summary>Answer</summary>
The `_Profile` implementation with a const constructor, `copyWith`, `==`,
`hashCode` and `toString` (and, with `fromJson` declared, JSON
serialisation).
</details>

**8.** What is a provider *family* and how do you read one?

<details><summary>Answer</summary>
A provider that takes a parameter, giving one cached instance per
distinct argument: `ref.watch(noteByIdProvider('n3'))`.
</details>

**9.** After editing a `@riverpod` function, the analyser reports
"undefined name `fooProvider`". What did you forget?

<details><summary>Answer</summary>
Running the code generator: `dart run build_runner build -d` (or keeping
`watch` running).
</details>

**10.** A widget watches `profileProvider` but only displays the name.
Editing the programme also rebuilds it. How do you avoid that?

<details><summary>Answer</summary>
`ref.watch(profileProvider.select((p) => p.name))` — rebuilds only when
the selected value changes.
</details>

**11.** *(Exam-style question.)* What does this print? The providers are
the ones in `lecture_reminders.dart`: `add` gives the ids `r1`, `r2`, …,
and `openReminders` keeps the reminders that are not done, soonest first.

```dart
final c = ProviderContainer.test();
final r = c.read(remindersProvider.notifier);
final a = r.add('A', due: DateTime(2026, 3, 5));
r.add('B', due: DateTime(2026, 3, 1));
r.markDone(a.id);
print(c.read(remindersProvider).length);
print(c.read(openRemindersProvider).map((x) => x.text).toList());
print(a.done);
print(c.read(reminderByIdProvider('r1'))!.done);
```

<details><summary>Answer</summary>

```text
2
[B]
false
true
```

`markDone` does not remove a reminder, so there are still two. `A` is
done, so only `B` is open. `a` is the object that `add` returned: it is
immutable, so it still says `false`; `markDone` put a *new* `Reminder`
with `done: true` into the state, and `reminderById('r1')` finds that new
one.
</details>

**12.** Trace the rebuilds. The notes app has three widgets: A watches
`notesProvider`, B watches `sortedNotesProvider`, and C watches
`noteByIdProvider('n1')`. The notes `n1` and `n2` exist. Then this runs:

```dart
ref.read(notesProvider.notifier).togglePinned('n2');
```

Which of A, B and C rebuild? Give the reason for each.

<details><summary>Answer</summary>
A rebuilds: `togglePinned` assigns a new list to `notesProvider`. B
rebuilds: `sortedNotes` watches `notesProvider`, is computed again, and
its result changed (`n2` is now pinned, and the order may change). C does
**not** rebuild: `noteById('n1')` is computed again, but it returns a
`Note` equal (`==`) to the old one, because `freezed` gives value
equality, and Riverpod notifies only when the value is not equal to the
old one.
</details>

**13.** In `notes_notifier.dart`, the class is written
`class Notes extends _$Notes`. Where is `_$Notes` defined, and what does
it give the class? What connects the two files?

<details><summary>Answer</summary>
In the generated file `notes_notifier.g.dart`, written by `build_runner`.
It is the base class that gives `Notes` its `state` and `ref` and the
code that runs `build()` when the provider is first used. The line
`part 'notes_notifier.g.dart';` makes the generated file part of the same
library, so it can use the private name `_$Notes` and the class `Notes`.
</details>

**14.** Evaluate this test. It is meant to check `togglePinned`.

```dart
test('togglePinned works', () {
  final c = ProviderContainer.test();
  final notes = c.read(notesProvider.notifier);
  final a = notes.add(title: 'A', body: '');
  notes.togglePinned(a.id);
  expect(c.read(notesProvider), hasLength(1));
});
```

Name two wrong versions of `togglePinned` that this test does not detect,
and write the `expect` lines that would detect them.

<details><summary>Answer</summary>
It only checks that one note is still there. It passes when
`togglePinned` does nothing, and when it always sets `isPinned` to `true`
(it is called once). Better:

```dart
notes.togglePinned(a.id);
expect(c.read(noteByIdProvider(a.id))!.isPinned, isTrue);
notes.togglePinned(a.id);
expect(c.read(noteByIdProvider(a.id))!.isPinned, isFalse);
```
</details>

**15.** Put these lines in order to make a widget that shows the profile
name and rebuilds only when the name changes. Two lines are not needed.

```text
A   class ProfileName extends ConsumerWidget {
B     const ProfileName({super.key});
C     @override
D     Widget build(BuildContext context, WidgetRef ref) {
E       final name = ref.watch(profileProvider.select((p) => p.name));
F       return Text(name);
G     }
H   }
I       final name = ref.read(profileProvider).name;
J     Widget build(BuildContext context) {
```

<details><summary>Answer</summary>
A, B, C, D, E, F, G, H. Line I is wrong: `ref.read` in `build` does not
subscribe, so the text never changes. Line J is wrong: a
`ConsumerWidget`'s `build` also takes a `WidgetRef ref`.
</details>

**16.** `EventCard` calls `Theme.of(context)`. (a) Which widget does
this call find, and which widget created it? (b) Your project team
chooses BLoC instead of Riverpod. Name two ideas from this week that you
keep.

<details><summary>Answer</summary>
(a) The nearest `Theme` above the card, an inherited widget that
`MaterialApp` (here `MaterialApp.router` in `app.dart`) builds from its
`theme:`. When that theme changes, the widgets that called `Theme.of`
rebuild. (b) Any two of: app state lives above the widgets that use it;
state is immutable and replaced, not changed in place; data flows in one
direction (events or method calls go up, new state comes down); the UI
is separated from the data layer and depends on interfaces, so tests can
replace it.
</details>

## Questions from earlier weeks

**17.** (From week 2) `NoteEditorScreen` is a `ConsumerStatefulWidget`.
In which lifecycle method are the text controllers created, and in which
are they disposed? Why not in `build`?

<details><summary>Answer</summary>
Created in `initState` and disposed in `dispose`. `build` can run many
times; creating controllers there would make a new controller (and lose
the text) on every rebuild, and the old ones would never be disposed.
</details>

**18.** (From week 1) `add` creates ids with `'n${_nextId++}'`, and
`_nextId` starts at 1. What are the ids of the first two notes, and what
is `_nextId` after them? What would they be with `'n${++_nextId}'`?

<details><summary>Answer</summary>
`n1` and `n2`, and `_nextId` is then 3: `_nextId++` uses the old value,
then adds one. With `++_nextId` the value is increased first, so the ids
are `n2` and `n3` (and `_nextId` is also 3).
</details>
