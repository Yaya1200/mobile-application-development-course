// Checks a lab repository for one week: a commit for every required task,
// the files every lab asks for, and the student ID in README.md.
//
// Run from the root of the course repository:
//
//   dart tool/check_lab_commits.dart ../mad-labs-UGR-1234-16 05
//
// A commit counts for task N of week 05 when it changes week05/ and its
// message contains "(week05): task N". Required tasks are the
// "### Task N — …" headings of weeks/week05-*/lab/README.md, except the
// Extra tasks. Exit code 1 when something is missing.
// See guides/lab-repository.md.
import 'dart:io';

final studentId = RegExp(r'Student ID[:*\s]*(UGR/[0-9]{4}/[0-9]{2})\b');
final taskHeading = RegExp(r'^### Task ([0-9]+) — (.*)$', multiLine: true);

/// Files that every lab's "Submit" section asks for.
const requiredFiles = ['predictions.md', 'AI_NOTE.md'];

void main(List<String> args) {
  if (args.length != 2 || int.tryParse(args[1]) == null) {
    stderr.writeln(
      'usage: dart tool/check_lab_commits.dart <lab repository> <week>',
    );
    stderr.writeln(
      'example: dart tool/check_lab_commits.dart ../mad-labs-UGR-1234-16 05',
    );
    exit(64);
  }
  final repo = Directory(args[0]).absolute;
  final week = int.parse(args[1]).toString().padLeft(2, '0');
  final course = File.fromUri(Platform.script).parent.parent;
  final problems = <String>[];

  if (!Directory('${repo.path}/.git').existsSync()) {
    stderr.writeln('error: ${args[0]} is not a git repository');
    exit(2);
  }

  // Student ID.
  final readme = File('${repo.path}/README.md');
  final id = readme.existsSync()
      ? studentId.firstMatch(readme.readAsStringSync())?.group(1)
      : null;
  if (id == null) {
    problems.add('README.md has no line "Student ID: UGR/XXXX/YY"');
  }

  // Required tasks from the lab instructions.
  final labReadme = _labReadme(course, week);
  final tasks = <int, String>{};
  for (final m in taskHeading.allMatches(labReadme.readAsStringSync())) {
    final title = m.group(2)!.trim();
    if (title.toLowerCase().startsWith('extra')) continue;
    tasks[int.parse(m.group(1)!)] = title;
  }

  // Commits that change weekNN/.
  final folder = Directory('${repo.path}/week$week');
  if (!folder.existsSync()) {
    problems.add('week$week/ does not exist');
  }
  final log = Process.runSync('git', [
    '-C',
    repo.path,
    'log',
    '--format=%h%x09%s',
    'HEAD',
    '--',
    'week$week/',
  ]);
  final commits = log.exitCode == 0
      ? (log.stdout as String)
            .split('\n')
            .where((l) => l.contains('\t'))
            .toList()
      : <String>[];
  final taskRef = RegExp(
    '\\(week$week\\):\\s*task\\s+([0-9]+)\\b',
    caseSensitive: false,
  );
  final byTask = <int, List<String>>{};
  for (final line in commits.reversed) {
    final match = taskRef.firstMatch(line.split('\t')[1]);
    if (match != null) {
      byTask.putIfAbsent(int.parse(match.group(1)!), () => []).add(line);
    }
  }

  stdout
    ..writeln('Lab repository: ${args[0]}')
    ..writeln('Student ID:     ${id ?? '(missing)'}')
    ..writeln(
      'Week:           $week (${commits.length} commits change week$week/)',
    )
    ..writeln();
  for (final entry in tasks.entries) {
    final found = byTask[entry.key] ?? const <String>[];
    stdout.writeln(
      '${found.isEmpty ? 'MISSING' : 'ok     '} Task ${entry.key} — ${entry.value}',
    );
    for (final c in found) {
      stdout.writeln('          ${c.replaceFirst('\t', '  ')}');
    }
    if (found.isEmpty) problems.add('no commit names task ${entry.key}');
  }
  for (final extra in byTask.keys.where((k) => !tasks.containsKey(k))) {
    stdout.writeln('extra   Task $extra (${byTask[extra]!.length} commits)');
  }

  if (folder.existsSync()) {
    for (final name in requiredFiles) {
      if (!File('${folder.path}/$name').existsSync()) {
        problems.add('week$week/$name is missing');
      }
    }
  }

  stdout.writeln();
  if (problems.isEmpty) {
    stdout.writeln(
      'All required tasks have a commit. Push before the deadline.',
    );
  } else {
    for (final p in problems) {
      stdout.writeln('problem: $p');
    }
    exit(1);
  }
}

File _labReadme(Directory course, String week) {
  final weeks = Directory('${course.path}/weeks');
  for (final d in weeks.listSync().whereType<Directory>()) {
    final name = d.uri.pathSegments.lastWhere((s) => s.isNotEmpty);
    final file = File('${d.path}/lab/README.md');
    if (name.startsWith('week$week-') && file.existsSync()) return file;
  }
  stderr.writeln(
    'error: no lab instructions for week $week yet; run git pull '
    'in the course repository',
  );
  exit(2);
}
