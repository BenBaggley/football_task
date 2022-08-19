import 'package:football_mvp/features/most_valuable_team/domain/entities/football_match.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'matches_data.freezed.dart';
part 'matches_data.g.dart';

/// {@template matches_data}
/// Wrapper for the matches data.
/// {@endtemplate}
@freezed
class MatchesData with _$MatchesData {
  /// {@macro matches_data}
  const factory MatchesData({
    required List<FootballMatch> matches,
  }) = _MatchesData;

  /// Creates a [MatchesData] from a JSON object.
  factory MatchesData.fromJson(Map<String, dynamic> json) =>
      _$MatchesDataFromJson(json);
}
