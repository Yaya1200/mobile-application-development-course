import 'package:campus_companion/core/router/router.dart';
import 'package:campus_companion/features/notes/presentation/note_editor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers.dart';

void main() {
  testWidgets('create, pin, edit and delete a note', (tester) async {
    await pumpApp(tester, initialLocation: Routes.notes);
    expect(find.text('No notes yet. Tap + to add one.'), findsOneWidget);

    // Create.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(NoteEditorScreen), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, 'Title'), 'Shopping');
    await tester.enterText(find.widgetWithText(TextField, 'Note'), 'Milk, bread');
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Shopping'), findsOneWidget);
    expect(find.text('Milk, bread'), findsOneWidget);

    // Pin.
    await tester.tap(find.byTooltip('Pin'));
    await tester.pump();
    expect(find.byTooltip('Unpin'), findsOneWidget);

    // Edit.
    await tester.tap(find.text('Shopping'));
    await tester.pumpAndSettle();
    expect(find.text('Edit note'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, 'Title'), 'Groceries');
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Groceries'), findsOneWidget);
    expect(find.text('Shopping'), findsNothing);

    // Delete.
    await tester.tap(find.text('Groceries'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Delete'));
    await tester.pumpAndSettle();
    expect(find.text('No notes yet. Tap + to add one.'), findsOneWidget);
  });

  testWidgets('notes survive switching tabs', (tester) async {
    await pumpApp(tester, initialLocation: Routes.notes);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Title'), 'Keep me');
    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.note_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Keep me'), findsOneWidget);
  });
}
