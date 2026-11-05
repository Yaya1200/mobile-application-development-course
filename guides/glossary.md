# Glossary

The key terms of the course in one list, in alphabetical order. Each
entry gives a short definition and the week, or weeks, whose notes
introduce the term; the link opens that week's "Key terms" list. When a
term appears in several weeks, the definition here is the clearest of
them.

## A

- **accelerometer** — The sensor that measures acceleration on three axes, including gravity (about 9.8 m/s²). (week 11)
- **AI-use level** — The number under a lab task heading (0–3) that says how much help from an assistant the task allows. ([week 1](../weeks/week01-intro-dart/README.md#key-terms), week 13)
- **app bundle (`.aab`)** — The file a store expects; the store builds the APK for each device from it. (week 14)
- **app state** — State that many widgets, on several screens, need; it lives above them, in a provider. (week 5)
- **`AppLifecycleListener`** — A Flutter class that reports when the app goes to the background and comes back. (week 11)
- **ARB file** — A JSON file with the app's messages in one language, plus a description of each. (week 14)
- **arrange, act, assert** — The three steps of a test: set up, do one thing, check the result. (week 6)
- **artifact** — A file that a workflow run keeps for you to download, such as a coverage report or new golden images. (week 12)
- **asset** — A file (image, font, data) bundled into the app and declared in `pubspec.yaml`. ([week 3](../weeks/week03-layout/README.md#key-terms))
- **`async` / `await`** — Mark a function that returns a `Future` / wait for a `Future` inside it without blocking the thread. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))
- **`AsyncValue`** — The value of an asynchronous provider: loading, data or error. (week 5)

## B

- **backend-as-a-service (BaaS)** — A service that gives an app accounts, a database and file storage without a server of your own. (week 10)
- **boundary** — The value where a rule changes, such as `max` in "from 1 to `max`"; test the boundary and the value just past it. (week 6)
- **branch** — One section of a `StatefulShellRoute`, with its own navigator and back stack (not a Git branch). ([week 4](../weeks/week04-navigation/README.md#key-terms))
- **breakpoint** — The width at which a layout changes, for example from a list to a grid at 600 pixels. ([week 3](../weeks/week03-layout/README.md#key-terms))

## C

- **closed test** — A store release to a fixed list of testers before the app is public. (week 14)
- **cloud inference** — Sending the text to a server that runs the model and returns the result. (week 13)
- **code generation** — A tool (`build_runner`) that writes Dart code, such as `*.g.dart` and `*.freezed.dart` files, from your annotations. (week 5)
- **collected (data)** — In a store's data-safety form, data that leaves the phone. (week 14)
- **collection** — A group of documents, such as `lost_found`. (week 10)
- **companion** — The class drift generates for inserts and updates, in which every field is optional. (week 8)
- **consent** — The user's agreement, asked before their text is sent off the device. (week 13)
- **constraints** — The minimum and maximum width and height that a parent gives its child. ([week 3](../weeks/week03-layout/README.md#key-terms))
- **continuous integration (CI)** — A server that runs the team's checks on a clean machine for every push. (week 12)
- **cool-down** — A time after an event during which new readings are ignored, so that one shake gives one event. (week 11)
- **`copyWith`** — A method that returns a copy of an object with some fields changed. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))
- **coverage** — Which lines of code ran during the tests; it does not show whether their results were checked. (week 6)
- **coverage floor** — The lowest coverage the pipeline accepts; below it, the job fails. (week 12)

## D

- **data-safety form** — The store's questions about what the app collects, why, where it is stored and how to delete it; the answers must match the code. (week 14)
- **deep link** — An address that opens a screen inside the app directly, for example from a browser, an email or a QR code. ([week 4](../weeks/week04-navigation/README.md#key-terms))
- **default value** — The value a read returns when nothing is stored yet. (week 8)
- **denormalise** — Store a copy of a value (such as the author's name) in each document that shows it, so a list needs no second read. (week 10)
- **dependency rule** — Presentation depends on data, data depends on domain, never the other way round. (week 5)
- **derived provider** — A provider that computes its value from other providers, such as a sorted copy of a list. (week 5)
- **DevTools** — Flutter's tools for inspecting and measuring a running app. (week 12)
- **disclosure** — A label next to a result that says it was produced by a machine and should be checked. (week 13)
- **dismissible** — A widget the user can swipe away; the app must then remove the item from its data. (week 7)
- **document** — One record in Firestore: a map of fields with an id. (week 10)
- **download URL** — The address that Firebase Storage gives for a file; the app stores it and shows the image from it. (week 11)
- **drag target** — A widget that accepts or refuses the value of a draggable dropped on it. (week 7)
- **draggable** — A widget the user can pick up that carries a value. (week 7)
- **DTO (data transfer object)** — A class with the exact shape of the JSON on the wire, kept apart from the app's domain model. (week 9)

## E

- **element** — The long-lived object that holds a widget's place in the tree and, for a `StatefulWidget`, its `State`. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))
- **ellipsis** — The "…" that replaces the end of a text that does not fit. ([week 3](../weeks/week03-layout/README.md#key-terms))
- **Emulator Suite** — Programs that run Firebase Authentication, Firestore and Storage on your computer, with no project and no internet. (week 10)
- **endpoint** — One path and method of an API, such as `GET /events/{id}`. (week 9)
- **enhanced enum** — An enum whose values have fields and a constructor. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))
- **ephemeral state** — State that only one widget needs, such as the text in a field; it stays in the widget, with `setState`. (week 5)
- **error page** — The page the router shows for an address that matches no route. ([week 4](../weeks/week04-navigation/README.md#key-terms))
- **extension method** — A method added to an existing type with `extension ... on`. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))

## F

- **fake** — A simple, working replacement for a dependency, such as an in-memory repository. (week 6, week 11)
- **fake adapter** — A replacement for dio's network layer in tests; it returns any status or body without a server. (week 9)
- **family** — A provider that takes a parameter and keeps one value for each different argument. (week 5)
- **faulty version** — A copy of the code with one small, deliberate mistake, used to check that the tests fail on it. (week 6)
- **feature-first** — Folders grouped by feature (events, notes), each split into presentation, domain and data layers. (week 5)
- **feedback** — The widget that follows the finger during a drag. (week 7)
- **`final` / `const`** — Set once at run time / fixed when the program is compiled. ([week 1](../weeks/week01-intro-dart/README.md#key-terms))
- **Firebase Storage** — The Firebase service that stores files such as photos. (week 11)
- **flavour** — One variant of the app built from the same code, with its own application id, name and settings (development, staging, production). (week 14)
- **flex** — The share of the remaining space that an `Expanded` or `Flexible` child gets. ([week 3](../weeks/week03-layout/README.md#key-terms))
- **focus node** — An object that holds and moves the keyboard focus between fields. (week 7)
- **frame** — One picture on the screen; at 60 frames per second each must be ready within about 16 ms. (week 12)
- **`Future`** — A value that will be ready later. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))

## G

- **generated code** — Code that a tool such as `build_runner` writes from your annotations; you read it but do not edit it. (week 8)
- **generic** — A class or function with a type parameter, such as `<T>`. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))
- **gesture arena** — The place where recognisers that want the same pointer compete until one wins. (week 7)
- **gesture recogniser** — An object that turns pointer events into one gesture, such as a tap or a drag. (week 7)
- **getter** — A method written `get name` that callers use like a field. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))
- **golden image** — The stored image that a golden test compares with. (week 12)
- **golden test** — A test that compares the pixels of a widget with a stored image. (week 12)
- **graceful failure** — When the model fails, the screen shows a message and still works, and the user's data is unchanged. (week 13)
- **GraphQL** — An API style in which the client asks for exactly the fields it needs in one query. (week 9)
- **guard** — A helper that runs a request and converts every low-level failure into the app's own error type. (week 9)

## H

- **hallucination** — Text from a model that states something false or something that was not in its input. (week 13)
- **header** — A name and a value sent with a request or a response, such as `content-type: application/json`. (week 9)
- **hit test** — The search for the widgets under a touch; by default only painted pixels count. (week 7)
- **hot reload** — Puts changed code into the running app and rebuilds the widgets; state is kept. ([week 1](../weeks/week01-intro-dart/README.md#key-terms))
- **hot restart** — Restarts the app from `main()`; state is lost. ([week 1](../weeks/week01-intro-dart/README.md#key-terms))
- **HTTP method** — The verb of a request: `GET` reads, `POST` creates, `PUT` replaces, `PATCH` changes part, `DELETE` removes. (week 9)

## I

- **ICU plural** — A message with one form for each number case (`=0`, `=1`, `other`), so each language can count in its own way. (week 14)
- **immutable** — An object that cannot change after it is created; you make a changed copy instead. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms), week 5)
- **implicit animation** — A widget that animates by itself from the old value of a property to the new one. (week 7)
- **inherited widget** — A widget high in the tree that widgets below it can find through `context`, as `Theme.of(context)` does. (week 5)
- **initialiser list** — The part after `:` in a constructor; it sets `final` fields before the body runs. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))
- **initialising formal** — `this.name` in a constructor's parameter list; it sets the field directly. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))
- **integration test** — A test that runs the whole app on a device or an emulator, with the real plugins and storage. (week 6, week 12)
- **`IntegrationTestWidgetsFlutterBinding`** — The binding that lets a `testWidgets` test run inside the real app on a device. (week 12)
- **interceptor** — Code that dio runs on every request, response and error, for example to log them or to add a token. (week 9)
- **invented API** — A class, method or parameter that an assistant names but that does not exist in the package version you use. (week 13)
- **ISO-8601** — The standard text form of a date and time, such as `2026-10-02T14:05:00.000Z`. (week 8)
- **iterable** — A sequence you can loop over; `where` and `map` return a lazy one. ([week 1](../weeks/week01-intro-dart/README.md#key-terms))

## J

- **job** — A group of steps that runs on one machine (a *runner*). (week 12)
- **JSON** — A text format with objects, arrays, strings, numbers, booleans and `null`. (week 8)

## K

- **key** — An identity for a widget that tells Flutter which element and state belong to it when a list changes. (week 7)
- **keystore** — The file that holds the private key that signs every release; the same key must sign every update. (week 14)
- **key–value storage** — Storage that keeps one value under one name, such as `shared_preferences`. (week 8)

## L

- **lifecycle callback** — A `State` method Flutter calls at a fixed moment: `initState`, `didChangeDependencies`, `build`, `didUpdateWidget`, `dispose`. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))
- **line coverage** — The share of code lines that the tests ran. (week 12)
- **locale** — The language and region that decide how dates and numbers are written. (week 8)
- **locale fallback** — The language the app uses when the device's language is not supported. (week 14)
- **location service** — The device-wide setting that switches location on or off, separate from the app's permission. (week 11)
- **loose constraint** — The minimum is 0, so the child may be smaller than the maximum. ([week 3](../weeks/week03-layout/README.md#key-terms))

## M

- **magnetometer** — The sensor that measures the magnetic field on three axes; a compass is computed from it. (week 11)
- **magnitude** — The length of a reading as a vector, √(x² + y² + z²). (week 11)
- **main axis / cross axis** — For a `Row`, horizontal / vertical; for a `Column`, vertical / horizontal. ([week 3](../weeks/week03-layout/README.md#key-terms))
- **matcher** — The second argument of `expect`, which says what the value must be, such as `isNull` or `contains('x')`. (week 6)
- **migration** — The code that changes an existing database from an old schema to the new one without losing its data. (week 8)
- **mixin** — A group of methods and fields that a class adds with `with`. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))
- **mock** — A replacement that returns what the test tells it to and records how it was called (`mocktail`). (week 6)
- **`mounted`** — True while the `State` is in the tree; check it after an `await`. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))
- **mutation testing** — Running the tests against many faulty versions to see which faults no test catches. (week 6)

## N

- **named route** — A route chosen by a name such as `/events`, looked up in `MaterialApp.routes` or built by `onGenerateRoute`. ([week 4](../weeks/week04-navigation/README.md#key-terms))
- **navigator** — The widget that holds a stack of routes and shows the top one. ([week 4](../weeks/week04-navigation/README.md#key-terms))
- **notifier** — A class that holds a provider's state and has the methods that replace it. (week 5)
- **null safety** — A variable can hold `null` only if its type ends in `?`. ([week 1](../weeks/week01-intro-dart/README.md#key-terms))

## O

- **object pattern** — `CashPayment(:final amount)`: matches a type and takes out its fields. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))
- **offline** — The phone cannot reach the Firestore server; reads and writes use the copy on the phone until the connection returns. (week 10)
- **on-device inference** — Running a model on the phone, so the text never leaves it. (week 13)
- **OpenAPI** — A file format that describes an API's endpoints, parameters, bodies and status codes; the contract between client and server. (week 9)
- **overflow** — A child is larger than the space its parent has; Flutter draws yellow and black stripes and reports an error. ([week 3](../weeks/week03-layout/README.md#key-terms))
- **override** — A replacement for a provider in one `ProviderScope` or `ProviderContainer`, used in tests. (week 5, week 6)

## P

- **pagination** — Getting a long list in pages, with `page` and `limit`, until `total` items have arrived. (week 9)
- **`part` file** — A file joined to another file so that both form one library and can use each other's private names. (week 5)
- **path parameter** — A part of the path that changes, such as the `42` in `/events/42`, written `:id` in a `go_router` path. ([week 4](../weeks/week04-navigation/README.md#key-terms))
- **pending write** — A write that is on the phone but not yet confirmed by the server. (week 10)
- **permanently denied** — The user chose "don't ask again"; a new request shows no dialog, and only the system settings can change it. (week 11)
- **permission** — The user's consent for an app to use protected data or hardware, such as the camera or location. (week 11)
- **`permission-denied`** — The code Firestore reports when a rule denies a request. (week 10)
- **`PermissionBlockedException`** — The app's exception for a permanently refused permission; the screen answers it with *Open settings*. (week 11)
- **placeholder** — A named gap in a message, such as `{title}`, filled in by the code. (week 14)
- **pointer event** — One raw touch event: down, move or up, with a position. (week 7)
- **primary key** — The column whose value is different in every row, such as a note's id. (week 8)
- **privacy policy** — A text for users that says what the app collects, why, where it is stored, and how to delete it. (week 14)
- **profile build** — A build that is optimised like a release build but can still be measured with DevTools. (week 12)
- **prompt injection** — Text in the data (a note, a web page) that tries to give the model new instructions. (week 13)
- **provider** — A global value that tells Riverpod how to create a piece of state and lets widgets and tests find it. (week 5)
- **`ProviderScope`** — The widget at the root of the app that stores the state of every provider. (week 5)
- **pump** — Telling the test renderer to build the next frame. (week 6)
- **push / pop** — Put a route on top of the stack / remove the top route. ([week 4](../weeks/week04-navigation/README.md#key-terms))

## Q

- **query** — A statement that reads or changes rows: select, insert, update or delete. (week 8)
- **query parameter** — A `name=value` pair after the `?` in an address. ([week 4](../weeks/week04-navigation/README.md#key-terms))

## R

- **rebuild** — Flutter calling a widget's `build` method again. (week 12)
- **red / green / refactor** — The three steps of TDD: the test fails, the test passes, the code is improved while the tests still pass. (week 6)
- **redirect** — A function in `go_router` that runs before every navigation and can send the user to another location. (week 10)
- **relational database** — Data in tables with rows and columns, queried with SQL; SQLite on a phone. (week 8)
- **repository** — A class behind an interface that hides where the data comes from. (week 5)
- **`request.auth`** — Who sends the request; `null` when signed out. (week 10)
- **`request.resource.data`** — The document as it will be after the write. (week 10)
- **`resource.data`** — The document as it is stored now. (week 10)
- **responsive layout** — A layout that changes with the space it has. ([week 3](../weeks/week03-layout/README.md#key-terms))
- **restart (in a test)** — Building the app again with a new `ProviderScope`, so that every provider is created again and reads from storage. (week 12)
- **result** — The value a page returns with `pop(value)` to the code that pushed it and is waiting with `await`. ([week 4](../weeks/week04-navigation/README.md#key-terms))
- **ripple (ink splash)** — The spreading highlight that `InkWell` and `InkResponse` paint on a `Material` when touched. (week 7)
- **root navigator** — The navigator at the top of the app, above the shell; a route on it covers the bottom bar. ([week 4](../weeks/week04-navigation/README.md#key-terms))
- **route** — One page on a navigator's stack, together with its transition. ([week 4](../weeks/week04-navigation/README.md#key-terms))
- **run-time permission** — A permission that Android asks for in a dialog while the app runs, not at installation. (week 11)

## S

- **schema** — The tables and columns of a database. (week 8)
- **schema version** — The number of the schema; the app compares it with the number stored in the database file. (week 8)
- **screen reader** — Software that reads the screen aloud and lets the user act on it with gestures; on Android, TalkBack. (week 14)
- **sealed class** — A class whose subtypes are all in the same file, so a `switch` over it can be checked for missing cases. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms), week 9)
- **security rule** — A condition on the server that allows or denies each read and write. (week 10)
- **semantics label** — The text a screen reader reads for a widget. (week 7)
- **semantics tree** — The description of the screen that Flutter gives a screen reader: labels, roles and actions. (week 14)
- **sensor stream** — A `Stream` of readings from a sensor, many per second. (week 11)
- **serialisation** — Turning an object into text or bytes that can be stored or sent, and back. (week 8)
- **`setState`** — Tells Flutter that the `State` changed, so `build()` runs again. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))
- **severity** — How much a problem stops a user: blocks use, makes use harder, or minor. (week 14)
- **shell** — The frame that stays on screen around several sections, here the app bar, the drawer and the bottom bar. ([week 4](../weeks/week04-navigation/README.md#key-terms))
- **sideloading** — Installing an APK directly, not from a store, after allowing "install unknown apps". (week 14)
- **silent replacement** — Changing the user's own text to the model's output without the user choosing it. (week 13)
- **snapshot** — The state of a future that `FutureBuilder` passes to its builder: waiting, with data, or with an error. (week 8)
- **`snapshots()`** — The method that returns a query as a stream: the current documents at once, then a new list on every change. (week 10)
- **`State`** — The object that keeps a `StatefulWidget`'s changing values between rebuilds. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))
- **`StatefulShellRoute.indexedStack`** — The `go_router` shell that keeps every branch in the tree, hidden or shown. (week 11)
- **`StatefulWidget`** — A widget with a `State` object that keeps values between rebuilds. ([week 1](../weeks/week01-intro-dart/README.md#key-terms))
- **`StatelessWidget`** — A widget whose output depends only on its constructor arguments. ([week 1](../weeks/week01-intro-dart/README.md#key-terms))
- **status code** — The three-digit number in a response that says how the request went: 2xx success, 4xx the client's fault, 5xx the server's fault. (week 9)
- **step** — One command or action in a job; a failed step stops the job. (week 12)
- **stub** — The instruction to a mock for what to return: `when(...).thenAnswer(...)`. (week 6)
- **sub-collection** — A collection that belongs to one document, such as the comments of one post. (week 10)
- **switch expression** — A `switch` that produces a value, one case per pattern. ([week 1](../weeks/week01-intro-dart/README.md#key-terms))
- **system message** — The part of a chat request that holds the instruction, kept separate from the user's text. (week 13)

## T

- **tag** — A label on a test (here `golden`) that lets you run or skip a group of tests with `-t` or `-x`. (week 12)
- **tap target** — The area that reacts to a tap; at least 48 × 48 dp. (week 14)
- **test font** — The font of widget tests, in which every letter is a filled box. (week 12)
- **test level** — How much of the app a test runs: unit, widget, integration or golden. (week 12)
- **test-driven development (TDD)** — Writing a failing test first, then the code that makes it pass, then improving the code. (week 6)
- **text scale** — The user's font-size setting, which multiplies every text size in the app. (week 14)
- **`TextTheme` / `ColorScheme`** — The named text styles and colours of the app's theme, read with `Theme.of(context)`. ([week 3](../weeks/week03-layout/README.md#key-terms))
- **threshold** — The value a reading must reach before it counts. (week 11)
- **tight constraint** — Minimum and maximum are the same, so the child has exactly that size. ([week 3](../weeks/week03-layout/README.md#key-terms))
- **timeout** — The longest time the client waits before it gives up on a request: to connect, or to receive the answer. (week 9)
- **`Timestamp`** — Firestore's type for a point in time; the repository converts it to and from `DateTime`. (week 10)
- **token** — A piece of a word; models read and write tokens, and cloud providers charge per token. (week 13)
- **touch target** — The area that reacts to a touch; at least 48 × 48 logical pixels on Android. (week 7)
- **type inference** — Dart works out a variable's type from its value. ([week 1](../weeks/week01-intro-dart/README.md#key-terms))

## U

- **unbounded** — The maximum is infinity; the child can be as large as it wants in that direction. ([week 3](../weeks/week03-layout/README.md#key-terms))
- **unit test** — A test of one function or class in plain Dart, with no widgets and no device. ([week 1](../weeks/week01-intro-dart/README.md#key-terms), week 6)
- **upsert** — Insert a row, or replace it when a row with the same primary key exists. (week 8)
- **usage description** — The sentence in `Info.plist` that iOS shows in the permission dialog; without it the app crashes. (week 11)

## V

- **validator** — A function that returns an error message for an invalid value, or `null` for a valid one. (week 7)
- **value equality** — Two objects are `==` when their fields are equal, not only when they are the same object. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms))
- **verification checklist** — The list of checks (week 13, section 4) that you run on every answer from an assistant before you keep it. (week 13)
- **verify** — Checking that a mock was called, and how often. (week 6)

## W

- **watch / read** — `ref.watch` subscribes, so the widget rebuilds when the value changes; `ref.read` gets the value once. (week 5)
- **weak test** — A test that also passes on wrong code, because it checks too little. (week 6)
- **WebSocket** — A connection that stays open so that client and server can send messages to each other at any time. (week 9)
- **widget** — An immutable description of part of the user interface. ([week 1](../weeks/week01-intro-dart/README.md#key-terms))
- **widget test** — A test that builds one widget or screen in a test renderer, taps it and checks what it shows. ([week 2](../weeks/week02-dart-widgets/README.md#key-terms), week 6)
- **widget tree** — The widgets of a screen, nested inside each other. ([week 1](../weeks/week01-intro-dart/README.md#key-terms))
- **workflow** — A YAML file in `.github/workflows/` that tells GitHub Actions which jobs to run and when. (week 12)
- **`workflow_dispatch`** — A trigger that lets you start a workflow by hand. (week 12)
