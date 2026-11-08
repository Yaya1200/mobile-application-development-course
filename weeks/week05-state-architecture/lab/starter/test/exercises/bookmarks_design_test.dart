// These tests check the requirement of lab Task 4, not your design: any
// design that keeps the count, the icons and the Saved page in agreement
// passes them.
import 'package:campus_companion/exercises/bookmarks_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpTalks(WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: BookmarksApp()));
    await tester.pumpAndSettle();
  }

  Finder bookmarkOf(String title) => find.descendant(
    of: find.widgetWithText(ListTile, title),
    matching: find.byType(IconButton),
  );

  testWidgets('the count follows the bookmarks', (tester) async {
    await pumpTalks(tester);
    expect(find.text('Bookmarks: 0'), findsOneWidget);

    await tester.tap(bookmarkOf('Amharic text input'));
    await tester.pump();
    await tester.tap(bookmarkOf('Offline-first apps'));
    await tester.pump();
    expect(find.text('Bookmarks: 2'), findsOneWidget);
    expect(find.byTooltip('Remove bookmark'), findsNWidgets(2));

    await tester.tap(bookmarkOf('Amharic text input'));
    await tester.pump();
    expect(find.text('Bookmarks: 1'), findsOneWidget);
  });

  testWidgets('the Saved page lists the bookmarked talks', (tester) async {
    await pumpTalks(tester);
    await tester.tap(find.byTooltip('Saved'));
    await tester.pumpAndSettle();
    expect(find.text('No bookmarks yet.'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(bookmarkOf('Testing with fakes'));
    await tester.pump();
    await tester.tap(find.byTooltip('Saved'));
    await tester.pumpAndSettle();

    expect(find.text('Testing with fakes'), findsOneWidget);
    expect(find.text('Amharic text input'), findsNothing);
  });

  testWidgets('removing on the Saved page also changes the talks page', (
    tester,
  ) async {
    await pumpTalks(tester);
    await tester.tap(bookmarkOf('Testing with fakes'));
    await tester.pump();
    await tester.tap(find.byTooltip('Saved'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Remove bookmark'));
    await tester.pump();
    expect(find.text('No bookmarks yet.'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Bookmarks: 0'), findsOneWidget);
    expect(find.byTooltip('Remove bookmark'), findsNothing);
  });
}
