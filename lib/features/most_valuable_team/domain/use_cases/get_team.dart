import 'package:dartz/dartz.dart';
import 'package:football_mvp/core/domain/failure.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/team.dart';
import 'package:football_mvp/features/most_valuable_team/domain/repositories/football_repository.dart';
import 'package:injectable/injectable.dart';

/// {@template get_team}
/// Gets team details for a given id
/// {@endtemplate}
@injectable
class GetTeam {
  final FootballRepository _repository;

  /// {@macro get_team}
  const GetTeam(this._repository);

  /// {@macro get_team}
  Future<Either<Failure, Team>> call(int id) => _repository.getTeam(id);
}
