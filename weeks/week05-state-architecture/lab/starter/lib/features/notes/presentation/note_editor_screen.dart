import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/notes_notifier.dart'; // ignore: unused_import — used from Task 2b

/// Creates a note (no [noteId]) or edits an existing one.
///
/// ConsumerStatefulWidget: we need `ref` *and* local widget state (the
/// text controllers). Controllers are ephemeral UI state — they stay in
/// the widget, not in a provider.
class NoteEditorScreen extends ConsumerStatefulWidget {
  const NoteEditorScreen({this.noteId, super.key});

  final String? noteId;

  bool get isNew => noteId == null;

  @override
  ConsumerState<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends ConsumerState<NoteEditorScreen> {
  late final TextEditingController _title;
  late final TextEditingController _body;

  @override
  void initState() {
    super.initState();
    // TODO(lab): Task 2b — when editing, start with the existing note's
    // title and body.
    _title = TextEditingController();
    _body = TextEditingController();
  }

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  void _save() {
    // TODO(lab): Task 2b — add a new note or update the existing one, then
    // pop.
    context.pop();
  }

  void _delete() {
    // TODO(lab): Task 2b — remove the note, then pop.
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isNew ? 'New note' : 'Edit note'),
        actions: [
          if (!widget.isNew)
            IconButton(
              tooltip: 'Delete',
              icon: const Icon(Icons.delete_outline),
              onPressed: _delete,
            ),
          IconButton(
            tooltip: 'Save',
            icon: const Icon(Icons.check),
            onPressed: _save,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _title,
              autofocus: widget.isNew,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _body,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
