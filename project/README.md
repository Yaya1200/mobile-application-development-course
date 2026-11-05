# Group project

The project is 30 % of your course mark. In groups of four you design,
build, test and present a Flutter application over the semester, applying
each week's topic as it is taught.

## Timeline

| Deliverable | Due | Weight within the project |
|---|---|---|
| Group registration | End of week 2 | — |
| [Proposal](proposal-template.md) | Sunday 8 November 2026 (week 4) | 10 % |
| [Milestone 1](milestones.md#milestone-1--screens-navigation-state) — screens, navigation, state | End of week 6 | 15 % |
| [Milestone 2](milestones.md#milestone-2--data-backend-tests) — data, backend, tests | End of week 10 | 15 % |
| Final submission | End of week 14 | 45 % |
| [Presentation](presentation-guidelines.md) | Week 15 | 15 % |

Exact dates are in `../syllabus/schedule.md` once the term calendar is
published.

## Registration and submission

Everything about your project lives in your group's GitHub repository
(one per group). Add the instructor and the TAs as collaborators if the
repository is private.

- **Register** by the end of week 2:
  1. copy [project-template.yaml](project-template.yaml) to the root of
     your repository as `project.yaml`, and fill in the title, the
     one-sentence summary and the four members (name, student ID, email,
     GitHub username);
  2. push it to the `main` branch;
  3. one member submits the repository link in the registration form
     given in the course announcement.

  The course reads `project.yaml` with a program: keep every key as it
  is spelled in the template, and keep the file up to date when the
  title or a member changes.
- **Proposal** by Sunday 8 November 2026: the completed
  `proposal-template.md`, committed as `PROPOSAL.md` in the root of your
  repository, with the tag `proposal` on that commit.
- **Milestones and final submission**: in the same repository. Each milestone is a
  Git tag (`m1`, `m2`, `final`) plus a short `MILESTONE.md` in the
  repository root describing what was done and by whom (see
  [milestones.md](milestones.md)).
- **Labs** are not part of the group repository. Lab work is
  individual: each member keeps it in their own private lab repository
  (see `guides/lab-repository.md`).

## What a passing final submission contains

- A Flutter app built with the course toolchain (Flutter 3.47.7, Riverpod,
  feature-first structure) that runs on Android and passes
  `flutter analyze --fatal-infos`.
- At least four screens with navigation (`go_router`).
- Application state in Riverpod providers, immutable models (`freezed`).
- **Local persistence** and **two remote data sources** — a REST web
  service **and** Firebase (Auth and Cloud Firestore) — each behind a
  repository interface.
- **One device feature** (camera, location or a sensor) with every
  permission outcome handled, **and one AI feature** behind an interface
  with consent and disclosure.
- Unit tests, widget tests and at least one integration test, all passing
  in GitHub Actions, with line coverage of at least 60 %.
- A `README.md` with screenshots, setup steps, architecture overview and
  a feature list; an `AI_USAGE.md` (template in
  [AI_USAGE-template.md](AI_USAGE-template.md)); `PRIVACY.md` with a
  data-safety table; `USER_TEST.md`.
- Two build flavours, `development` (Firebase emulators and a local or
  test REST server) and `production` (the real endpoints), each with its
  own application id.
- A signed release build (`.apk` or `.aab`) of the production flavour
  attached to the final tag.

The full marking scheme is in [rubric.md](rubric.md).

## Choosing a project

Read [project-ideas.md](project-ideas.md) for fifteen ideas with local
relevance and an indication of scope. Choose something a real person you
know would use; you will be asked to demonstrate it to such a person
before the presentation. Ambition is good, but a small app that works
completely scores higher than a large app that half works.

## Working as a group

- Every member commits code. In each milestone, every member authors at
  least one merged pull request and reviews at least one pull request by
  another member.
- Individual marks come from the individual oral checks
  ([milestones.md](milestones.md)), the anchored
  [peer evaluation](peer-evaluation.md) and the commit history; the
  formula is in [rubric.md](rubric.md).
- Use branches and pull requests, and merge with a merge commit, not
  squash, so that each member's history is kept; the `main` branch must
  always build. See `../guides/git-workflow.md`.
- Meet weekly. Keep a short log of decisions in `DECISIONS.md`.

## Getting help

Technical questions go to the repository's GitHub Discussions so that other
groups benefit. Group problems (a member not contributing) should be raised
with the instructor early, not at the end.
