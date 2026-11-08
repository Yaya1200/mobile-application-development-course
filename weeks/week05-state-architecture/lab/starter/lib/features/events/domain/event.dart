import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

/// Where an event takes place.
enum Venue {
  mainCampus('Main campus', 'Sidist Kilo'),
  scienceFaculty('Science faculty', 'Arat Kilo'),
  technology('Technology faculty', 'Amist Kilo'),
  online('Online', 'Zoom / Teams');

  const Venue(this.label, this.location);

  final String label;
  final String location;
}

/// A campus event.
///
/// `freezed` generates what we wrote by hand in week 2: the const
/// constructor, `copyWith`, `==`, `hashCode` and `toString`. Run
/// `dart run build_runner build -d` after editing this file.
@freezed
abstract class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    required DateTime start,
    required Venue venue,
    @Default('') String description,
    @Default(true) bool isFree,
  }) = _Event;

  // A private constructor lets us add methods and getters.
  const Event._();

  /// True when the event starts in the future relative to [now]
  /// (defaults to the current time — injectable for tests).
  bool isUpcoming({DateTime? now}) => start.isAfter(now ?? DateTime.now());
}
