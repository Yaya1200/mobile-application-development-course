# Lab 2 — Models, state and the lifecycle

**Starter:** `lab/starter/` (last week's solution without the exercises) ·
**Solution:** `lab/solution/` appears in the repository after the lab week

## Goal

Campus Companion gets its first data model and its first stateful screen.
You write one widget test before the code, predict every lifecycle
callback before you see it in the console, and write Dart classes and
futures that pass their tests.

## How this lab works

- **AI-use level.** Under each task heading you find its level (see
  `syllabus/policies.md`): **0** No AI, **1** Explain only, **2** Review,
  **3** Draft and verify. The Dart exercises and the test you write first
  are level 0: they train the skills that the mid exam checks without an
  assistant.
- **Checkpoints.** Two checkpoints are signed by a TA (**Checkpoint A** and
  **Checkpoint B**). Steps called **Self-check** are for you and your
  neighbour.
- **Minimum for the checkpoint.** If you are short of time, finish the
  steps marked *Minimum* first.
- **Worked examples.** `lib/exercises/lecture_examples.dart` and
  `lib/exercises/lecture_widgets.dart` hold the examples from the lecture,
  with their tests. Each task is similar to one example, but not the same.
  Read the example, close it, then write your code.
- **Exit task.** The lab ends with a short task on paper, with your laptop
  closed.
- **Stuck?** Read "If you are stuck" near the end of this file before you
  open anything else.

## Setup

```bash
dart tool/start_lab.dart 02 ../mad-labs-UGR-XXXX-YY   # once: copies the starter into your lab repository
cd ../mad-labs-UGR-XXXX-YY/week02
flutter pub get                 # or: flutter pub get --offline
flutter analyze --fatal-infos   # clean before you start
flutter test                    # many tests fail until the lab is done
```

Keep `flutter run -d chrome` (or an emulator) running in a second terminal
throughout; hot reload after each change.

## Tasks

### Task 1 — The `Event` model

**AI-use level:** 1 — Explain only. You may ask an assistant to explain
an error message, not to write the methods.

`lib/models/event.dart` has a complete `Venue` enum and an `Event` class
with a `TODO(lab)` marker.

1. **Read `Venue`.** Without running code, write in `predictions.md` what
   `Venue.online.location` and `Venue.values.length` return. Then compare
   your answers with your neighbour's and explain any difference.
2. Read `test/models/event_test.dart`: it is the contract. Then implement
   `isUpcoming({DateTime? now})`, `copyWith`, `==`, `hashCode` (use
   `Object.hash`) and `toString` in `Event`. The worked example is
   `Assignment` in `lib/exercises/lecture_examples.dart`.
3. Run `flutter test test/models`; the model tests must pass.

**Self-check 1:** explain to your neighbour why `now` is an optional
parameter of `isUpcoming` instead of the method calling `DateTime.now()`
directly.

### Task 2 — The home screen: stateless or stateful? Test first

**AI-use level:** 0 — No AI. You write the test, the decision and the
screen yourself.

**Requirement.** The home screen shows the text `Check-ins today: N`
under the welcome text (style `titleLarge`). A `FloatingActionButton`
with `Icons.add` adds one to `N`. A `SwitchListTile` titled *Show
lifecycle logger* shows `LifecycleLogger(label: 'Check-ins: N')` below
it while the switch is on, and hides it while the switch is off.

1. **Test first (Minimum).** Open `test/screens/home_screen_test.dart`.
   In the place marked `TODO(lab): Task 2`, write a widget test that pumps
   `const MaterialApp(home: HomeScreen())`, taps the
   `FloatingActionButton` three times, pumps one frame and expects the
   text `Check-ins today: 3`. The worked example is the `VoteCounter` test
   in `test/exercises/lecture_widgets_test.dart`. Run
   `flutter test test/screens` and watch your test fail. Keep the failing
   output on screen or take a screenshot: you show it at Checkpoint A.
2. **Decide (Minimum).** Before you change any code, copy this table into
   `lifecycle.md` and fill it in. For each widget, write **Stateless** or
   **Stateful** and one sentence that names the value (or the lack of one)
   that decides it.

   | Widget | Stateless or stateful? | Why |
   |---|---|---|
   | `CampusCompanionApp` (`lib/app.dart`) | | |
   | `HomeScreen` (`lib/screens/home_screen.dart`) | | |
   | `LifecycleLogger` (`lib/widgets/lifecycle_logger.dart`, Task 3) | | |

   You defend this table at Checkpoint A. The rule from the lecture: a
   widget is stateful when it owns a value that changes while it is on
   screen (or a controller or a timer).
3. Build `HomeScreen` so that it meets the requirement, using the kind of
   widget you chose.
4. Run `flutter test test/screens` again. Your test and the given tests
   must pass.

<details><summary>Step-by-step help</summary>

1. Convert `HomeScreen` (`lib/screens/home_screen.dart`) to a
   `StatefulWidget`. The IDE refactoring *Convert to StatefulWidget* does
   the mechanical part.
2. Add `int _checkIns = 0` and `bool _showLogger = false` to the state.
3. Show `'Check-ins today: $_checkIns'` under the welcome text using
   `Theme.of(context).textTheme.titleLarge`.
4. Add a `FloatingActionButton` with `Icons.add` that increments the
   counter **inside** `setState`.
5. Add a `SwitchListTile` titled *Show lifecycle logger* bound to
   `_showLogger`.
6. Below it, using collection-`if`, show
   `LifecycleLogger(label: 'Check-ins: $_checkIns')` only when the switch
   is on.

</details>

Break it and read the result: remove `setState` around the increment, hot
reload, press the FAB. Run your test. Put `setState` back.

### Task 3 — The lifecycle logger

**AI-use level:** 1 — Explain only.

`lib/widgets/lifecycle_logger.dart` is a `StatelessWidget`. Make it a
`StatefulWidget` whose `State`:

- keeps `int _buildCount = 0`;
- overrides `initState`, `didChangeDependencies`, `didUpdateWidget`,
  `build` and `dispose`, each calling
  `debugPrint('[LifecycleLogger] <callbackName>')` (include the label in
  `initState`, and the old and new label in `didUpdateWidget`);
- increments `_buildCount` in `build` and returns a `Card` with
  `Text('${widget.label} — built $_buildCount time(s)')`.

Remember `super.initState()` first, `super.dispose()` last. The worked
example is `TickCounter` in `lib/exercises/lecture_widgets.dart`.
Run `flutter test test/widgets`.

**Predict, then run (Minimum).** Before you run the app, copy this table
into `lifecycle.md` and fill in the **Prediction** column for all four
rows. Write the callbacks in order and the text the card shows.

| Step | Prediction (callbacks in order; card text) | Console output | Same? |
|---|---|---|---|
| 1. Turn the switch on | | | |
| 2. Press the FAB three times | | | |
| 3. Turn the switch off | | | |
| 4. Turn the switch on again | | | |

Now run the app, do each step while you watch the console, and fill in
the other two columns. Do not change a prediction after you have run the
step.

**Checkpoint A (TA, Minimum: Task 2 steps 1 and 2, and Task 3):** show
your failing test from Task 2 and then the passing `test/screens`, your
stateless-or-stateful table and your prediction table. The TA points at
one widget in the first table and asks you to defend your choice: *what
would go wrong if this widget were the other kind?* Then the TA picks one
row where your prediction was wrong (or, if all were right, the row for
step 4) and asks you to explain it. For example: *why did the build
counter reset in step 4 but not in step 2?*

### Task 4 — Dart II exercises

**AI-use level:** 0 — No AI. These exercises train the Dart you need in
the mid exam. Use the lecture notes, the Dart documentation and DartPad,
not an assistant.

Open `lib/exercises/dart_classes.dart`. Each section has a comment that
describes the contract, and `test/exercises/dart_classes_test.dart` is the
authority. Each exercise is similar to one worked example in
`lib/exercises/lecture_examples.dart` (`Student` ↔ `Course`, `Shape` ↔
`Payment`, `Stack` ↔ `Pair`, `Wallet` ↔ `BookShelf`, greetings ↔
forecasts), but not the same.

1. **Core (Minimum):** Exercises 1 (Student), 2 (sealed shapes), 4
   (`Stack<T>`), 6 (Wallet) and 7 (Futures). Suggested order: 1, 4, 2, 6,
   7.
2. **Extra task:** Exercises 3 (mixins) and 5 (extension methods). Their
   tests stay in the file; they may fail until you do these exercises.

Run:

```bash
flutter test test/exercises/dart_classes_test.dart
```

Do not change the given tests.

Hint for Exercise 2: change `abstract class Shape` to `sealed class
Shape`; the `area` switch then *must* cover every subtype. Is a `Square`
a `Rectangle`? For Exercise 7, see "If you are stuck".

**Checkpoint B (TA, Minimum: Exercises 1, 2, 4, 6 and 7):** show the
passing tests of the core exercises. The TA reads your AI note and asks
one question, for example *explain your `fetchAllGreetings`: what would
change if you awaited each greeting in a `for` loop?* or *what happens
in `area` if you delete the `Rectangle` case?*

### Task 5 — Extra task: simulated loading

**AI-use level:** 1 — Explain only.

Add a `bool _loading` to `HomeScreen`. In `initState`, start a
`Future.delayed(const Duration(seconds: 2))`, and when it completes set
`_loading = false` inside `setState` — guarded by `if (!mounted) return;`.
While loading, show a `CircularProgressIndicator` instead of the counter.
Write a widget test that uses `tester.pump(const Duration(seconds: 2))`.
Check that your own Task 2 test still passes; change it only if the
screen now needs time before the FAB counts.

## If you are stuck

Try each level in order, and stop as soon as you can continue.

**Task 1 — `==` and `hashCode`**
1. *Question:* which fields must be equal for two events to be the same
   event?
2. *Steps:* (1) `other is Event`; (2) compare each field with `==`,
   joined by `&&`; (3) `hashCode` returns `Object.hash` of the same
   fields.
3. *Look at:* `Assignment` in `lecture_examples.dart` has the same shape
   with four fields. `Event` has six.

**Task 2 — the test**
1. *Question:* which `WidgetTester` method presses a widget, and which one
   lets `build()` run afterwards?
2. *Steps:* (1) `pumpWidget`; (2) find the FAB by its type; (3) tap it
   three times; (4) `pump`; (5) `expect` with `find.text` and
   `findsOneWidget`.
3. *Completion:* fill in the two blanks.
   ```dart
   testWidgets('three taps on the FAB show three check-ins', (tester) async {
     await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
     for (var i = 0; i < 3; i++) {
       ________________;
     }
     await tester.pump();
     ________________;
   });
   ```

**Task 3 — `didUpdateWidget`**
1. *Question:* inside `didUpdateWidget`, where is the old label and where
   is the new one?
2. *Steps:* (1) override the method with the parameter
   `LifecycleLogger oldWidget`; (2) call the `super` method first; (3)
   print both labels.
3. *Completion:* fill in the two blanks.
   ```dart
   @override
   void didUpdateWidget(LifecycleLogger oldWidget) {
     ________________;
     debugPrint('[LifecycleLogger] didUpdateWidget (________ → ${widget.label})');
   }
   ```

**Exercise 7 — `fetchAllGreetings`**
1. *Question:* `fetchTwoForecasts` gives `Future.wait` a list of two
   futures. How can you get one future per name, for any number of names?
2. *Steps:* (1) turn each name into a future with `fetchGreeting`, without
   `await`; (2) give all the futures to `Future.wait`; (3) return the
   result. The order of the results is the order of the futures.
3. *Completion:* fill in the two blanks.
   ```dart
   Future<List<String>> fetchAllGreetings(List<String> names) {
     final futures = ________________;
     return ________________;
   }
   ```

## Exit task

At the end of the lab, close your laptop. The TA gives you one short
question on paper. It is like the tasks in this lab but not the same. You
have until the TA collects the papers. It is worth 2 of the 10 points and
shows you, and the instructor, what you can do without help.

## Rubric (10 points)

The TA records a level for each checkpoint and writes one "Next step" line
for you.

| What is checked | Not yet | Working | Can explain and change it |
|---|---|---|---|
| **Checkpoint A** — `Event` model tests pass; stateless-or-stateful choice for each widget defended with the value that decides it; `HomeScreen` meets the requirement and `test/screens` passes; `LifecycleLogger` works; prediction table filled in before running, one wrong prediction explained | 0 | 2 | 3 |
| **Checkpoint B** — core exercise tests pass; analyser clean; AI note | 0 | 2 | 3 |
| **Test written first and seen failing (show the TA)** — the Task 2 test for three taps | 0 | 1 | 2 |
| **Exit task** (marked 0–2 by the TA from the key) | | | |

*Next step (written by the TA):* ______________________________

## AI note

Add a file `AI_NOTE.md` with three lines. The TA reads it at Checkpoint B.

1. Which task did you use an assistant for (or "none")?
2. What did it get wrong, or what did you not understand?
3. What did you check yourself, and how?

## Submit

Lab work is individual. Push your lab work, `predictions.md`,
`lifecycle.md` and `AI_NOTE.md` to `week02/` of your lab repository by
the start of the next lab. Groups of four must be registered by the end
of week 2: a `project.yaml` in the group's repository and its link in
the registration form (see "Registration and submission" in
`project/README.md`).

Make at least one commit for each required task, with the week and the
task in the message, for example `feat(week02): task 2 <what changed>`,
and push. Before the deadline, run `dart tool/check_lab_commits.dart
../mad-labs-UGR-XXXX-YY 02` from the root of the course repository. Your
work is collected from GitHub at the start of the next lab. A required
task without a commit costs 1 of the 10 rubric points (see
`guides/lab-repository.md`).
