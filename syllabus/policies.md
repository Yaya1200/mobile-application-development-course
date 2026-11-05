# Course policies

## Attendance and participation

Labs are where you learn. Attendance at labs is expected.

- **Lab work is individual.** You may help each other, but each of you
  writes and submits your own lab, in your own private lab repository
  `mad-labs-UGR-XXXX-YY` (your student ID with `-` in place of `/`), one
  folder `weekNN/` per lab. The instructor and your TA are collaborators
  on it. See `guides/lab-repository.md`.
- **At least one commit per task.** After each required task of a lab,
  commit with the week and the task in the message, for example
  `feat(week05): task 3 move the counter into a Notifier`, and push.
  Your lab is collected from GitHub at the start of the next lab; the
  date of a commit does not count, only what is on GitHub. A required
  task without a commit costs 1 of the lab's 10 rubric points.
- **Two TA-signed checkpoints per lab** (one in weeks 7 and 11, when
  TAs hold the milestone oral checks). At each one the TA records one of
  three levels — *Not yet*, *Working*, or *Can explain and change it* —
  and writes one "Next step" line that you can read. Steps marked
  "Self-check" are for you and a neighbour; no TA signs them.
- **Exit task.** Each lab ends with a short supervised exit task, done on
  paper or with the assistant closed. It is like the lab's main skill but
  not the same task. The TA records your score so that you and the
  instructor can see your progress before the mid exam.
- If you miss more than three **labs** (not checkpoints) without an
  approved reason, your project mark is capped at 50 %.

## Late work

- Project proposal and milestones: 10 % of that item's mark per day late,
  up to 5 days; not accepted after that.
- Final project submission: not accepted late without a documented reason
  approved before the deadline.
- Lab checkpoints can be completed in the following week's lab. The exit
  task can only be done in the lab it belongs to.

## Academic integrity

Submitting work that is not your own (or your group's own, for the
project) is misconduct and is handled under university regulations.
Copying from another student, another group, the internet or an AI
assistant *without disclosure* all count.

Not being able to explain your code is a different problem from
dishonesty, and it is handled differently: see rule 2 below.

## AI-use policy

AI coding assistants (Claude, ChatGPT, Gemini, Copilot and similar) are part
of professional practice, and you may use them in labs and in the project
under the rules below. An assistant can also stop you from learning: if
it writes the code that a task asks you to practise, you finish the task
without gaining the skill, and you may not notice. Week 1 ("Using an
assistant while you are learning") shows how to use one without losing
the practice.

### AI-use levels

Every lab task shows one of these levels under its heading. The level
says how much help the task allows, because some tasks exist to train a
skill that the exams check without an assistant.

| Level | Name | What you may do |
|---|---|---|
| 0 | No AI | Write it yourself. This task trains the skill. |
| 1 | Explain only | You may ask an assistant to explain an error message or a concept. Do not paste its code into your answer. |
| 2 | Review | Write it yourself first. Then you may ask an assistant to review it, and you record what it found. |
| 3 | Draft and verify | An assistant may write a first draft. You run the verification checklist from week 1 and record the result. |

Exit tasks, quizzes and exams are always level 0.

### Rules

1. **Disclose.** Each lab ends with a three-line **AI note**, which the TA
   reads at a checkpoint: *Which task did you use an assistant for? What
   did it get wrong, or what did you not understand? What did you check
   yourself?* Each project milestone and the final submission include an
   `AI_USAGE.md` (template in `../project/AI_USAGE-template.md`).
2. **Understand.** You must be able to explain any code you submit. TA
   checkpoints in labs and individual oral checks at milestones test this.
   If you cannot explain code you submitted, that part earns no credit,
   and you get a second check within one week. In a check you may answer
   by tracing or changing the code on screen, not only by speaking, and
   you may use Amharic for single words you do not know in English.
3. **Verify.** AI output is a draft, not an answer. You are responsible for
   correctness, security, licensing and privacy. Week 1 introduces the
   verification checklist; weeks 3, 6 and 9 practise it; week 13 and
   `../guides/ai-assisted-development.md` cover it in depth.
4. **No AI in assessed work done under supervision.** The mid exam, the
   final exam and the lab exit tasks are closed-book and AI-free (see
   `exams.md`). Weekly quizzes are for self-checking: answer them before
   you open the answers or any tool.
5. **No secrets or personal data.** Never paste API keys, student data or
   other people's private information into an AI tool.
6. **Attribute.** If an assistant produces a substantial block you keep,
   note it in a code comment (`// Generated with <tool>, reviewed by <name>`).

Breaking rule 1 (no disclosure) or rule 4 (AI in an exam or exit task) is
academic misconduct. Not being able to explain code (rule 2) is not
misconduct by itself; it costs the credit for that part, as described in
rule 2.

## Communication

Course announcements go through the university LMS and the repository's
GitHub Discussions. Email the instructor for personal matters only; use
Discussions for technical questions so everyone benefits.

## Accessibility and support

If you need accommodations, contact the instructor in the first two weeks.
Students without a suitable laptop should speak to the instructor about lab
machine access.
