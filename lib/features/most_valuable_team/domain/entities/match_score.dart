// Package imports:
import 'package:football_mvp/features/most_valuable_team/domain/enums/match_winner.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_score.freezed.dart';
part 'match_score.g.dart';

/// {@template match_score}
/// Represents the score of a [Match].
/// {@endtemplate}
@freezed
class MatchScore with _$MatchScore {
  /// {@macro match_score}
  const factory MatchScore({
    required MatchWinner winner,
  }) = _MatchScore;

  /// Creates a [MatchScore] from a JSON object.
  factory MatchScore.fromJson(Map<String, dynamic> json) =>
      _$MatchScoreFromJson(json);
}
