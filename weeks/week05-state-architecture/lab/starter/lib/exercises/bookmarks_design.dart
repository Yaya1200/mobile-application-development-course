// Lab Task 4 — Your own design: bookmarks.
//
// A small app with a list of talks. The requirement:
//
//   The bookmark count in the app bar, the icon on each talk and the
//   Saved page always agree. A bookmark stays when the user opens Saved
//   and comes back.
//
// Decide what the state is, where it lives and which widgets watch it.
// Write your decisions in DECISIONS.md, then implement them.
//
// Run it:  flutter run -d chrome -t lib/exercises/bookmarks_design.dart
// Test it: flutter test test/exercises/bookmarks_design_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const ProviderScope(child: BookmarksApp()));

class Talk {
  const Talk({required this.id, required this.title});

  final String id;
  final String title;
}

const talks = [
  Talk(id: 't1', title: 'Flutter on low-cost phones'),
  Talk(id: 't2', title: 'Amharic text input'),
  Talk(id: 't3', title: 'Testing with fakes'),
  Talk(id: 't4', title: 'Offline-first apps'),
];

class BookmarksApp extends StatelessWidget {
  const BookmarksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Talks', home: TalksPage());
  }
}

class TalksPage extends StatelessWidget {
  const TalksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talks'),
        actions: [
          const BookmarkCount(),
          IconButton(
            tooltip: 'Saved',
            icon: const Icon(Icons.bookmarks_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const SavedPage()),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final talk in talks)
            ListTile(
              title: Text(talk.title),
              trailing: BookmarkButton(talk: talk),
            ),
        ],
      ),
    );
  }
}

/// Keeps its own `_saved` flag, so no other widget can see it.
class BookmarkButton extends StatefulWidget {
  const BookmarkButton({required this.talk, super.key});

  final Talk talk;

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  // TODO(lab): Task 4 — this flag is local widget state. Decide what the
  // shared state is and where it lives (DECISIONS.md), then change this
  // widget, BookmarkCount and SavedPage so that all three agree.
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: _saved ? 'Remove bookmark' : 'Bookmark',
      icon: Icon(_saved ? Icons.bookmark : Icons.bookmark_border),
      onPressed: () => setState(() => _saved = !_saved),
    );
  }
}

class BookmarkCount extends StatelessWidget {
  const BookmarkCount({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(lab): Task 4 — show the real number of bookmarks.
    return const Center(child: Text('Bookmarks: 0'));
  }
}

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(lab): Task 4 — list the bookmarked talks, each with its
    // BookmarkButton. Keep the empty text when there are none.
    return Scaffold(
      appBar: AppBar(title: const Text('Saved')),
      body: const Center(child: Text('No bookmarks yet.')),
    );
  }
}
