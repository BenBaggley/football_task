import 'package:dartz/dartz.dart';
import 'package:football_mvp/core/domain/failure.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/football_match.dart';
import 'package:football_mvp/features/most_valuable_team/domain/enums/match_status.dart';
import 'package:football_mvp/features/most_valuable_team/domain/repositories/football_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMatches {
  final FootballRepository _repository;

  const GetMatches(this._repository);

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
