# Lab 5 — Riverpod and feature-first

**Starter:** `lab/starter/` (last week's solution, reorganised feature-first, with `TODO(lab)` markers) ·
**Solution:** `lab/solution/` appears in the repository after the lab week

## Goal

Campus Companion is now organised feature-first and uses Riverpod for app
state. You first read the generated code that Riverpod and `freezed`
produce, so that you know what the generator writes for you. Then you
implement the notes notifier against its tests, connect two screens to
providers, move the profile into application state with a test that you
write first, and decide yourself how a small bookmarks app shares its
state.

## How this lab works

- **AI-use level.** Under each task heading you find its level (see
  `syllabus/policies.md`): **0** No AI, **1** Explain only, **2** Review,
  **3** Draft and verify. Most tasks in this lab are level 1: you may ask
  an assistant what an error means or what a class does, but you write
  the providers and the widgets yourself.
- **Checkpoints.** Two checkpoints are signed by a TA (**Checkpoint A** and
  **Checkpoint B**). Steps called **Self-check** are for you and your
  neighbour. At each checkpoint the TA points at one line of your code and
  asks what happens if you remove it or change it. Predict first, then
  try it.
- **Minimum for the checkpoint.** If you are short of time, finish the
  steps marked *Minimum* first.
- **Worked examples.** `lib/exercises/lecture_reminders.dart` is the
  reminders list from the lecture (a notifier, a derived provider, a
  family, a page that watches and reads). `lib/exercises/lecture_check_in.dart`
  is the check-in counter from the live coding, and
  `lib/exercises/lecture_check_in_by_hand.dart` is the same provider
  written without the generator. Each task is similar to one example, but
  not the same. Read the example, close it, then write your code.
- **Interface and tests, not code.** The `TODO(lab)` comments now say
  *what* must be true, not *how*. The doc comments on each method and the
  tests are the specification. If you do not know where to start, open
  the "Step-by-step help" under the task. Try without it first.
- **Exit task.** The lab ends with a short task on paper, with your laptop
  closed.
- **Stuck?** Read "If you are stuck" near the end of this file before you
  open anything else.

## Setup

```bash
dart tool/start_lab.dart 05 ../mad-labs-UGR-XXXX-YY   # once: copies the starter into your lab repository
cd ../mad-labs-UGR-XXXX-YY/week05
flutter pub get                 # or: flutter pub get --offline
flutter analyze --fatal-infos   # clean before you start
flutter test                    # many tests fail until the lab is done
```

**No network?** If `flutter pub get` fails, copy the `pub-cache` folder
from the TA's USB drive and set `PUB_CACHE` to it, as in lab 1, then run
`flutter pub get --offline`.

The generated files (`*.g.dart` and `*.freezed.dart`) are already in the
starter, and the core tasks do not change any annotation, so you can do
them without running the generator. You need the generator when you add
or change an `@riverpod` or `@freezed` annotation (Task 4 if you choose
`@riverpod`, and the Extra tasks). Then start it in a second terminal and
leave it running:

```bash
dart run build_runner watch -d
```

Every time you save such a file, it writes the generated files again.

Already in the starter: the move from `lib/screens` to
`lib/features/*` (the file moves are mechanical and not a good use of lab
time); the complete **events** feature, which is your reference for every
pattern; the `Note` model as a `freezed` class; `profileProvider` in
`profile_notifier.dart`; and the drawer, which already shows the name from
`profileProvider`.

Copy the prediction tables of this lab into one file, `predictions.md`,
and write your Task 0 answers in `answers.md`.

## Tasks

### Task 0 — Read the structure and the generated code

**AI-use level:** 1 — Explain only. Write each answer before you ask
anything or run anything.

Open `lib/` and answer in `answers.md`. Do not change any file in this
task.

1. **Layers (Minimum).** Which files in `features/events/` import
   `package:flutter`? Which do not? Why?
2. **The connection (Minimum).** `EventsScreen` never mentions
   `InMemoryEventsRepository`. Where is the connection made?
3. **Read the generated provider (Minimum).** Open
   `lib/features/notes/data/notes_notifier.g.dart`. Do not change it.
   Answer:
   - (a) Which line declares `notesProvider`?
   - (b) Which class does `Notes` extend, and in which file is that class
     written?
   - (c) What does the `part` line at the top of `notes_notifier.dart`
     connect?
   - (d) What happens if you rename the class `Notes` and do not run
     `build_runner`? Write your prediction in the table, then rename it,
     run `flutter analyze` to check your answer, and rename it back.

   | Step | Prediction | What you saw | Same? |
   |---|---|---|---|
   | d. Rename `class Notes extends _$Notes` to `class NoteList extends _$NoteList`, then run `flutter analyze` | | | |

4. **Read the freezed model.** Open `lib/features/notes/domain/note.dart`
   and `note.freezed.dart`. Which methods does `Note` have that are not
   written in `note.dart`? Find each one in `note.freezed.dart`. Why must
   you never edit `note.freezed.dart`?
5. **Inherited widgets.** `EventCard` calls `Theme.of(context)`.
   - (a) Which widget creates the `Theme` that this call finds? (Start in
     `app.dart`.)
   - (b) Name one other `of(context)` call you used in week 3.
   - (c) In two sentences: how does `ProviderScope` in `main.dart` use the
     same idea, and what does Riverpod add that a plain `InheritedWidget`
     does not have?

**Self-check 1:** compare your answers to 3 (a)–(c) with your neighbour.
Where you disagree, find the line in the file together.

### Task 1 — `NotesNotifier`

**AI-use level:** 1 — Explain only. This task trains the skill that the
exit task and the exams check.

Requirements:

- Implement `add`, `update`, `remove` and `togglePinned` in
  `lib/features/notes/data/notes_notifier.dart`, and the order of
  `sortedNotes`. The doc comment of each method says what it does.
- The contract is `test/features/notes/notes_notifier_test.dart`. Read
  every test before you write any code.
- The state is never changed in place. Every method assigns a new,
  unmodifiable list to `state`.

The worked example is `Reminders` and `openReminders` in
`lib/exercises/lecture_reminders.dart`.

```bash
flutter test test/features/notes/notes_notifier_test.dart
```

<details><summary>Step-by-step help</summary>

1. `add`: build a `Note` with the id `'n${_nextId++}'` and
   `updatedAt: now ?? DateTime.now()`, assign
   `List.unmodifiable([...state, note])` to `state`, return the note.
2. `update` and `togglePinned`: a collection `for` over `state` that
   keeps every note, except the one with the matching id, which is
   replaced by a `copyWith(...)` of it.
3. `remove`: keep the notes whose id is different.
4. `sortedNotes`: copy the list first (`[...ref.watch(notesProvider)]`),
   then `sort` the copy with a comparator: pinned before unpinned; among
   equals, the larger `updatedAt` first.

</details>

**Self-check 2 (Minimum):** all tests in `notes_notifier_test.dart` pass.
Tell your neighbour what the test *state is immutable* protects against.

### Task 2 — Connect the screens

**AI-use level:** 1 — Explain only.

**2a. `NotesScreen` (Minimum).** Requirements:

- The screen shows the notes from `sortedNotesProvider`. When there are
  none, it keeps the existing text.
- Each note is a `ListTile`: the leading icon is `Icons.push_pin` in the
  primary colour when the note is pinned, otherwise `Icons.notes`; the
  title is the note's title, or `(untitled)` when it is blank, on one
  line with an ellipsis; the subtitle is the body, on one line.
- A trailing `IconButton` with the tooltip `Pin` (or `Unpin` when the
  note is pinned) flips the pin.
- Tapping the tile opens `Routes.noteFor(note.id)` with `context.push`.

The worked example is `RemindersPage` in `lecture_reminders.dart`.

**2b. `NoteEditorScreen` (Minimum).** Requirements:

- When the editor opens an existing note, the two text fields start with
  its title and body.
- *Save* adds a new note, or updates the existing one, with the trimmed
  text, then closes the editor.
- *Delete* removes the note, then closes the editor.

```bash
flutter test test/features/notes
```

<details><summary>Step-by-step help</summary>

- 2a: in `build`, `final notes = ref.watch(sortedNotesProvider);`, then
  `notes.isEmpty ? <the text> : ListView.builder(...)`. In the button's
  `onPressed`, call the notifier through `ref.read(notesProvider.notifier)`.
- 2b: in `initState`, read the note **once** with
  `ref.read(noteByIdProvider(widget.noteId!))` when `widget.isNew` is
  false, and pass `text:` to each `TextEditingController`. In `_save`,
  get the notifier with `ref.read(notesProvider.notifier)` and call `add`
  or `update` (with `existing.copyWith(...)`); in `_delete`, call
  `remove`.

</details>

Then run the app (`flutter run -d chrome`) and fill in this table before
you try each step.

| Step | Prediction | What you saw | Same? |
|---|---|---|---|
| a. Add a note, switch to the *Profile* tab, switch back to *Notes*. Is the note there? | | | |
| b. In `NotesScreen`, change `ref.watch(sortedNotesProvider)` to `ref.read(...)`, hot reload, add a note. What does the list show? | | | |

Put `ref.watch` back. In `predictions.md`, answer: why do the notes stay
when you switch tabs, when the week 4 profile name lived in one widget?

**Checkpoint A (TA, Minimum: Task 0 items 1–3, Task 1, Task 2):** show
your Task 0 answers, the passing notes tests and the app: create, pin,
edit, delete. The TA points at one line, for example
`state = List.unmodifiable(...)` in `togglePinned`, or the `ref.read` in
`initState`, and asks *what happens if I change this line to …?* (for
example to `state.add(note)`, or to `ref.watch`). Write your prediction,
then try it. The TA may also ask *where is `_$Notes` written, and what
does it give your class?*

### Task 3 — Profile on a provider, test first

**AI-use level:** 1 — Explain only. You write the test and the screen
yourself.

`ProfileScreen` keeps the name in its own `State`, and the programme and
year are fixed text. `profileProvider` (`profile_notifier.dart`) is given.

1. **Test first (Minimum).** In `test/features/profile/profile_test.dart`,
   in the place marked `TODO(lab): Task 3`, write a widget test:
   - start the app at `Routes.profile` with `pumpApp`, and pass an
     override of `profileProvider` with a profile of your own: a name, a
     programme and a year that are not the defaults;
   - expect the screen to show all three.

   The worked example is the test *an override fills the page with
   known reminders* in `test/exercises/lecture_reminders_test.dart`. The
   programme and year are in a `RichText`, so look at how `find.text`
   can find text in a `RichText`. Run
   `flutter test test/features/profile` and watch your test fail. Keep
   the failing output on screen or take a screenshot: you show it at
   Checkpoint B.
2. **The screen (Minimum).** Requirements:
   - `ProfileScreen` shows the name, the programme and the year from
     `profileProvider`;
   - *Edit profile* still opens the edit page with the current name, and
     a saved name is stored through `profileProvider.notifier`.

   The worked example is `CheckInPage` in `lecture_check_in.dart`.
3. Run `flutter test`. Your test now passes. Then run the app, change
   the name and open the drawer: the header shows the new name, because
   `AppDrawer` already watches `profileProvider`.

<details><summary>Step-by-step help</summary>

1. The override: `profileProvider.overrideWithValue(const Profile(name:
   ..., programme: ..., year: ...))` in the `overrides:` list of
   `pumpApp`.
2. Make `ProfileScreen` a `ConsumerWidget`; in `build`,
   `final profile = ref.watch(profileProvider);` and use `profile.name`,
   `profile.programme` and `profile.year`.
3. `_edit` takes `(BuildContext context, WidgetRef ref)`, reads the name
   once with `ref.read`, and on a non-null result calls
   `ref.read(profileProvider.notifier).setName(result)`.

</details>

### Task 4 — Your own design: bookmarks

**AI-use level:** 1 — Explain only. The decisions are the skill this task
trains, and you defend them at Checkpoint B, so they must be yours. You
may ask an assistant what a class does or what an error means.

`lib/exercises/bookmarks_design.dart` is a small app with a list of
talks, a bookmark button on each talk, a count in the app bar and a
*Saved* page. Each button keeps its own flag, so nothing agrees.

> The bookmark count in the app bar, the icon on each talk and the Saved
> page always agree. A bookmark stays when the user opens Saved and comes
> back.

1. **Decide (Minimum).** Write `DECISIONS.md` with three decisions and
   one reason for each:
   1. What is the shared state, and what is its type? (For example a
      list of talks, a set of ids, or a map from id to `bool`.)
   2. Which widgets watch it, and which only change it?
   3. If bookmarks were a feature of Campus Companion, which folder and
      which layer (`domain`, `data`, `presentation`) would `Talk`, your
      provider and each of the three widgets go in?
2. **Implement (Minimum).** Make your decisions work. You may write the
   provider with `@riverpod` (then run the generator) or by hand, as in
   `lecture_check_in_by_hand.dart`.

   ```bash
   flutter run -d chrome -t lib/exercises/bookmarks_design.dart
   flutter test test/exercises/bookmarks_design_test.dart
   ```

   The tests check the requirement, not your design.

<details><summary>Step-by-step help</summary>

- Which kind of state from the lecture is a bookmark: ephemeral state
  or app state? How many widgets need it?
- A `Notifier` whose state is the collection you chose, with one method
  that adds or removes one talk.
- Each of the three widgets becomes a `ConsumerWidget` that watches the
  provider in `build`. The button calls the notifier with `ref.read` in
  `onPressed`.
- Do not forget a `part` line if you use `@riverpod`.

</details>

**Checkpoint B (TA, Minimum: Task 3 and Task 4):** show the failing and
then passing test from Task 3, the profile and the drawer, your
`DECISIONS.md` and the bookmarks app. The TA reads your AI note and points
at one line, for example `final saved = ref.watch(...)` in your bookmark
button, and asks *what happens if I change `watch` to `read` here?* Write
your prediction, then try it. The TA may also ask *why did you choose this
type for the state?*

### Task 5 — Extra task: search

**AI-use level:** 2 — Review.

Add a `@riverpod class SearchQuery extends _$SearchQuery` that holds a
`String`, a `TextField` above the notes list that sets it, and make
`sortedNotes` (or a new `filteredNotes`) watch both providers. Write the
unit test first, with a `ProviderContainer`.

### Task 6 — Extra task: run the generator yourself

**AI-use level:** 1 — Explain only.

Delete `lib/features/notes/domain/note.freezed.dart` and
`lib/features/notes/data/notes_notifier.g.dart`. Run
`flutter analyze` and read the errors. Then run
`dart run build_runner build -d` and check with `git diff` that the
generated files are the same as before (or explain each difference).
Finally, add a field `@Default('') String tag` to `Note`, regenerate, and
find the new field in `copyWith` in `note.freezed.dart`. Undo the change
with `git restore` when you are done.

## If you are stuck

Try each level in order, and stop as soon as you can continue.

**Task 0 — the generated provider**
1. *Question:* in `notes_notifier.g.dart`, search for `notesProvider`.
   Which line has `final` in front of it?
2. *Steps:* (1) find `final notesProvider`; (2) search for
   `class _$Notes`; (3) open `notes_notifier.dart` and read the line that
   starts with `part`; (4) compare with `lecture_check_in_by_hand.dart`,
   which has no `part` line.
3. *Look at:* `lecture_check_in_by_hand.dart` writes by hand the line the
   generator writes for you.

**Task 1 — the notifier**
1. *Question:* what does the test `update replaces the note and bumps
   updatedAt` expect to find in the state after `update`?
2. *Steps:* (1) `add`; run the tests; (2) `remove`; (3) `togglePinned`;
   (4) `update`; (5) `sortedNotes`. Run the tests after each step.
3. *Completion:* fill in the blank.
   ```dart
   void togglePinned(String id) {
     state = List.unmodifiable([
       for (final note in state)
         ________________,
     ]);
   }
   ```

**Task 2 — the editor**
1. *Question:* why does `initState` use `ref.read`, not `ref.watch`?
2. *Steps:* (1) read the note in `initState` and fill the controllers;
   (2) `_save` for a new note; (3) `_save` for an existing note; (4)
   `_delete`. Run `flutter test test/features/notes` after each step.
3. *Look at:* `_add` in `RemindersPage` reads the notifier in a callback.

**Task 3 — the test**
1. *Question:* how does `pumpApp` let a test replace a provider?
2. *Steps:* (1) call `pumpApp` with `initialLocation: Routes.profile`;
   (2) add `overrides: [...]` with your profile; (3) expect the name;
   (4) expect the programme and year with `findRichText: true`.
3. *Completion:* fill in the two blanks.
   ```dart
   await pumpApp(
     tester,
     initialLocation: Routes.profile,
     overrides: [________________],
   );
   expect(________________, findsOneWidget);
   ```

**Task 4 — bookmarks**
1. *Question:* which widgets need to know whether talk `t2` is
   bookmarked?
2. *Steps:* (1) choose the type; (2) write the notifier with one method;
   (3) change `BookmarkButton`; (4) change `BookmarkCount`; (5) change
   `SavedPage`; (6) run the tests.
3. *Look at:* `CheckInPage` and `CheckInBadge` in `lecture_check_in.dart`
   show one value in two widgets.

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
| **Checkpoint A** — Task 0 answers, including the generated provider; `Notes` complete with immutable updates and its tests passing; notes screens connected; correct prediction for "what happens if I change this line?" | 0 | 2 | 3 |
| **Checkpoint B** — profile on `profileProvider`; bookmarks app passing its tests, with three decisions and reasons in `DECISIONS.md`; AI note | 0 | 2 | 3 |
| **Test written first and seen failing (show the TA)** — the Task 3 override test | 0 | 1 | 2 |
| **Exit task** (marked 0–2 by the TA from the key) | | | |

*Next step (written by the TA):* ______________________________

## AI note

Add a file `AI_NOTE.md` with three lines. The TA reads it at Checkpoint B.

1. Which task did you use an assistant for (or "none")?
2. What did it get wrong, or what did you not understand?
3. What did you check yourself, and how?

## Submit

Lab work is individual. Push your lab work (including the generated
`*.g.dart` and `*.freezed.dart` files), `answers.md`, `predictions.md`,
`DECISIONS.md` and `AI_NOTE.md` to `week05/` of your lab repository by
the start of the next lab.

Make at least one commit for each required task, with the week and the
task in the message, for example `feat(week05): task 2 <what changed>`,
and push. Before the deadline, run `dart tool/check_lab_commits.dart
../mad-labs-UGR-XXXX-YY 05` from the root of the course repository. Your
work is collected from GitHub at the start of the next lab. A required
task without a commit costs 1 of the 10 rubric points (see
`guides/lab-repository.md`).
