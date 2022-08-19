import 'package:football_mvp/features/most_valuable_team/domain/entities/match_score.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/match_team.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'football_match.freezed.dart';
part 'football_match.g.dart';

/// {@template football_match}
/// Represents a football match.
/// {@endtemplate}
@freezed
class FootballMatch with _$FootballMatch {
  /// {@macro football_match}
  const factory FootballMatch({
    required MatchTeam homeTeam,
    required MatchTeam awayTeam,
    required MatchScore score,
  }) = _FootballMatch;

  /// Creates a [FootballMatch] from a JSON object.
  factory FootballMatch.fromJson(Map<String, dynamic> json) =>
      _$FootballMatchFromJson(json);
}
