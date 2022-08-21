import 'package:football_mvp/features/most_valuable_team/domain/entities/coach.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/player.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team.freezed.dart';
part 'team.g.dart';

/// {@template team}
/// Represents a football team.
/// {@endtemplate}
@freezed
class Team with _$Team {
  /// {@macro team}
  const factory Team({
    required int id,
    required String name,
    required String? shortName,
    required String? tla,
    @JsonKey(name: 'crest') required String? crestUrl,
    required String? address,
    required String? website,
    required int? founded,
    required String? clubColors,
    required String? venue,
    required Coach coach,
    required List<Player> squad,
    required DateTime lastUpdated,
  }) = _Team;

  /// Creates a [Team] from a JSON object.
  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}
