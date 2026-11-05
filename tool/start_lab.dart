// Copies a week's lab starter into your lab repository and commits it.
//
// Run from the root of the course repository:
//
//   dart tool/start_lab.dart 05 ../mad-labs-UGR-1234-16
//
// It creates <lab repository>/week05/ from weeks/week05-*/lab/starter/,
// without build output, and makes the commit "chore(week05): add starter".
// See guides/lab-repository.md.
import 'dart:io';

/// Folders and files that are build output, not part of the starter.
const _skip = {
  '.dart_tool',
  'build',
  '.flutter-plugins',
  '.flutter-plugins-dependencies',
  'node_modules',
  'coverage',
  'pubspec.lock',
  '.metadata',
};

/// A student ID such as UGR/1234/16.
final studentId = RegExp(r'Student ID[:*\s]*UGR/[0-9]{4}/[0-9]{2}\b');

Never fail(String message) {
  stderr.writeln('error: $message');
  exit(1);
}

void main(List<String> args) {
  if (args.length != 2 || int.tryParse(args[0]) == null) {
    stderr.writeln('usage: dart tool/start_lab.dart <week> <lab repository>');
    stderr.writeln(
      'example: dart tool/start_lab.dart 05 ../mad-labs-UGR-1234-16',
    );
    exit(64);
  }
  final week = int.parse(args[0]).toString().padLeft(2, '0');
  final course = File.fromUri(Platform.script).parent.parent;
  final labRepo = Directory(args[1]).absolute;

  if (!Directory('${labRepo.path}/.git').existsSync()) {
    fail(
      '${args[1]} is not a git repository. Give the folder of your lab '
      'repository (see guides/lab-repository.md).',
    );
  }
  final readme = File('${labRepo.path}/README.md');
  if (!readme.existsSync() || !studentId.hasMatch(readme.readAsStringSync())) {
    fail(
      '${args[1]}/README.md needs the line "Student ID: UGR/1234/16" '
      'with your ID (copy labs-template/README.md).',
    );
  }

  final weekDirs = Directory('${course.path}/weeks')
      .listSync()
      .whereType<Directory>()
      .where((d) => _name(d).startsWith('week$week-'))
      .toList();
  final starter = weekDirs.isEmpty
      ? null
      : Directory('${weekDirs.first.path}/lab/starter');
  if (starter == null || !File('${starter.path}/pubspec.yaml').existsSync()) {
    fail(
      'no starter for week $week yet. It is released before the lab: '
      'run git pull in the course repository.',
    );
  }

  final target = Directory('${labRepo.path}/week$week');
  if (target.existsSync()) {
    fail(
      'week$week/ already exists in ${args[1]}. You started this lab '
      'already: cd into it.',
    );
  }

  _copy(starter, target);
  stdout.writeln(
    'Copied ${_relative(starter, course)} to ${args[1]}/week$week/',
  );

  _git(labRepo, ['add', 'week$week']);
  _git(labRepo, ['commit', '-q', '-m', 'chore(week$week): add starter']);
  stdout
    ..writeln('Committed "chore(week$week): add starter".')
    ..writeln()
    ..writeln('Next:')
    ..writeln('  cd ${args[1]}/week$week')
    ..writeln('  flutter pub get')
    ..writeln(
      'Commit after each task: '
      'git commit -m "feat(week$week): task 1 <what changed>"',
    );
}

String _name(FileSystemEntity e) =>
    e.uri.pathSegments.lastWhere((s) => s.isNotEmpty);

String _relative(Directory dir, Directory root) =>
    dir.path.substring(root.path.length + 1);

void _copy(Directory from, Directory to) {
  to.createSync(recursive: true);
  for (final entity in from.listSync(followLinks: false)) {
    final name = _name(entity);
    if (_skip.contains(name)) continue;
    if (entity is Directory) {
      _copy(entity, Directory('${to.path}/$name'));
    } else if (entity is File) {
      entity.copySync('${to.path}/$name');
    }
  }
}

void _git(Directory repo, List<String> args) {
  final result = Process.runSync('git', ['-C', repo.path, ...args]);
  if (result.exitCode != 0) {
    stderr.write(result.stderr);
    fail(
      'git ${args.first} failed in ${repo.path}. If git asks who you '
      'are, see "Once, in week 1" in guides/lab-repository.md, then run '
      'git add and git commit yourself.',
    );
  }
}
