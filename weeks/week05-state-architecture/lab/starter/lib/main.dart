import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() {
  // ProviderScope stores the state of every provider. One at the root;
  // tests create their own with overrides.
  runApp(const ProviderScope(child: CampusCompanionApp()));
}
