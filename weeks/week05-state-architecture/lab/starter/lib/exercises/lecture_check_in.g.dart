// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_check_in.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CheckInCounter)
final checkInCounterProvider = CheckInCounterProvider._();

final class CheckInCounterProvider
    extends $NotifierProvider<CheckInCounter, int> {
  CheckInCounterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkInCounterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkInCounterHash();

  @$internal
  @override
  CheckInCounter create() => CheckInCounter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$checkInCounterHash() => r'8e8b035af6de262a64d7b190c87fc31033775bb2';

abstract class _$CheckInCounter extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
