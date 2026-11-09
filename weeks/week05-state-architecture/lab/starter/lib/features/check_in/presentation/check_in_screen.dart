import 'package:flutter/material.dart';

import '../widgets/lifecycle_logger.dart';

/// The check-in counter and lifecycle demo from week 2, moved out of the
/// home screen so the home screen can host several sections.
class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  int _checkIns = 0;
  bool _showLogger = false;

  void _checkIn() => setState(() => _checkIns++);

  @override
  Widget build(BuildContext context) {
    // Since week 4 this is a full route of its own (opened from the
    // drawer), so it brings its own Scaffold and AppBar.
    return Scaffold(
      appBar: AppBar(title: const Text('Check-in')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Check-ins today: $_checkIns',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: FloatingActionButton.small(
                onPressed: _checkIn,
                tooltip: 'Check in',
                child: const Icon(Icons.add),
              ),
            ),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('Show lifecycle logger'),
              value: _showLogger,
              onChanged: (value) => setState(() => _showLogger = value),
            ),
            if (_showLogger) LifecycleLogger(label: 'Check-ins: $_checkIns'),
          ],
        ),
      ),
    );
  }
}
