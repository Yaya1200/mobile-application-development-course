# Git workflow

How your group should work in one repository without losing work or
blocking each other. This is what the *Process* part of the project
rubric assesses.

## Once, at the start

```bash
git clone https://github.com/<group>/<project>.git
cd <project>
git config user.name "Your Name"
git config user.email "you@example.com"
```

Add the instructor and TAs as collaborators. Protect `main` in the
repository settings: *Settings → Branches → Add rule* — require a pull
request and a green CI run before merging. This is one setting and it
prevents most of the accidents below.

## The loop

```bash
git switch main
git pull                                   # start from what is on the server
git switch -c feature/notes-search         # a branch per piece of work

# … work, committing as you go …
git add -p                                 # review what you are staging
git commit -m "feat(notes): filter the list by a search query"

git push -u origin feature/notes-search    # then open a pull request
```

Never commit to `main` directly. Never work for three days without
pushing: an unpushed branch is work only you have.

## Branch names

```
feature/lost-found-photos
fix/events-crash-on-empty-list
chore/upgrade-riverpod
docs/release-checklist
```

## Commit messages

Conventional commits — the same style this course repository uses:

```
<type>(<scope>): <what changed, in the imperative>

feat(events): add pull to refresh
fix(notes): keep the note when the editor is cancelled
test(auth): cover the wrong-password path
refactor(core): move AppException into core/network
docs(readme): describe the backend set-up
chore(deps): upgrade drift to 2.31
```

Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `style`.

**Lab commits** use the week as the scope and name the task first, so
that `tool/check_lab_commits.dart` can find one commit for each task
(see [lab-repository.md](lab-repository.md)):

```
feat(week05): task 3 move the counter into a Notifier
test(week06): task 2 add the failing tests for Notes.duplicate
docs(week05): predictions and AI note
```

A good message says **what changed**, and the body says **why** when it
is not obvious. "fix stuff", "update", "asdf" tell a reviewer — and you,
in three weeks — nothing.

## Pull requests

- One topic per pull request. A refactor and a feature go separately.
- Under about 400 lines where you can manage it.
- The description says what changed, how it was tested, and what you are
  unsure about.
- Link the issue or milestone it belongs to.
- Run `flutter analyze --fatal-infos` and `flutter test` before you ask
  for a review. Once the group has CI (after week 12), CI must be green.
- Every member reviews; see `code-review-checklist.md`. Per milestone,
  each member authors at least one merged pull request and reviews at
  least one pull request by another member (`../project/rubric.md`,
  Process).
- Merge with a **merge commit**, not squash. A merge commit keeps each
  member's own commits in the history of `main`; the TA uses that history,
  with the oral checks and the peer evaluation, for individual marks.
  Squash merging would replace them with one commit and hide who did
  what.

## Conflicts

They are normal. To reduce them: small branches, merged often, and an
agreement about who is working in which feature folder this week.

```bash
git switch feature/mine
git fetch origin
git rebase origin/main        # replay your commits on the latest main
# fix each conflict, then:
git add <file>
git rebase --continue
git push --force-with-lease   # never plain --force
```

`--force-with-lease` refuses if someone else pushed in the meantime;
`--force` would overwrite their work.

If a rebase goes wrong: `git rebase --abort` returns you to where you
started. Nothing is lost.

## Generated files

This project commits `*.g.dart`, `*.freezed.dart` and the localisation
output, so classmates and CI need no code generation to build. That
means:

- run `dart run build_runner build -d` **before** committing a change to
  an annotated file;
- when a merge conflicts inside a generated file, do not resolve it by
  hand — take either side, then regenerate and commit the result.

CI checks this by regenerating and failing if `git diff` is not empty.

## Never commit

- `android/key.properties`, `*.jks`, `*.keystore`
- `google-services.json` or `GoogleService-Info.plist` for a project
  that is not yours
- API keys, tokens, `.env` files
- `build/`, `.dart_tool/`, coverage output
- Large binaries that are not needed to build

If a secret is committed, it is in the history: **change the secret**,
do not only delete the file.

## Tags and releases

```bash
git tag -a m1 -m "Milestone 1: screens, navigation, state"
git push origin m1
```

The project milestones (`m1`, `m2`, `final`) are tags. Attach the signed
build to the `final` release on GitHub.

## Recovering

| Situation | Command |
|---|---|
| Committed to `main` by mistake, not pushed | `git switch -c feature/x` then `git switch main && git reset --hard origin/main` |
| Last commit has the wrong message | `git commit --amend` (before pushing) |
| Need to undo a pushed commit | `git revert <sha>` — a new commit that undoes it |
| Lost a branch | `git reflog` — it is almost certainly still there |
| Want to set work aside | `git stash` / `git stash pop` |

Almost nothing in git is unrecoverable if it was committed. The one
thing that is: work that was never committed.

## Further reading

- Conventional commits: https://www.conventionalcommits.org
- GitHub flow: https://docs.github.com/en/get-started/using-github/github-flow
- `git help <command>` — better than most tutorials
