// Week 5 lecture example — a reminders list with Riverpod. The notes and
// slides show this code. Each lab task is similar to one part, but not
// the same:
//
//   Reminder (freezed model)               <->  Note (given)
//   Reminders: add, markDone, remove       <->  Notes: add, update, remove,
//                                               togglePinned     (lab Task 1)
//   openReminders: filter and sort a copy  <->  sortedNotes      (lab Task 1)
//   reminderById: a family                <->  noteById (given)
//   RemindersPage: watch in build, read    <->  NotesScreen and
//   in callbacks, a local text controller       NoteEditorScreen (lab Task 2)
//
// Run it on its own:
//   flutter run -d chrome -t lib/exercises/lecture_reminders.dart
// The tests are in test/exercises/lecture_reminders_test.dart.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lecture_reminders.freezed.dart';
part 'lecture_reminders.g.dart';

void main() => runApp(const ProviderScope(child: RemindersApp()));

// ---------------------------------------------------------------------------
// Domain: an immutable model. freezed writes copyWith, ==, hashCode and
// toString in lecture_reminders.freezed.dart.
// ---------------------------------------------------------------------------

@freezed
abstract class Reminder with _$Reminder {
  const factory Reminder({
    required String id,
    required String text,
    required DateTime due,
    @Default(false) bool done,
  }) = _Reminder;
}

// ---------------------------------------------------------------------------
// Data: a Notifier holds the list and the methods that replace it.
// ---------------------------------------------------------------------------

@riverpod
class Reminders extends _$Reminders {
  int _nextId = 1;

  @override
  List<Reminder> build() => const [];

  Reminder add(String text, {required DateTime due}) {
    final reminder = Reminder(id: 'r${_nextId++}', text: text, due: due);
    state = List.unmodifiable([...state, reminder]);
    return reminder;
  }

  void markDone(String id) {
    state = List.unmodifiable([
      for (final r in state)
        if (r.id == id) r.copyWith(done: true) else r,
    ]);
  }

  void remove(String id) {
    state = List.unmodifiable(state.where((r) => r.id != id));
  }
}

/// Derived state: the reminders that are not done, soonest first.
@riverpod
List<Reminder> openReminders(Ref ref) {
  final open = ref.watch(remindersProvider).where((r) => !r.done).toList();
  open.sort((a, b) => a.due.compareTo(b.due));
  return open;
}

/// A family: one cached value per id.
@riverpod
Reminder? reminderById(Ref ref, String id) {
  return ref.watch(remindersProvider).where((r) => r.id == id).firstOrNull;
}

// ---------------------------------------------------------------------------
// Presentation.
// ---------------------------------------------------------------------------

class RemindersApp extends StatelessWidget {
  const RemindersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Reminders', home: RemindersPage());
  }
}

/// ConsumerStatefulWidget: the page needs `ref` and also a text controller,
/// which is ephemeral state and stays in the widget.
class RemindersPage extends ConsumerStatefulWidget {
  const RemindersPage({super.key});

  @override
  ConsumerState<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends ConsumerState<RemindersPage> {
  final _text = TextEditingController();

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _add() {
    final text = _text.text.trim();
    if (text.isEmpty) return;
    final due = DateTime.now().add(const Duration(days: 1));
    ref.read(remindersProvider.notifier).add(text, due: due);
    _text.clear();
  }

  @override
  Widget build(BuildContext context) {
    final open = ref.watch(openRemindersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Reminders')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _text,
                    decoration: const InputDecoration(labelText: 'Reminder'),
                  ),
                ),
                IconButton(
                  tooltip: 'Add',
                  icon: const Icon(Icons.add),
                  onPressed: _add,
                ),
              ],
            ),
          ),
          Expanded(
            child: open.isEmpty
                ? const Center(child: Text('Nothing to do.'))
                : ListView.builder(
                    itemCount: open.length,
                    itemBuilder: (context, index) {
                      final reminder = open[index];
                      return CheckboxListTile(
                        title: Text(reminder.text),
                        value: reminder.done,
                        onChanged: (_) => ref
                            .read(remindersProvider.notifier)
                            .markDone(reminder.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
