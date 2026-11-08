import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Campus Companion is the running example app of the Mobile '
          'Applications Development course at Addis Ababa University. '
          'It grows one feature per week.',
        ),
      ),
    );
  }
}
