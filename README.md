# Mobile Applications Development

Teaching repository for the B.Sc. Computer Science course *Mobile Applications
Development* at Addis Ababa University. Lectures, interactive slides, labs,
quizzes, a running example app and a group-project kit — all built on
**Flutter 3.47.7** (Dart 3.13.5).

**Slides (GitHub Pages):** https://betsegawlemma.github.io/mobile-application-development-course/

| | |
|---|---|
| Instructor | Betsegaw Lemma · betsegawlemma@gmail.com |
| Format | 14 weeks · 2 h lecture + 3 h lab per week |
| Assessment | Mid exam 30 % · Group project 30 % · Final exam 40 % |
| Syllabus | [syllabus/syllabus.md](syllabus/syllabus.md) · [schedule](syllabus/schedule.md) · [policies incl. AI use](syllabus/policies.md) |
| Project | [project/](project/) |
| Coverage of the outline | [syllabus/coverage-matrix.md](syllabus/coverage-matrix.md) |

## Weeks

Each week's notes, slides, lab instructions and quiz appear just before
its lecture.

| Wk | Topic | Materials |
|---|---|---|
| 1 | Mobile landscape, Flutter, Dart I | [notes](weeks/week01-intro-dart/README.md) · [slides](https://betsegawlemma.github.io/mobile-application-development-course/week01/) · [lab](weeks/week01-intro-dart/lab/README.md) · [quiz](weeks/week01-intro-dart/quiz.md) |
| 2 | Dart II; widget lifecycle | [notes](weeks/week02-dart-widgets/README.md) · [slides](https://betsegawlemma.github.io/mobile-application-development-course/week02/) · [lab](weeks/week02-dart-widgets/lab/README.md) · [quiz](weeks/week02-dart-widgets/quiz.md) |
| 3 | Layout and common widgets | [notes](weeks/week03-layout/README.md) · [slides](https://betsegawlemma.github.io/mobile-application-development-course/week03/) · [lab](weeks/week03-layout/lab/README.md) · [quiz](weeks/week03-layout/quiz.md) |
| 4 | Navigation | [notes](weeks/week04-navigation/README.md) · [slides](https://betsegawlemma.github.io/mobile-application-development-course/week04/) · [lab](weeks/week04-navigation/lab/README.md) · [quiz](weeks/week04-navigation/quiz.md) |
| 5 | State management and architecture | *available before the lecture* |
| 6 | Testing I | *available before the lecture* |
| 7 | Interactivity | *available before the lecture* |
| 8 | Local persistence · mid exam | *available before the lecture* |
| 9 | Networking and REST | *available before the lecture* |
| 10 | Firebase | *available before the lecture* |
| 11 | Device features | *available before the lecture* |
| 12 | Testing II, CI, quality | *available before the lecture* |
| 13 | Responsible AI | *available before the lecture* |
| 14 | Release, accessibility, i18n | *available before the lecture* |

## Guides

Cross-cutting references used throughout the course:

| Guide | About |
|---|---|
| [architecture.md](guides/architecture.md) | the feature-first structure and its layers |
| [state-management-comparison.md](guides/state-management-comparison.md) | Provider, Riverpod, BLoC compared |
| [testing-strategy.md](guides/testing-strategy.md) | what to test, at which level |
| [ai-assisted-development.md](guides/ai-assisted-development.md) | using AI assistants, and building AI features |
| [code-review-checklist.md](guides/code-review-checklist.md) | for pull requests and before submitting |
| [git-workflow.md](guides/git-workflow.md) | branches, commits, pull requests, tags |
| [lab-repository.md](guides/lab-repository.md) | your private lab repository and one commit per lab task |
| [troubleshooting.md](guides/troubleshooting.md) | the errors you will meet, with fixes |
| [glossary.md](guides/glossary.md) | the key terms of every week, in alphabetical order |
| [resources.md](guides/resources.md) | the reference list, annotated by week |

## Student quick start

1. Install Flutter **3.47.7** — follow week 1's lab, or
   https://docs.flutter.dev/install. Confirm with
   `flutter --version`. If you use [fvm](https://fvm.app), the repo pins the
   version in `.fvmrc`; `fvm install` picks it up.
2. Clone this repository and run the week 1 starter:
   ```bash
   git clone https://github.com/betsegawlemma/mobile-application-development-course.git
   cd mobile-application-development-course/weeks/week01-intro-dart/lab/starter
   flutter pub get              # no network: see lab 1, "Without internet"
   flutter run -d chrome        # or an emulator / device
   flutter test
   ```
3. Create your private lab repository, `mad-labs-UGR-XXXX-YY`, as in
   [lab-repository.md](guides/lab-repository.md).
4. Each week: read `weeks/weekNN-*/README.md` before class, open the slides,
   then do the lab from `weeks/weekNN-*/lab/README.md`: copy `lab/starter/`
   into your lab repository with `dart tool/start_lab.dart NN
   ../mad-labs-UGR-XXXX-YY` and commit after each task. Each week's
   material appears just before its lecture, its starter before the lab,
   and its `lab/solution/` after the lab week. The complete example app
   (`capstone/`) appears after week 14.

## Repository layout

```
syllabus/     syllabus, schedule, policies (incl. AI-use policy), coverage matrix
weeks/        one folder per week: README (notes), slides.md (Marp), lab/, quiz.md
capstone/     Campus Companion — the running example app, latest state (released after week 14)
backend/      Dart shelf REST API used from week 9
weeks/week10-firebase/firebase/   Firestore and Storage rules, emulator config, rules tests
project/      group-project kit: proposal template, milestones, rubric
guides/       cross-cutting references: architecture, testing, AI use, troubleshooting, lab repository
labs-template/  README.md and .gitignore to copy into your own lab repository
site/         Pages theme, landing template and build script
tool/         repository checks; start_lab.dart and check_lab_commits.dart for your labs
```

## Contributing

Fixes and improvements are welcome — open an issue or a pull request. Keep
code passing `flutter analyze --fatal-infos` and `flutter test`; keep prose
in British English; excerpt code in notes from a compiling file.

## Licence

Content: [CC BY-SA 4.0](LICENSE-CONTENT). Code: [MIT](LICENSE-CODE).
