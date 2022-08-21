import 'package:freezed_annotation/freezed_annotation.dart';

part 'player.freezed.dart';
part 'player.g.dart';

/// {@template player}
/// Represents a football player.
/// {@endtemplate}
@freezed
class Player with _$Player {
  /// {@macro player}
  const factory Player({
    required int id,
    required String name,
    required String position,
    required String dateOfBirth,
    required String nationality,
  }) = _Player;

  /// Creates a [Player] from a JSON object.
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}
