import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/profile.dart';

part 'profile_notifier.g.dart';

/// The signed-in student's profile. Kept in a Notifier (not widget state)
/// because several screens will read it and week 14 persists it.
@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  Profile build() => const Profile(name: 'Sara Bekele');

  void setName(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    state = state.copyWith(name: trimmed);
  }
}
