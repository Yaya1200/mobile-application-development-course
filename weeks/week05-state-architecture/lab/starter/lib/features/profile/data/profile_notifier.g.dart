// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The signed-in student's profile. Kept in a Notifier (not widget state)
/// because several screens will read it and week 14 persists it.

@ProviderFor(ProfileNotifier)
final profileProvider = ProfileNotifierProvider._();

/// The signed-in student's profile. Kept in a Notifier (not widget state)
/// because several screens will read it and week 14 persists it.
final class ProfileNotifierProvider
    extends $NotifierProvider<ProfileNotifier, Profile> {
  /// The signed-in student's profile. Kept in a Notifier (not widget state)
  /// because several screens will read it and week 14 persists it.
  ProfileNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileNotifierHash();

  @$internal
  @override
  ProfileNotifier create() => ProfileNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Profile value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Profile>(value),
    );
  }
}

String _$profileNotifierHash() => r'c429d593cae66c5150348ca5e9fd412bf9b7d74c';

/// The signed-in student's profile. Kept in a Notifier (not widget state)
/// because several screens will read it and week 14 persists it.

abstract class _$ProfileNotifier extends $Notifier<Profile> {
  Profile build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Profile, Profile>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Profile, Profile>,
              Profile,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
