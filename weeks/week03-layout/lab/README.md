# Lab 3 — Events feed, profile and your own card

**Starter:** `lab/starter/` (last week's solution without the exercises) ·
**Solution:** `lab/solution/` appears in the repository after the lab week

## Goal

Build the two main screens of Campus Companion as layouts that work on a
small phone and on a wide screen: an events feed that changes from a list
to a grid, and a profile screen that changes with the orientation. You
write one widget test before the code, check an assistant's layout code,
and design one card yourself.

## How this lab works

- **AI-use level.** Under each task heading you find its level (see
  `syllabus/policies.md`): **0** No AI, **1** Explain only, **2** Review,
  **3** Draft and verify. Most tasks in this lab are level 1: you may ask
  an assistant what an error means or what a widget does, but you choose
  and write the widgets yourself.
- **Checkpoints.** Two checkpoints are signed by a TA (**Checkpoint A** and
  **Checkpoint B**). Steps called **Self-check** are for you and your
  neighbour. At each checkpoint the TA points at one line of your code and
  asks what happens if you remove it. Predict first, then try it.
- **Minimum for the checkpoint.** If you are short of time, finish the
  steps marked *Minimum* first.
- **Worked examples.** `lib/exercises/lecture_layouts.dart` holds the
  examples from the lecture (`ContactTile`, `RoomsPage`, `CoursePage`),
  with their tests. Each task is similar to one example, but not the same.
  Read the example, close it, then write your code.
- **Step-by-step help.** Some tasks describe *what* the screen must show.
  If you do not know where to start, open the "Step-by-step help" under
  the task. Try without it first.
- **Exit task.** The lab ends with a short task on paper, with your laptop
  closed.
- **Stuck?** Read "If you are stuck" near the end of this file before you
  open anything else.

## Setup

```bash
dart tool/start_lab.dart 03 ../mad-labs-UGR-XXXX-YY   # once: copies the starter into your lab repository
cd ../mad-labs-UGR-XXXX-YY/week03
flutter pub get                 # or: flutter pub get --offline
flutter analyze --fatal-infos   # clean before you start
flutter test                    # many tests fail until the lab is done
flutter run -d chrome           # keep it running; resize the window later
```

The starter already has the sample data (`lib/data/sample_events.dart`),
the check-in screen from week 2 in its own file, and a `SegmentedButton`
on the home screen that switches between three sections. That switch is
temporary; real navigation comes in week 4.

Copy the prediction tables of this lab into one file, `predictions.md`.

## Tasks

### Task 1 — Register the asset

**AI-use level:** 1 — Explain only. You may ask what the error message
means.

`assets/images/logo.png` exists, but `pubspec.yaml` does not declare it.

1. Fill in the **Prediction** column of this table before you do the
   steps.

   | Step | Prediction: what will you see? | What you saw | Same? |
   |---|---|---|---|
   | a. Add `Image.asset('assets/images/logo.png')` to the stub `ProfileScreen`, press `R` (hot restart), switch to *Profile* | | | |
   | b. Declare the folder in `pubspec.yaml` (step 3 below), then press `R` | | | |

2. Do step a. Read the error in the console: which words name the file,
   and which words say what went wrong?
3. Declare the folder under `flutter:` in `pubspec.yaml`:
   ```yaml
     assets:
       - assets/images/
   ```
4. Do step b and fill in the other two columns.

**Self-check 1 (Minimum):** the logo appears. Tell your neighbour why the
app built without an error in step a, but failed when it ran.

### Task 2 — `EventCard`

**AI-use level:** 1 — Explain only.

Replace the `ListTile` in `lib/widgets/event_card.dart` with a card that
looks like this:

```
┌──────────────────────────────────────────────────┐
│ ┌────┐  Flutter study group: layouts    ┌──────┐ │  title: two lines at most, then "…"
│ │ 14 │  and constraints                 │ Free │ │  Free chip: only for free events
│ │Oct │  Technology faculty · Amist Kilo └──────┘ │  venue label in bold, then the location
│ └────┘  Layouts and constraints.                 │  description: only when there is one
└──────────────────────────────────────────────────┘
  date box, 56 px wide
```

The worked example is `ContactTile` in `lib/exercises/lecture_layouts.dart`.
The tests in `test/widgets/event_card_test.dart` are the contract. They
check:

- the day number and a three-letter month (`'Oct'` for 10) in the box;
- the title with at most two lines and an ellipsis;
- a `RichText` (or `Text.rich`) whose plain text is
  `'<venue label> · <venue location>'`, with the label in
  `FontWeight.w600`;
- the description only when it is not empty;
- the `Free` chip only when `event.isFree`;
- no overflow for a 320-pixel-wide card with a very long title.

Use `Theme.of(context).textTheme` and `colorScheme` for every style; do not
type font sizes or colours.

<details><summary>Step-by-step help</summary>

```
Card > Padding(12) > Row [
  Container(width 56, primaryContainer, radius 8) > Column [ day, month ],
  SizedBox(width 12),
  Expanded > Column(start) [ title, RichText(venue · location), description? ],
  SizedBox(width 8),
  if (event.isFree) Chip('Free'),
]
```

- Day: `titleLarge`, bold, `onPrimaryContainer`. Month: `labelSmall`.
- Title: `titleMedium`, `maxLines: 2`, `overflow: TextOverflow.ellipsis`.
- `RichText` does not use the screen's text style: give the root
  `TextSpan` the style `bodyMedium`.
- Description: collection-`if` with a spread, `bodySmall`, two lines.

</details>

Run `flutter test test/widgets`.

**Self-check 2 (Minimum):** write in `predictions.md` what you will see if
you remove the `Expanded` around the details and the title is very long.
Then try it, run the tests, and put it back.

### Task 3 — `EventsScreen`: list, then grid

**AI-use level:** 2 — Review. Write it yourself first. Then you may ask an
assistant to review your code; record what it found in your AI note.

1. Replace the `ListView(children:)` in `lib/screens/events_screen.dart`
   with `ListView.builder` using `EventCard` (padding 8). Run the app and
   scroll.
2. Wrap it in a `LayoutBuilder`. When `constraints.maxWidth >= 600`,
   return a `GridView.builder` instead, with
   `SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 480,
   mainAxisExtent: 200)`. The worked example is `RoomsPage`.
3. Fill in the **Prediction** column, then do each step.

   | Step | Prediction | What you saw | Same? |
   |---|---|---|---|
   | a. Drag the Chrome window from narrower than 600 px to wider | | | |
   | b. Change `mainAxisExtent` to `120`, hot reload, look at a wide window | | | |
   | c. With `120`, run `flutter test test/screens/events_screen_test.dart`: which test fails, and with which message? | | | |

4. Put `200` back. `flutter test test/screens/events_screen_test.dart`
   passes.

**Checkpoint A (TA, Minimum: Tasks 1 and 2, and Task 3 steps 1–2):** show
the feed as a list and as a grid, the passing `test/widgets` and
`test/screens/events_screen_test.dart`, and your tables. The TA points at
one line, for example `maxLines: 2` on the title in `EventCard`, and asks
*what happens if I remove this line, in the list and in the grid?* Write
your prediction, then try it. The
TA may also ask *why does the grid need a fixed `mainAxisExtent`, and what
goes wrong when it is too small?*

### Task 4 — `ProfileScreen`, test first

**AI-use level:** 1 — Explain only. You write the test and the screen
yourself.

1. **Test first (Minimum).** Open `test/screens/profile_screen_test.dart`.
   In the place marked `TODO(lab): Task 4`, write a widget test that pumps
   `ProfileScreen` inside `SizedBox(width: 320)`, with a `MediaQuery` that
   reports a 320 × 640 phone (look at the `app` function at the top of the
   file). It expects no exception (`tester.takeException()` is `null`),
   finds the text `Posts`, and checks that the right edge of `Posts` is at
   most 320 (`tester.getRect(...).right`). The worked example is the
   `ContactTile` test in `test/exercises/lecture_layouts_test.dart`. Run
   `flutter test test/screens/profile_screen_test.dart` and watch your
   test fail. Keep the failing output on screen or take a screenshot: you
   show it at Checkpoint B.
2. Build `lib/screens/profile_screen.dart`. In portrait it shows, from top
   to bottom:
   - a round avatar with the logo from Task 1, the name **Sara Bekele**,
     and the line *B.Sc. **Computer Science** · 3rd year* (only "Computer
     Science" in bold);
   - three numbers with a label under each, sharing the width equally:
     12 Events, 34 Notes, 3 Posts;
   - four actions: *Edit profile* (the main action, with an edit icon),
     *Share*, *Sign out* (the least important), and a settings icon with
     the tooltip *Settings*; they go onto a second line when the screen is
     too narrow. Empty `onPressed` functions are fine in this lab;
   - a box with rounded corners that reads `Orientation: portrait` or
     `Orientation: landscape`.

   In landscape, the avatar part is on the left and everything else on
   the right, each taking half the width. The whole screen scrolls and
   stays out of the notch and status bar. Choose the buttons by their
   emphasis (see the table in the notes, section 4). The worked example is
   `CoursePage`.

   <details><summary>Step-by-step help</summary>

   - `SafeArea` > `SingleChildScrollView(padding: 16)`.
   - **Header** `Column`: `CircleAvatar(radius: 48, backgroundImage:
     AssetImage('assets/images/logo.png'))`, the name (`headlineSmall`),
     and a `RichText` with a bold span.
   - **Stats** `Row` of three `Expanded` tiles (value over label). Make a
     small private `_StatTile` widget.
   - **Actions** `Wrap` (spacing 8): `FilledButton.icon` *Edit profile*
     (`Icons.edit`), `OutlinedButton` *Share*, `TextButton` *Sign out*,
     `IconButton(Icons.settings, tooltip: 'Settings')`.
   - **Orientation banner**: a `Container` (`surfaceContainerHighest`,
     radius 12, margin-top 16) with the text from
     `MediaQuery.orientationOf(context)`.
   - In landscape, a `Row` of two `Expanded`: the header, and a `Column`
     of the rest. In portrait, one `Column`.

   </details>

3. Rotate the emulator (`Ctrl+←` / `Cmd+←`) or make the Chrome window
   wider than it is tall.
4. Run `flutter test`. Your test and the given profile tests must pass.

### Task 5 — Check an assistant's layout code

**AI-use level:** 0 — No AI. The assistant's answer is already saved; you
do the checking yourself.

Open `lab/ai_answers/schedule_row.md`. It is an answer an assistant gave
to the prompt at the top of the file. It is not part of Campus Companion.

1. **Predict (Minimum).** Without running anything, write in
   `predictions.md`: (a) does the code compile? (b) what does a 360-pixel
   wide phone show for the course `Mobile Applications Development`? Draw
   it. (c) what does it show for `Compilers`?
2. **Run (Minimum).** Copy the widget into a new file
   `lib/exercises/schedule_row.dart`.
   1. Run `flutter analyze`. Write down what it reports. Make the
      smallest change that lets the code compile.
   2. Write a widget test in `test/exercises/schedule_row_test.dart` that
      pumps `ScheduleRow` with the long course name inside
      `SizedBox(width: 320)` and expects `tester.takeException()` to be
      `null`. Run it and write down what happened. (In a widget test every
      letter is drawn as a square, so text is wider than on a phone. Use
      the long course name.)
3. **Mark (Minimum).** In `predictions.md`, list every line of code and
   every sentence of the explanation that is wrong. For each one, write how
   you found out: the analyser, your test, running the app, or the
   documentation. For the documentation, read the "Layout algorithm"
   section of the `Row` class (https://api.flutter.dev, or hover over
   `Row` in your editor, which works offline). There is more than one
   error.
4. **Fix.** Change `ScheduleRow` so that your test passes, and keep the
   test.

If you have an assistant, you may also send it the same prompt and
compare its answer with the saved one. Record what you found in your AI
note.

### Task 6 — Your own design: `NoteCard`

**AI-use level:** 1 — Explain only. Choosing the widgets is the skill this
task trains and the decision you defend at Checkpoint B, so the choice
must be yours. You may ask an assistant what a widget does or what an
error means.

The notes feature arrives in week 5. Here you design its card on its own,
in `lib/exercises/note_card.dart`. The constructor is given. Build
`NoteCard` so that it matches this design at 360 px and at 900 px wide.
Choose the widgets yourself.

At 360 px wide (a phone):

```
┌────────────────────────────────────────────┐
│ Shopping list for the field trip t…  (pin) │  title: one line, then "…"; pin icon at the right
│                                            │  end, only for pinned notes
│ Bread, water, two notebooks, the printed   │  body: three lines at most, then "…"
│ map and a torch. Ask Abebe whether the     │
│ bus leaves at seven or at half past se…    │
│                                            │
│ (trip) (shopping) (week 3)                 │  tags: small chips on the left; they go onto a
│ (remember)                  Edited 14 Oct  │  new line when there is no room; the date stays
└────────────────────────────────────────────┘  on the right and is never pushed off the card
```

At 900 px wide (a tablet, or a wide browser window):

```
                ┌──────────────────────────┐
                │ the same card, at most   │
                │ 560 px wide, centred     │
                └──────────────────────────┘
```

Rules:

- Styles come from the theme: title `titleMedium`, body `bodyMedium`,
  date `labelSmall` (use the given `editedLabel`).
- The card has 12 px of space inside its edge and 8 px between its parts.
- Nothing overflows, whatever the length of the title or the body and
  however many tags there are.

Run the card on its own and resize the window to 360 and 900 px (in
Chrome, the device toolbar in the developer tools sets an exact width):

```bash
flutter run -d chrome -t lib/exercises/note_card.dart
flutter test test/exercises/note_card_test.dart
```

The tests check what a test can check: the texts, the pin icon, no
overflow at 320, 360 and 900 px, and the 560 px limit. They do not check
which widgets you chose.

**At the checkpoint (Minimum):** draw your widget tree on paper (one box per
widget, children under their parent). Mark the widget that stops the title
overflowing, and the widget that keeps the date on the card. Be ready to
say why you chose each one.

**Checkpoint B (TA, Minimum: Task 4 step 1, Task 5 steps 1–3, Task 6):**
show your failing test from Task 4 and then the passing
`test/screens/profile_screen_test.dart`, the profile in both orientations,
your Task 5 list, and your `NoteCard` at 360 and 900 px with its tree on
paper. The TA reads your AI note and asks one question, for example
*which widget in your tree stops the title overflowing? What happens if I
remove it?* or *why does the `Spacer` in the assistant's answer not help?*

### Task 7 — Extra task: a *Today* badge

**AI-use level:** 2 — Review.

Add a `Stack` to `EventCard` that shows a small *Today* badge
(`Positioned` at the top right) when `event.start` is today. Pass the
current time in as a parameter, as in week 2 (`isUpcoming({DateTime?
now})`), so that you can test it. Write the test.

## If you are stuck

Try each level in order, and stop as soon as you can continue.

**Task 2 — `EventCard` overflows**
1. *Question:* which widget gives a child a bounded width inside a `Row`?
2. *Steps:* (1) make the outer `Row`; (2) add the date box with a fixed
   width; (3) wrap the details `Column` in `Expanded`; (4) add the chip
   with collection-`if`.
3. *Look at:* `ContactTile` in `lecture_layouts.dart` has the same three
   parts: a fixed box, an `Expanded` column and an optional icon.

**Task 4 — the test**
1. *Question:* how do you pump a widget at a width of 320 pixels, and
   which `WidgetTester` method returns the error that layout reported?
2. *Steps:* (1) `pumpWidget` with a `MediaQuery` (size 320 × 640) around
   a `MaterialApp`; (2) the `Scaffold` body is a `SizedBox(width: 320)`
   with `ProfileScreen` in it; (3) expect `takeException()` to be `null`;
   (4) find `Posts` and check the right edge of its rectangle.
3. *Completion:* fill in the two blanks.
   ```dart
   testWidgets('fits a 320-pixel-wide phone without overflow', (tester) async {
     await tester.pumpWidget(
       const MediaQuery(
         data: MediaQueryData(size: Size(320, 640)),
         child: MaterialApp(
           home: Scaffold(body: ________________),
         ),
       ),
     );
     expect(tester.takeException(), isNull);
     expect(find.text('Posts'), findsOneWidget);
     ________________;
   });
   ```

**Task 4 — landscape**
1. *Question:* in `CoursePage`, which value decides between the `Row` and
   the `Column`?
2. *Steps:* (1) build `header`, `stats`, `actions` and the banner as local
   variables; (2) read the orientation; (3) return a `Row` of two
   `Expanded` in landscape and a `Column` in portrait, each using the same
   variables.
3. *Look at:* `CoursePage` has the same two branches with different
   content.

**Task 5 — the assistant's answer**
1. *Question:* what width constraint does a `Row` give a child that is not
   in an `Expanded` or a `Flexible`?
2. *Steps:* (1) fix only the compile error; (2) run your test; (3) read the
   first line of the exception; (4) read "Layout algorithm" in the `Row`
   documentation and compare it with sentence 2 of the answer.
3. *Look at:* the same error appears in Self-check 2 when you remove the
   `Expanded` from `EventCard`.

**Task 6 — `NoteCard`**
1. *Question:* the card has two rows that can overflow. Which ones, and
   what does each need so that it cannot?
2. *Steps:* (1) limit the width of the whole card and centre it; (2) a
   `Card` with padding and a `Column` of three parts; (3) the title row;
   (4) the body; (5) the row with the tags and the date.
3. *Completion:* fill in the two blanks in this tree.
   ```
   Center > ConstrainedBox(maxWidth 560) > Card > Padding(12) > Column [
     Row [ ________ > Text(title, 1 line), if pinned: Icon(push_pin) ],
     Text(body, 3 lines),
     Row [ ________ > Wrap(chips), Text(date) ],
   ]
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
| **Checkpoint A** — asset visible; `EventCard` and feed tests pass; list and grid; prediction tables filled in before running; correct prediction for "what happens if I remove this line?" | 0 | 2 | 3 |
| **Checkpoint B** — `ProfileScreen` in both orientations and its tests pass; Task 5 list of errors and how each was found; `NoteCard` at 360 and 900 px with its widget tree, and the widget that stops the overflow named; AI note | 0 | 2 | 3 |
| **Test written first and seen failing (show the TA)** — the Task 4 test at 320 px | 0 | 1 | 2 |
| **Exit task** (marked 0–2 by the TA from the key) | | | |

*Next step (written by the TA):* ______________________________

## AI note

Add a file `AI_NOTE.md` with three lines. The TA reads it at Checkpoint B.

1. Which task did you use an assistant for (or "none")?
2. What did it get wrong, or what did you not understand?
3. What did you check yourself, and how?

## Submit

Lab work is individual. Push your lab work, `predictions.md`, a photo of
your `NoteCard` widget tree and `AI_NOTE.md` to `week03/` of your lab
repository by the start of the next lab. The **project proposal**
(`project/proposal-template.md`) is group work and is due at the end of
week 3, committed as `PROPOSAL.md` in the group's repository with the
tag `proposal`.

Make at least one commit for each required task, with the week and the
task in the message, for example `feat(week03): task 2 <what changed>`,
and push. Before the deadline, run `dart tool/check_lab_commits.dart
../mad-labs-UGR-XXXX-YY 03` from the root of the course repository. Your
work is collected from GitHub at the start of the next lab. A required
task without a commit costs 1 of the 10 rubric points (see
`guides/lab-repository.md`).
