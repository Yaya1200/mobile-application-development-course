import 'package:flutter/material.dart';

/// A widget that prints every lifecycle callback so you can watch the
/// StatefulWidget lifecycle in the console. Toggle it on and off from the
/// home screen and change its [label] while it is mounted.
class LifecycleLogger extends StatefulWidget {
  const LifecycleLogger({required this.label, super.key});

  final String label;

  // createState is called once per element; it must only construct the
  // State (the `no_logic_in_create_state` lint forbids anything else).
  @override
  State<LifecycleLogger> createState() => _LifecycleLoggerState();
}

class _LifecycleLoggerState extends State<LifecycleLogger> {
  int _buildCount = 0;

  @override
  void initState() {
    super.initState();
    // Runs once. Good for subscriptions and controllers. No context lookups
    // that depend on inherited widgets yet.
    debugPrint('[LifecycleLogger] initState (${widget.label})');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Runs after initState, and again when an inherited widget this state
    // depends on (Theme, MediaQuery, ...) changes.
    debugPrint('[LifecycleLogger] didChangeDependencies');
  }

  @override
  void didUpdateWidget(LifecycleLogger oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The parent rebuilt with a new LifecycleLogger widget of the same type
    // and key. State survives; compare old and new configuration here.
    debugPrint(
      '[LifecycleLogger] didUpdateWidget '
      '(${oldWidget.label} → ${widget.label})',
    );
  }

  @override
  Widget build(BuildContext context) {
    _buildCount++;
    debugPrint('[LifecycleLogger] build #$_buildCount');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text('${widget.label} — built $_buildCount time(s)'),
      ),
    );
  }

  @override
  void dispose() {
    // Undo whatever initState did: cancel subscriptions, dispose controllers.
    debugPrint('[LifecycleLogger] dispose');
    super.dispose();
  }
}
