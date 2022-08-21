import 'package:dartz/dartz.dart';
import 'package:football_mvp/core/domain/failure.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/football_match.dart';
import 'package:football_mvp/features/most_valuable_team/domain/enums/match_status.dart';
import 'package:football_mvp/features/most_valuable_team/domain/repositories/football_repository.dart';
import 'package:injectable/injectable.dart';

/// {@template get_matches}
/// Gets matches for a given competition, date range and status
/// {@endtemplate}
@injectable
class GetMatches {
  final FootballRepository _repository;

  /// {@macro get_matches}
  const GetMatches(this._repository);

  /// {@macro get_matches}
  Future<Either<Failure, List<FootballMatch>>> call({
    required String competition,
    required DateTime dateFrom,
    required DateTime dateTo,
    required MatchStatus status,
  }) =>
      _repository.getMatches(
        competition: competition,
        dateFrom: dateFrom,
        dateTo: dateTo,
        status: status,
      );
}
