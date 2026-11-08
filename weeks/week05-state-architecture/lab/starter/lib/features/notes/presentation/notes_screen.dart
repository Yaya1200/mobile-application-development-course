import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/router.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(lab): Task 2a — show the notes from sortedNotesProvider. The
    // requirements are in the lab README, Task 2a; the contract is
    // test/features/notes/notes_flow_test.dart.
    return Scaffold(
      body: const Center(child: Text('No notes yet. Tap + to add one.')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.newNote),
        tooltip: 'New note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
