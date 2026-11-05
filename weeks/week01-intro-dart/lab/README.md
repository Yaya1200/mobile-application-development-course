# Lab 1 — Set up, Hello World, Dart basics

**Starter:** `lab/starter/` · **Solution:** `lab/solution/` appears in the repository after the lab week

## Goal

Leave this lab with a working Flutter installation, the Campus Companion app
shell running on your machine, eight Dart functions passing their tests,
and one assistant answer checked by you.

## How this lab works

- **AI-use level.** Under each task heading you find its level (see
  `syllabus/policies.md`): **0** No AI, **1** Explain only, **2** Review,
  **3** Draft and verify. In this lab the Dart exercises are level 0: they
  train the skill that the mid exam checks without an assistant.
- **Checkpoints.** Two checkpoints are signed by a TA (**Checkpoint A** and
  **Checkpoint B**). Steps called **Self-check** are for you and your
  neighbour.
- **Minimum for the checkpoint.** If you are short of time, finish the
  steps marked *Minimum* first.
- **Exit task.** The lab ends with a short task on paper, with your laptop
  closed.
- **Stuck?** Read "If you are stuck" near the end of this file before you
  open anything else.

## Setup

Bring a laptop with at least 8 GB RAM and 15 GB of free disk space. If you
have not downloaded Flutter before the lab, start the download first and do
Task 4 in DartPad while you wait.

**Without internet.** The lab works offline once Flutter and its packages
are installed. If the network is slow, ask a TA for the USB drive. It has
the Flutter SDK archive, the Android command-line tools and a filled
package cache (`pub-cache`). If `flutter pub get` fails because there is
no network:

1. copy the `pub-cache` folder from the USB drive to your home folder;
2. set the environment variable `PUB_CACHE` to that folder (Linux and
   macOS: `export PUB_CACHE=$HOME/pub-cache`; Windows: `setx PUB_CACHE
   %USERPROFILE%\pub-cache`, then open a new terminal);
3. run `flutter pub get --offline`.

**For later weeks.** Week 10 needs Node.js (LTS) and a Java runtime
(JDK 21 or newer) for the Firebase tools. Install them when you have a
good connection; you do not need them in this lab.

## Tasks

### Task 1 — Install Flutter 3.47.7

**AI-use level:** 1 — Explain only. You may ask an assistant what an
installation error means.

1. Follow https://docs.flutter.dev/install for your OS. Choose
   the **stable** channel. If the installer offers a newer version than
   3.47.7, download the archive for 3.47.7 from
   https://docs.flutter.dev/install/archive instead — the course pins that
   version so everyone's code behaves the same.
2. Add `flutter/bin` to your `PATH`. Open a **new** terminal and run:
   ```bash
   flutter --version     # Flutter 3.47.7 • Dart 3.13.5
   flutter doctor
   ```
3. Read every line of `flutter doctor`. For the first weeks, ✓ on
   *Flutter* and on *Chrome* is enough. *Android toolchain* and *Android
   Studio* must be ✓ by week 4; see `guides/troubleshooting.md` for the
   licence-acceptance and `cmdline-tools` errors that most people
   encounter.
4. Install VS Code with the **Flutter** extension (or Android Studio with
   the Flutter plugin). Both work; the slides use VS Code.

**Self-check 1 (Minimum):** `flutter --version` prints 3.47.7 and
`flutter doctor` shows ✓ for Flutter and Chrome. Show your neighbour.

**Your lab repository (Minimum).** All your labs go in one private
GitHub repository of your own, named after your student ID:
`UGR/1234/16` becomes `mad-labs-UGR-1234-16`. Follow "Once, in week 1"
in `guides/lab-repository.md`: create the repository, clone it next to
the course repository, add `README.md` with your student ID, and add the
instructor and your TA as collaborators. From now on, commit at least
once after each task, with the week and the task in the message.

### Task 2 — Hello World and hot reload

**AI-use level:** 0 — No AI.

1. Copy the starter into your lab repository and run it. Every `cd` in
   this course starts from the root of the course repository:
   ```bash
   dart tool/start_lab.dart 01 ../mad-labs-UGR-XXXX-YY   # copies lab/starter/ to week01/ and commits it
   cd ../mad-labs-UGR-XXXX-YY/week01
   flutter --version > flutter-version.txt
   git add flutter-version.txt
   git commit -m "chore(week01): task 1 record the Flutter version"
   flutter pub get
   flutter run -d chrome          # or: flutter devices, then -d <id>
   ```
2. Open `week01/` in your editor. This is a `flutter create --empty`
   project already named `campus_companion`.
3. Copy this table into a file `predictions.md`. Fill in the
   **Prediction** column for all three rows **before** you try anything.

   | Step | Prediction: what will you see? | What you saw | Same? |
   |---|---|---|---|
   | a. Change `'Hello World!'` in `lib/main.dart` to a greeting in your language, then press `r` | | | |
   | b. Change `runApp(const MainApp())` to `runApp(const Placeholder())`, then press `r` | | | |
   | c. With the change from b still there, press `R` | | | |

4. Now do each step and fill in the other two columns. Undo the change
   from step b.

**Self-check 2:** explain to your neighbour, in one sentence each, what hot
reload and hot restart do differently. Use the row of your table where
your prediction was wrong, if there is one.

### Task 3 — The Campus Companion shell

**AI-use level:** 1 — Explain only.

Turn the template into the app we will grow all semester.

1. Create `lib/app.dart` containing:
   - `CampusCompanionApp` — a `StatelessWidget` returning a `MaterialApp`
     with `title: 'Campus Companion'`, `theme: ThemeData(colorSchemeSeed:
     const Color(0xFF00695C), useMaterial3: true)`, and `home: const
     HomeScreen()`.
   - `HomeScreen` — a `StatelessWidget` returning a `Scaffold` with an
     `AppBar` titled **Campus Companion** and a centred `Text` reading
     **Welcome to Campus Companion**.
2. Make `lib/main.dart` only import `app.dart` and call
   `runApp(const CampusCompanionApp())`. Delete `MainApp`.
3. Update `test/app_test.dart` to pump `CampusCompanionApp` and expect both
   texts (the `TODO(lab)` comment in the file tells you what to change).
4. Run `flutter analyze --fatal-infos` — it must report *No issues found*.
   The course lint rules are intentionally strict; `dart fix --apply` fixes
   most `const` warnings.
5. Run `flutter test test/app_test.dart` — it must pass.

**Checkpoint A (TA, Minimum):** show the running app and the passing test.
The TA asks one question, for example *why is `HomeScreen` a
`StatelessWidget`?* or *what changes if you remove `const` from
`HomeScreen()`?*

### Task 4 — Dart exercises

**AI-use level:** 0 — No AI. These exercises train the Dart you need in
the mid exam. Use the lecture notes, the Dart documentation and DartPad,
not an assistant.

Open `lib/exercises/dart_basics.dart`. Eight functions throw
`UnimplementedError`. The worked examples from the lecture are in
`lib/exercises/lecture_examples.dart`; each exercise is similar to one of
them, but not the same. Read the example, close the file, then write the
exercise yourself.

1. **Test first for Exercise 3 (Minimum).** Before you write
   `bmiCategory`, open `test/exercises/dart_basics_test.dart` and write
   your own test in the place marked `TODO(lab): Exercise 3`. It must use
   a value exactly on a boundary (for example `25.0`). Run
   `flutter test test/exercises` and watch your test fail. Keep the
   failing output on screen or take a screenshot: you show it at
   Checkpoint B.
2. Implement the eight functions so that

   ```bash
   flutter test test/exercises
   ```

   passes. Suggested order: 1, 2, 7, 4, 3, 6, 5, 8. Do not change the
   given tests.

If your environment is not ready yet, paste one function at a time into
https://dartpad.dev with a `main()` that prints a few calls, then copy it
back.

### Task 5 — Check an assistant's answer

**AI-use level:** 0 — No AI. The assistant's answer is already saved; you
do the checking yourself.

Read "Using an assistant while you are learning" in the week 1 notes
first. Then open `lab/ai_answers/capitalize_words.md`. It is an answer an
assistant gave to the prompt at the top of the file.

1. **Predict.** Without running anything, write in `predictions.md` what
   `capitalizeWords` returns for `'addis ababa'`, for `'hello  world'`
   (two spaces) and for `''` (the empty string).
2. **Run.** Copy the function into a DartPad (or into a scratch file
   outside `lib/`) with a `main()` that prints the three calls. Write down
   what happened.
3. **Mark.** In `predictions.md`, list every sentence or line in the
   answer that is wrong, and for each one write how you found out: the
   analyser, running it, a test, or the Dart documentation
   (https://api.dart.dev). There is more than one.
4. **Fix.** Write a version of `capitalizeWords` that works for all three
   inputs.

If you have an assistant, you may also send it the same prompt and
compare its answer with the saved one. Record what you found in your AI
note.

**Checkpoint B (TA, Minimum: steps 1 and 2 of Task 4, and Task 5):** show
your failing boundary test and then the passing exercise tests, and your
list from Task 5. The TA reads your AI note and asks one question, for
example *explain your `letterCount`*, or *what would `bmiCategory(25)`
return if you changed `< 25` to `<= 25`?*

### Task 6 — Extra task

**AI-use level:** 1 — Explain only.

Add a second `StatelessWidget`, `AboutScreen`, that shows your name and
programme in a `Column`. Show it instead of `HomeScreen` (we learn
navigation in week 4). Write a widget test for it.

## If you are stuck

Try each level in order, and stop as soon as you can continue.

**Task 3 — the app shell**
1. *Question:* which widget gives you the app bar and the body area of a
   screen?
2. *Steps:* (1) write `HomeScreen` with a `Scaffold`; (2) write
   `CampusCompanionApp` with a `MaterialApp` whose `home` is
   `HomeScreen`; (3) change `main.dart`; (4) change the test.
3. *Look at:* the `HomeScreen` example in the notes, section 2, is the
   same widget. Write `CampusCompanionApp` yourself.

**Exercise 5 — `letterCount`**
1. *Question:* how do you turn a `String` into a list of single
   characters?
2. *Steps:* (1) make an empty `Map<String, int>`; (2) loop over the
   characters of the lower-case text; (3) skip a character that is not a
   letter; (4) add one to that letter's count.
3. *Completion:* fill in the two blanks.
   ```dart
   Map<String, int> letterCount(String text) {
     final counts = <String, int>{};
     for (final char in text.toLowerCase().split('')) {
       if (________________) continue;
       ________________;
     }
     return counts;
   }
   ```

**Exercise 8 — `summarise`**
1. *Question:* in the `describe` example, which line handles a `String`?
2. *Steps:* one `switch` case per row of the comment above the function,
   in the same order, with `_` last.
3. *Look at:* `final bool b => b ? 'yes' : 'no'` is one complete case.

## Exit task

At the end of the lab, close your laptop. The TA gives you one short
question on paper. It is like the exercises in this lab but not the same. You
have until the TA collects the papers. It is worth 2 of the 10 points and
shows you, and the instructor, what you can do without help.

## Rubric (10 points)

The TA records a level for each checkpoint and writes one "Next step" line
for you.

| What is checked | Not yet | Working | Can explain and change it |
|---|---|---|---|
| **Checkpoint A** — app shell runs; `app_test.dart` updated and passing; analyser clean | 0 | 2 | 3 |
| **Checkpoint B** — exercise tests pass; Task 5 list of errors and how each was found; AI note | 0 | 2 | 3 |
| **Test written first and seen failing (show the TA)** — the Exercise 3 boundary test | 0 | 1 | 2 |
| **Exit task** (marked 0–2 by the TA from the key) | | | |

*Next step (written by the TA):* ______________________________

## AI note

Add a file `AI_NOTE.md` with three lines. The TA reads it at Checkpoint B.

1. Which task did you use an assistant for (or "none")?
2. What did it get wrong, or what did you not understand?
3. What did you check yourself, and how?

## Submit

Lab work is individual. Push your lab work, `flutter-version.txt`,
`predictions.md` and `AI_NOTE.md` to `week01/` of your lab repository
(see `guides/lab-repository.md`) by the start of the next lab.

Make at least one commit for each required task, with the week and the
task in the message, for example `feat(week01): task 3 add the
CampusCompanionApp shell`, and push. Before the deadline, run
`dart tool/check_lab_commits.dart ../mad-labs-UGR-XXXX-YY 01` from the
root of the course repository. Your work is collected from GitHub at the
start of the next lab. A required task without a commit costs 1 of the
10 rubric points.
