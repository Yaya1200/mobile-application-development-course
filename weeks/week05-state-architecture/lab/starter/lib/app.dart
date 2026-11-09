import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/router.dart';
import 'core/theme/app_theme.dart';

/// Root widget of Campus Companion.
///
/// Week 5 state: feature-first layout, Riverpod for app state (events,
/// notes, profile), freezed models. See README.md for the roadmap.
class CampusCompanionApp extends ConsumerWidget {
  const CampusCompanionApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Campus Companion',
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
