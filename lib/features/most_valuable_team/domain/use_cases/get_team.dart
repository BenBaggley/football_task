import 'package:dartz/dartz.dart';
import 'package:football_mvp/core/domain/failure.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/team.dart';
import 'package:football_mvp/features/most_valuable_team/domain/repositories/football_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTeam {
  final FootballRepository _repository;

  const GetTeam(this._repository);

  Future<Either<Failure, Team>> call(int id) => _repository.getTeam(id);
}
