import 'package:dartz/dartz.dart';
import 'package:football_mvp/core/domain/failure.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/football_match.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/team.dart';
import 'package:football_mvp/features/most_valuable_team/domain/enums/match_status.dart';

abstract class FootballRepository {
  Future<Either<Failure, List<FootballMatch>>> getMatches({
    required String competition,
    required DateTime dateFrom,
    required DateTime dateTo,
    required MatchStatus status,
  });

  Future<Either<Failure, Team>> getTeam(int id);
}
