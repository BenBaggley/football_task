import 'package:dartz/dartz.dart';
import 'package:football_mvp/core/domain/failure.dart';
import 'package:football_mvp/features/most_valuable_team/domain/data_sources/football_data_source.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/football_match.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/team.dart';
import 'package:football_mvp/features/most_valuable_team/domain/enums/match_status.dart';
import 'package:football_mvp/features/most_valuable_team/domain/repositories/football_repository.dart';
import 'package:injectable/injectable.dart';

/// {@template default_football_repository}
/// Default implementation of [FootballRepository] using [FootballDataSource]
/// {@endtemplate}
@Singleton(as: FootballRepository)
class DefaultFootballRepository implements FootballRepository {
  /// {@macro default_football_repository}
  const DefaultFootballRepository(this._dataSource);

  final FootballDataSource _dataSource;
  @override
  Future<Either<Failure, List<FootballMatch>>> getMatches({
    required String competition,
    required DateTime dateFrom,
    required DateTime dateTo,
    required MatchStatus status,
  }) =>
      _dataSource.getMatches(
        competition: competition,
        dateFrom: dateFrom,
        dateTo: dateTo,
        status: status,
      );

  @override
  Future<Either<Failure, Team>> getTeam(int id) => _dataSource.getTeam(id);
}
