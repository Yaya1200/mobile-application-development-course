import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const seed = Color(0xFF00695C);

  static final light = ThemeData(colorSchemeSeed: seed, useMaterial3: true);
}
