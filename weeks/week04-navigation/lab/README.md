# Lab 4 — Connecting the screens

**Starter:** `lab/starter/` (last week's solution with `TODO(lab)` markers) ·
**Solution:** `lab/solution/` appears in the repository after the lab week

## Goal

Campus Companion gets real navigation: a four-tab bottom bar where each
tab keeps its own back stack, a drawer, an event detail page with an
address that works as a deep link, an edit-profile page that returns a
result, and Upcoming/Past tabs on the feed. You first read a named-routes
app and predict what it does, you write the not-found tests before the
code, and you decide yourself where a Settings screen goes.

## How this lab works

- **AI-use level.** Under each task heading you find its level (see
  `syllabus/policies.md`): **0** No AI, **1** Explain only, **2** Review,
  **3** Draft and verify. Most tasks in this lab are level 1: you may ask
  an assistant what an error means or what a class does, but you write
  the routes yourself.
- **Checkpoints.** Two checkpoints are signed by a TA (**Checkpoint A** and
  **Checkpoint B**). Steps called **Self-check** are for you and your
  neighbour. At each checkpoint the TA points at one line of your code and
  asks what happens if you remove it. Predict first, then try it.
- **Minimum for the checkpoint.** If you are short of time, finish the
  steps marked *Minimum* first.
- **Worked examples.** `lib/exercises/lecture_navigation.dart` is the
  small library app from the lecture (books, loans, a drawer, a page that
  returns a result), with its tests. `lib/exercises/named_routes_demo.dart`
  shows Navigator 1.0. Each task is similar to one example, but not the
  same. Read the example, close it, then write your code.
- **Step-by-step help.** Most tasks describe *what* the app must do. If
  you do not know where to start, open the "Step-by-step help" under the
  task. Try without it first.
- **Exit task.** The lab ends with a short task on paper, with your laptop
  closed.
- **Stuck?** Read "If you are stuck" near the end of this file before you
  open anything else.

## Setup

```bash
dart tool/start_lab.dart 04 ../mad-labs-UGR-XXXX-YY   # once: copies the starter into your lab repository
cd ../mad-labs-UGR-XXXX-YY/week04
flutter pub get                 # go_router is already declared; or: flutter pub get --offline
flutter analyze --fatal-infos   # clean before you start
flutter test                    # many tests fail until the lab is done
flutter run -d chrome           # watch the address bar as you navigate
```

**No emulator?** If your laptop cannot run the Android emulator, use
Chrome or a physical phone with USB debugging. All week 4 tasks work in
Chrome. The steps that type an address need Chrome; on a phone, the tests
check the same addresses.

**No network?** If `flutter pub get` fails, copy the `pub-cache` folder
from the TA's USB drive and set `PUB_CACHE` to it, as in lab 1, then run
`flutter pub get --offline`.

The starter already has: `go_router` connected to `MaterialApp.router`, a
shell with **two** branches (Events, Profile), the `Routes` constants,
`EventDetailScreen` (it shows "Event not found" when it gets no event),
`EditProfileScreen`, the placeholder Notes and Lost & found screens, and
`CheckInScreen` and `AboutScreen` as their own routes.

Copy the prediction tables of this lab into one file, `predictions.md`.

## Tasks

### Task 1 — Read and predict: named routes

**AI-use level:** 1 — Explain only. Write every prediction before you ask
anything or run anything.

Open `lib/exercises/named_routes_demo.dart`. It is a small app that uses
Navigator 1.0 the way the course outline describes it:
`MaterialApp(routes: {...})`, `onGenerateRoute` and `onUnknownRoute`.
Read the whole file.

1. **Predict (Minimum).** Fill in the **Prediction** column. Do not run
   the app yet.

   | Step | Prediction | What you saw | Same? |
   |---|---|---|---|
   | a. Open the address `…/#/events/42`. Which screen appears? | | | |
   | b. Then press the back arrow in the app bar. Which screen appears? Press it again. | | | |
   | c. Open the address `…/#/events/abc`. Which screen appears, and what does the console show? | | | |

2. **Run (Minimum).** Start the demo on a local web server and open the
   addresses yourself, each in a new browser tab:

   ```bash
   flutter run -d web-server --web-port 8090 -t lib/exercises/named_routes_demo.dart
   # then open http://localhost:8090/#/events/42 in Chrome
   ```

   Fill in the other two columns. On a phone, read
   `test/exercises/named_routes_demo_test.dart` and run it instead.
3. **Explain.** Write the answers in `predictions.md`:
   - Which line turns the text `42` into the number 42?
   - What does `generateDemoRoute` return for `/events/5`, and which
     screen does the user then see?
   - The app must also open `/events/42/photos/3`. Which lines would you
     have to add or change? Write them in words or code; do not run them.

Keep your answers: in Task 4, `go_router` does the same parsing for you.

### Task 2 — Open the detail with `Navigator.push`

**AI-use level:** 1 — Explain only.

Requirements:

- Tapping a card on the events feed opens `EventDetailScreen` for that
  event. Use Navigator 1.0 (`Navigator.push`), not `go_router`. The worked
  example is `_chooseCampus` in `named_routes_demo.dart`.
- The detail screen has a bottom toolbar with three icon buttons: *Share*,
  *Add to calendar* and *Bookmark*, each with a tooltip. A *Register*
  button with an icon and a label sits in a notch at the right end of the
  toolbar. Pressing it shows a `SnackBar` with the text
  *Registered for <title>*. The buttons on the toolbar may do nothing yet.
  The worked example is `BookPage` in `lecture_navigation.dart`.

Before you run it, fill in this table.

| Step | Prediction | What you saw | Same? |
|---|---|---|---|
| a. Tap a card. Is the bottom navigation bar visible on the detail? | | | |
| b. With the detail open, tap *Profile*, then *Events*. What do you see? | | | |

<details><summary>Step-by-step help</summary>

1. In `lib/screens/events_screen.dart`, give each `EventCard` an `onTap`:

   ```dart
   onTap: () => Navigator.push(
     context,
     MaterialPageRoute<void>(builder: (_) => EventDetailScreen(event: event)),
   ),
   ```

2. In `lib/screens/event_detail_screen.dart`, add to the `Scaffold`:
   - `bottomNavigationBar: BottomAppBar(shape: const
     CircularNotchedRectangle(), child: Row(children: [...]))` with three
     `IconButton`s (`tooltip:` *Share*, *Add to calendar*, *Bookmark*);
   - `floatingActionButton: FloatingActionButton.extended(...)` labelled
     *Register* that calls `ScaffoldMessenger.of(context).showSnackBar`;
   - `floatingActionButtonLocation: FloatingActionButtonLocation.endDocked`.

</details>

**Self-check 1 (Minimum):** tell your neighbour which navigator
`Navigator.push` used, and how you can tell from the screen. In Task 4 you
put the detail on another navigator; compare the two.

### Task 3 — Four branches

**AI-use level:** 1 — Explain only.

The bottom bar must have four tabs, in this order: Events, Notes,
Lost & found, Profile. Each tab keeps its own back stack. The icons are
named in the `TODO(lab)` comment in `lib/navigation/app_shell.dart`; the
titles in the app bar follow the selected tab. The worked example is the
shell route of `createLibraryRouter` and `LibraryShell`.

<details><summary>Step-by-step help</summary>

- In `lib/navigation/router.dart`, add a `StatefulShellBranch` for
  `Routes.notes` (`NotesScreen`) and one for `Routes.lostFound`
  (`LostFoundScreen`) between Events and Profile.
- In `lib/navigation/app_shell.dart`, add the two matching
  `NavigationDestination`s and extend `_titles`.

</details>

Run it and switch between the tabs. Run `flutter test test/navigation`.

**Self-check 2 (Minimum):** the router has four branches, and you remove
the *Notes* destination from the bar. Write in `predictions.md` what
happens (a) when you tap the third icon, *Profile*, and (b) when you type
the address `#/profile`. Then try it, read the error, and put the
destination back.

### Task 4 — A deep-linkable detail route, test first

**AI-use level:** 1 — Explain only. You write the tests and the routes
yourself.

1. **Test first (Minimum).** Open `test/navigation/router_test.dart`. In
   the place marked `TODO(lab): Task 4`, write two widget tests:
   - one that starts the app at `/events/nope` and expects the text
     `Event not found`;
   - one that starts the app at a location that matches no route (for
     example `/does-not-exist`) and expects the text of your error page,
     which starts with `No route for`.

   The `pumpApp` function at the top of the file starts the app at any
   location. The worked example is the test `an unknown ISBN shows "Book
   not found"` in `test/exercises/lecture_navigation_test.dart`. Run
   `flutter test test/navigation/router_test.dart` and watch your tests
   fail. Keep the failing output on screen or take a screenshot: you show
   it at Checkpoint A.
2. **The routes.** In `lib/navigation/router.dart`:
   - `/events/<id>` opens `EventDetailScreen` for the sample event with
     that id, *above* the bottom bar. When no event has that id, the
     screen gets `null` and shows "Event not found"; nothing crashes.
   - Any location that matches no route shows an error page with the
     title *Not found* and the text *No route for <location>*.

   The worked example is the `:isbn` route and the `errorBuilder` in
   `createLibraryRouter`.
3. Change the `onTap` from Task 2 so that it opens the detail through
   `go_router`, with the path built by `Routes.eventDetailFor`.
4. Fill in the **Prediction** column, then type each address in Chrome
   (change the part after `#`).

   | Address | Prediction | What you saw | Same? |
   |---|---|---|---|
   | a. `#/events/e3` | | | |
   | b. `#/events/nope` | | | |
   | c. `#/nothing` | | | |

5. Run `flutter test test/navigation`. Your tests now pass.

<details><summary>Step-by-step help</summary>

1. Under the Events `GoRoute`, add `routes: [GoRoute(path: ':id', ...)]`
   with `parentNavigatorKey: rootNavigatorKey`.
2. Its builder reads `state.pathParameters['id']`, finds the event with
   `sampleEvents.where((e) => e.id == id).firstOrNull`, and returns
   `EventDetailScreen(event: event)`.
3. Add `errorBuilder: (context, state) => Scaffold(...)` to the
   `GoRouter`, with an `AppBar` titled *Not found* and a centred
   `Text('No route for ${state.uri}')`.
4. Replace `Navigator.push(...)` with
   `context.push(Routes.eventDetailFor(event.id))`.

</details>

**Checkpoint A (TA, Minimum: Task 1 step 1, Tasks 2 and 3, Task 4):**
show your Task 1 table, the failing and then passing tests from Task 4,
the three addresses, and the detail with its toolbar. The TA points at one
line, for example `parentNavigatorKey: rootNavigatorKey`, and asks *what
happens if I remove this line?* Write your prediction, then try it. The TA
may also ask *which line of `named_routes_demo.dart` does `go_router` now
do for you?* or *what would you lose if you used `context.go` instead of
`context.push` in step 3?*

### Task 5 — Drawer

**AI-use level:** 1 — Explain only.

The drawer must have an entry *Check-in* (icon `Icons.how_to_reg`) that
opens `Routes.checkIn`, an entry *About* (icon `Icons.info_outline`) that
opens `Routes.about`, a divider, and an `AboutListTile` that shows the app
name and version and the licences. When the user comes back from Check-in
or About, the drawer is closed. The worked example is `LibraryDrawer`.

Fill in the **Prediction** column, then try it.

| Step | Prediction | What you saw | Same? |
|---|---|---|---|
| a. Remove the line that closes the drawer, open About, press back | | | |

Put the line back. Run `flutter test test/navigation`.

<details><summary>Step-by-step help</summary>

In `AppDrawer` (`lib/navigation/app_shell.dart`), add two `ListTile`s.
Each `onTap` first closes the drawer with `Navigator.pop(context)`, then
calls `context.push(...)`. Then add `const Divider()` and
`AboutListTile(icon: ..., applicationName: 'Campus Companion',
applicationVersion: '0.4.0')`.

</details>

### Task 6 — Return a result

**AI-use level:** 2 — Review. Write it yourself first. Then you may ask
an assistant to review your code; record what it found in your AI note.

Requirements:

- *Edit profile* on the profile opens `EditProfileScreen` at
  `Routes.editProfile`, above the bottom bar. The current name travels in
  the address as the query parameter `name`, and the text field starts
  with it.
- *Save* returns the trimmed name to the profile, which then shows it.
  *Cancel* or back returns nothing, and the old name stays.
- A name with a space or Amharic letters must survive the trip through
  the address.

The worked example is `LoansPage` and `ChooseDeskPage`.

Fill in the **Prediction** column, then try it in Chrome.

| Step | Prediction | What you saw | Same? |
|---|---|---|---|
| a. Edit the name to `Hana Tadesse`. What does the address end with on the edit page the next time you open it? | | | |
| b. Open the edit page and press back. What does `push` return? | | | |

Run `flutter test test/navigation`.

<details><summary>Step-by-step help</summary>

1. In `router.dart`, add a nested `GoRoute(path: 'edit')` under Profile,
   with `parentNavigatorKey: rootNavigatorKey`, that builds
   `EditProfileScreen(initialName: state.uri.queryParameters['name'] ??
   '')`.
2. In `EditProfileScreen._save`, return the name with `context.pop(name)`.
3. In `ProfileScreen._edit`, build the location with
   `Uri(path: Routes.editProfile, queryParameters: {'name': _name})`,
   `await context.push<String>(uri.toString())`, and if the result is not
   null and the widget is still `mounted`, call `setState` with the new
   name.

</details>

### Task 7 — Upcoming and Past tabs

**AI-use level:** 1 — Explain only.

The events feed has two tabs, *Upcoming* and *Past*. An event belongs to
a tab according to `event.isUpcoming(now: clock)`. An empty tab shows
*No upcoming events* or *No past events*. The screen stays a
`StatelessWidget`. The worked example is `BooksPage`.

<details><summary>Step-by-step help</summary>

In `EventsScreen.build`, make two lists, `upcoming` and `past`. Return a
`DefaultTabController(length: 2)` around a `Column` of a `TabBar` (two
`Tab`s) and an `Expanded` `TabBarView` with one `_EventList` for each
tab.

</details>

Run `flutter test`.

**Self-check 3:** write in `predictions.md` what happens if you remove the
`Expanded` around the `TabBarView`. Try it and put it back.

### Task 8 — Your own design: where does Settings go?

**AI-use level:** 1 — Explain only. The decisions are the skill this task
trains, and you defend them at Checkpoint B, so they must be yours. You
may ask an assistant what a class does or what an error means.

Campus Companion gets a Settings screen in week 8. Here you decide where
it goes, in a small app with the same shape: three tabs, an app bar and a
drawer, in `lib/exercises/settings_design.dart`. `SettingsPage` and the
path `DesignRoutes.settings` are given.

> Settings must be reachable from every tab and must hide the bottom bar.

1. **Decide (Minimum).** Write `DECISIONS.md` with two decisions and one
   reason for each:
   1. How does the user open Settings: from the drawer, from the bottom
      bar, from a tab, or from somewhere else?
   2. Is the Settings route on the root navigator or on a branch
      navigator?
2. **Implement (Minimum).** Make your decisions work. The entry that
   opens Settings has the tooltip or the text *Settings*.

   ```bash
   flutter run -d chrome -t lib/exercises/settings_design.dart
   flutter test test/exercises/settings_design_test.dart
   ```

   The tests check the requirement, not your design: from each tab,
   Settings opens without the bottom bar, and back returns to the same
   tab.

<details><summary>Step-by-step help</summary>

- Look at the "Which widget?" table in the notes, section 4. Which row
  describes Settings?
- A destination in the bottom bar is a tab, and a tab shows the bar.
- A route outside the `StatefulShellRoute` goes on the root navigator.
  A route inside a branch goes on that branch's navigator unless it has
  `parentNavigatorKey`.
- Use `context.push` so that back returns to the tab the user came from.

</details>

**Checkpoint B (TA, Minimum: Task 6 and Task 8):** show the edit-profile
flow with a name that has a space, the tabs, the drawer, your
`DECISIONS.md` and Settings opening from every tab. The TA reads your AI
note and points at one line, for example `if (!mounted || result == null)
return;` in `_edit`, or the line that closes the drawer, and asks *what
happens if I remove this line?* Write your prediction, then try it. The TA
may also ask *why did you not put Settings in the bottom bar?*

### Task 9 — Extra task

**AI-use level:** 2 — Review.

Add a `redirect` to the router that sends `/` to `/events`, and make
tapping the *current* tab again scroll the feed to the top (a
`ScrollController` in the list, plus `goBranch(initialLocation: true)`).

## If you are stuck

Try each level in order, and stop as soon as you can continue.

**Task 1 — the named routes**
1. *Question:* `/events/42` is not a key of the `routes` map. Which
   function does `MaterialApp` call for it?
2. *Steps:* (1) find the `routes` map; (2) find `onGenerateRoute`; (3) in
   `generateDemoRoute`, follow `/events/42` line by line and write the
   value of `segments`, `id` and `event`.
3. *Look at:* the test "starting at /events/42 builds three routes" in
   `test/exercises/named_routes_demo_test.dart`.

**Task 4 — the tests**
1. *Question:* how do you start the app at a given location in a test?
2. *Steps:* (1) call `pumpApp(tester, initial: '/events/nope')`; (2)
   expect the text; (3) copy the test for an unknown location and change
   the location and the text.
3. *Completion:* fill in the two blanks.
   ```dart
   testWidgets('deep link to an unknown id shows not found', (tester) async {
     ________________;
     ________________;
   });
   ```

**Task 4 — the route**
1. *Question:* in `createLibraryRouter`, what makes the book page cover
   the bar, and what does the builder do when no book matches?
2. *Steps:* (1) add `routes:` to the Events `GoRoute`; (2) add the `:id`
   route with `parentNavigatorKey`; (3) read the id and find the event, or
   `null`; (4) add `errorBuilder` to the `GoRouter`.
3. *Look at:* the `:isbn` route has the same three parts.

**Task 6 — the result**
1. *Question:* what does `context.push<String>(...)` return when the user
   presses back?
2. *Steps:* (1) the `edit` route that reads the query parameter; (2)
   `context.pop(name)` in `_save`; (3) build the `Uri`, `await` the push,
   check `mounted` and `null`, then `setState`.
3. *Completion:* fill in the two blanks.
   ```dart
   Future<void> _edit() async {
     final uri = Uri(path: Routes.editProfile, queryParameters: {'name': _name});
     ________________;
     ________________;
     setState(() => _name = result);
   }
   ```

**Task 8 — Settings**
1. *Question:* which part of the app is the same on every tab: the app
   bar, the drawer, the bottom bar, or all three?
2. *Steps:* (1) choose the entry; (2) choose the navigator; (3) write
   `DECISIONS.md`; (4) add the route; (5) add the entry; (6) run the tests.
3. *Look at:* `/hours` in `createLibraryRouter` is a route outside the
   shell, and `LibraryDrawer` opens it.

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
| **Checkpoint A** — Task 1 table filled in before running; detail with toolbar; four tabs; `/events/<id>` above the bar; not-found and error page; correct prediction for "what happens if I remove this line?" | 0 | 2 | 3 |
| **Checkpoint B** — edit profile returns a result, also with a space in the name; drawer and tabs; Settings from every tab without the bar, with two decisions and reasons in `DECISIONS.md`; AI note | 0 | 2 | 3 |
| **Test written first and seen failing (show the TA)** — the Task 4 not-found tests | 0 | 1 | 2 |
| **Exit task** (marked 0–2 by the TA from the key) | | | |

*Next step (written by the TA):* ______________________________

## AI note

Add a file `AI_NOTE.md` with three lines. The TA reads it at Checkpoint B.

1. Which task did you use an assistant for (or "none")?
2. What did it get wrong, or what did you not understand?
3. What did you check yourself, and how?

## Reflection

Add a file `REFLECTION.md` with two lines. Write it alone.

1. One topic from weeks 1–4 that you can explain without an assistant.
2. One topic that you cannot explain yet, and whether you used an
   assistant in this lab.

## Submit

Lab work is individual. Push your lab work, `predictions.md`,
`DECISIONS.md`, `AI_NOTE.md` and `REFLECTION.md` to `week04/` of your
lab repository by the start of the next lab.

Make at least one commit for each required task, with the week and the
task in the message, for example `feat(week04): task 2 <what changed>`,
and push. Before the deadline, run `dart tool/check_lab_commits.dart
../mad-labs-UGR-XXXX-YY 04` from the root of the course repository. Your
work is collected from GitHub at the start of the next lab. A required
task without a commit costs 1 of the 10 rubric points (see
`guides/lab-repository.md`).
