import 'package:campus_companion/features/events/presentation/events_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  testWidgets('app starts on the events feed', (tester) async {
    await pumpApp(tester);

    expect(find.text('Events'), findsWidgets);
    expect(find.byType(EventsScreen), findsOneWidget);
  });
}
