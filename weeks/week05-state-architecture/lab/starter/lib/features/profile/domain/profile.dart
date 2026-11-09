import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required String name,
    @Default('Computer Science') String programme,
    @Default(3) int year,
  }) = _Profile;
}
