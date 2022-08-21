import 'package:freezed_annotation/freezed_annotation.dart';

part 'coach.freezed.dart';
part 'coach.g.dart';

/// {@template coach}
/// Represents a football team coach.
/// {@endtemplate}
@freezed
class Coach with _$Coach {
  /// {@macro coach}
  const factory Coach({
    required int id,
    required String name,
    required String nationality,
  }) = _Coach;

  /// Creates a [Coach] from a JSON object.
  factory Coach.fromJson(Map<String, dynamic> json) => _$CoachFromJson(json);
}
