import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/router.dart';

/// Profile screen.
// TODO(lab): Task 3 — the name, programme and year are local here, so no
// other widget can read them. Show and change the profile in
// profileProvider instead. Write your test first (lab README, Task 3).
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'Sara Bekele';

  Future<void> _edit() async {
    final uri = Uri(path: Routes.editProfile, queryParameters: {'name': _name});
    final result = await context.push<String>(uri.toString());
    if (!mounted || result == null) return;
    setState(() => _name = result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    final header = Column(
      children: [
        const CircleAvatar(
          radius: 48,
          backgroundImage: AssetImage('assets/images/logo.png'),
        ),
        const SizedBox(height: 12),
        Text(_name, style: theme.textTheme.headlineSmall),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: theme.textTheme.bodyMedium,
            children: const [
              TextSpan(text: 'B.Sc. '),
              TextSpan(
                text: 'Computer Science',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: ' · year 3'),
            ],
          ),
        ),
      ],
    );

    const stats = Row(
      children: [
        Expanded(
          child: _StatTile(label: 'Events', value: '12'),
        ),
        Expanded(
          child: _StatTile(label: 'Notes', value: '34'),
        ),
        Expanded(
          child: _StatTile(label: 'Posts', value: '3'),
        ),
      ],
    );

    final actions = Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        FilledButton.icon(
          onPressed: _edit,
          icon: const Icon(Icons.edit),
          label: const Text('Edit profile'),
        ),
        OutlinedButton(onPressed: () {}, child: const Text('Share')),
        TextButton(onPressed: () {}, child: const Text('Sign out')),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings),
          tooltip: 'Settings',
        ),
      ],
    );

    final orientationBanner = Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Orientation: ${isLandscape ? 'landscape' : 'portrait'}',
        textAlign: TextAlign.center,
      ),
    );

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: isLandscape
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: header),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      children: [
                        stats,
                        const SizedBox(height: 16),
                        actions,
                        orientationBanner,
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  header,
                  const SizedBox(height: 24),
                  stats,
                  const SizedBox(height: 16),
                  actions,
                  orientationBanner,
                ],
              ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(value, style: theme.textTheme.titleLarge),
        Text(label, style: theme.textTheme.labelMedium),
      ],
    );
  }
}
