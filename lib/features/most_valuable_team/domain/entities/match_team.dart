import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_team.freezed.dart';
part 'match_team.g.dart';

/// {@template match_team}
/// Represents a team in a [Match].
/// {@endtemplate}
@freezed
class MatchTeam with _$MatchTeam {
  /// {@macro match_team}
  const factory MatchTeam({
    required int id,
    required String name,
    required String? shortName,
    required String? tla,
    @JsonKey(name: 'crest') required String? crestUrl,
  }) = _MatchTeam;

  /// Creates a [MatchTeam] from a JSON object.
  factory MatchTeam.fromJson(Map<String, dynamic> json) =>
      _$MatchTeamFromJson(json);
}
