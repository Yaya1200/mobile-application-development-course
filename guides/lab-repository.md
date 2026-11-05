# Your lab repository

Lab work is individual. Each student keeps all 14 labs in **one private
GitHub repository of their own**, one folder per week. Your group's
repository is for the project only.

## Name and layout

Name the repository `mad-labs-` followed by your student ID, with `-` in
place of `/` (GitHub does not allow `/` in a repository name):

| Student ID | Repository name |
|---|---|
| `UGR/1234/16` | `mad-labs-UGR-1234-16` |

```
mad-labs-UGR-1234-16/
  README.md      your full name and your student ID, written as UGR/1234/16
  .gitignore     copied from labs-template/
  week01/        the week 1 starter, with your work
  week02/
  …
  week14/
```

Each `weekNN/` folder is a copy of that week's `lab/starter/` with your
changes, plus the files the lab's "Submit" section asks for
(`predictions.md`, `AI_NOTE.md` and others).

## Once, in week 1

1. Create a **private** repository named as above on GitHub, with no
   README, no `.gitignore` and no licence.
2. Clone it **next to** your clone of the course repository, so both are
   in the same parent folder:

   ```bash
   cd <the folder that holds mobile-application-development-course>
   git clone https://github.com/<your-github-name>/mad-labs-UGR-1234-16.git
   ```

   ```
   <parent folder>/
     mobile-application-development-course/   the course (read only for you)
     mad-labs-UGR-1234-16/                    your labs
   ```

3. Copy `labs-template/README.md` and `labs-template/.gitignore` from the
   course repository into your lab repository. In `README.md`, write your
   full name and your student ID in the form `UGR/1234/16`.
4. Set your name and e-mail for this repository, and make the first commit:

   ```bash
   cd mad-labs-UGR-1234-16
   git config user.name "Your Full Name"
   git config user.email "the e-mail of your GitHub account"
   git add README.md .gitignore
   git commit -m "chore: add README and .gitignore"
   git push -u origin main
   ```

5. On GitHub, *Settings → Collaborators*: add the instructor
   (`betsegawlemma`) and your TA.
6. Register the repository link in the lab-repository form (the link is on
   the LMS).

## Every lab

All commands start in the root of the **course** repository.

```bash
git pull                                              # get this week's starter
dart tool/start_lab.dart 05 ../mad-labs-UGR-1234-16   # copies the starter to week05/ and commits it
cd ../mad-labs-UGR-1234-16/week05
flutter pub get
```

`tool/start_lab.dart` refuses to overwrite a `weekNN/` folder that already
exists. Work only in your lab repository: do not edit `lab/starter/` in the
course repository, so that `git pull` keeps working there.

Some labs start a server from the course repository (the REST backend in
`backend/` from week 9). Run those commands in the course repository and the
app in your lab repository, in two terminals.

## One commit per task

**After each required task, make at least one commit whose message names
the week and the task**, and push:

```
<type>(weekNN): task N <what changed>
```

```bash
git add -A
git commit -m "feat(week03): task 2 add EventCard with title, date and place"
git push
```

- `<type>` is one of the types in [git-workflow.md](git-workflow.md):
  `feat`, `fix`, `test`, `refactor`, `docs`, `chore`, `style`.
- A task done in several commits is fine; name the task in each of them.
- One commit counts for one task. If you finish two tasks before you
  commit, make two commits (`git add -p` stages part of a file).
- Commit `predictions.md`, `AI_NOTE.md` and the other files of the lab
  too, for example `docs(week03): predictions and AI note`.
- *Extra* tasks are not required. If you do one, commit it the same way.
- The exit task is on paper and has no commit.
- The last commit of the week must pass `flutter analyze --fatal-infos`
  in `weekNN/`, and the lab's tests must pass, except where the lab says
  that some tests may still fail.

### Check before you submit

From the root of the course repository:

```bash
dart tool/check_lab_commits.dart ../mad-labs-UGR-1234-16 05
```

It lists every required task of the week with the commits that name it,
and reports a missing task, a missing `predictions.md` or `AI_NOTE.md`,
and a missing or wrong student ID in `README.md`.

### Deadline and marking

- Your work is collected from GitHub at the **start of the next lab**.
  What is not pushed by then is not marked. The date of a commit does not
  count, only what is on GitHub.
- If one or more required tasks have no commit, you lose **1 of the 10
  lab-rubric points** for that lab.

## Weeks you did before this rule

If you did some labs before your lab repository existed (in your own
folder or in your group's repository), bring each of them in as follows,
one week at a time:

1. `dart tool/start_lab.dart NN ../mad-labs-UGR-1234-16` (commits the
   untouched starter).
2. For each required task in order, copy in the files that task changed,
   and commit them with that task's message.
3. Copy in `predictions.md`, `AI_NOTE.md` and the other files, commit,
   push, and run the check.

Then delete your `labs/<your-name>/` folder from the group repository.

## Common problems

| Problem | Fix |
|---|---|
| `fatal: not a git repository` from `start_lab.dart` | The second argument must be the folder of your lab repository, for example `../mad-labs-UGR-1234-16` |
| `week05/ already exists` | You already started this lab; `cd` into it |
| `no starter for week 05` | The starter is released before the lab: run `git pull` in the course repository |
| `Please tell me who you are` when committing | Step 4 of "Once, in week 1" |
| The TA cannot open your repository | Step 5: add the instructor and your TA as collaborators |
| You committed with the wrong task number, not pushed yet | `git commit --amend -m "…"` |
| Already pushed | Make a new commit that names the right task |
