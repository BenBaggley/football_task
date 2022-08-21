import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/team.dart';
import 'package:football_mvp/features/most_valuable_team/domain/enums/match_status.dart';
import 'package:football_mvp/features/most_valuable_team/domain/enums/match_winner.dart';
import 'package:football_mvp/features/most_valuable_team/domain/use_cases/get_matches.dart';
import 'package:football_mvp/features/most_valuable_team/domain/use_cases/get_team.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'most_valuable_team_cubit.freezed.dart';
part 'most_valuable_team_state.dart';

/// {@template most_valuable_team_cubit}
/// Cubit for most valuable team feature
/// {@endtemplate}
@injectable
class MostValuableTeamCubit extends Cubit<MostValuableTeamState> {
  /// {@macro most_valuable_team_cubit}
  MostValuableTeamCubit(
    this._getMatches,
    this._getTeam,
  ) : super(const MostValuableTeamState.initial());

  final GetMatches _getMatches;
  final GetTeam _getTeam;

  /// Loads the most valuable team
  Future<void> load() async {
    emit(const MostValuableTeamState.loading());

    final today = DateTime.now();

    /// API is limited to 10 day periods, split into 3 calls
    final first10 = _getMatches(
      competition: 'PL',
      dateFrom: today.subtract(const Duration(days: 30)),
      dateTo: today.subtract(const Duration(days: 20)),
      status: MatchStatus.finished,
    );
    final mid10 = _getMatches(
      competition: 'PL',
      dateFrom: today.subtract(const Duration(days: 20)),
      dateTo: today.subtract(const Duration(days: 10)),
      status: MatchStatus.finished,
    );
    final last10 = _getMatches(
      competition: 'PL',
      dateFrom: today.subtract(const Duration(days: 10)),
      dateTo: today,
      status: MatchStatus.finished,
    );

    final results = await Future.wait([first10, mid10, last10]);
    final failure = results.firstWhereOrNull((result) => result.isLeft());
    if (failure != null) {
      failure.leftMap((f) => emit(MostValuableTeamState.failure(f.message)));
      return;
    }

    /// Disregard matches ending in a draw
    final matches = results.expand((result) => result.get()).where(
          (match) => match.score.winner != MatchWinner.draw,
        );

    final teams = matches.map(
      (m) => m.score.winner == MatchWinner.home ? m.homeTeam : m.awayTeam,
    );

    final occurences = <int, int>{};
    for (var t in teams) {
      occurences[t.id] = (occurences[t.id] ?? 0) + 1;
    }

    final bestId = occurences.entries
        .reduce(
          (a, b) => a.value > b.value ? a : b,
        )
        .key;

    final teamResult = await _getTeam(bestId);

    teamResult.fold(
      (f) => emit(MostValuableTeamState.failure(f.message)),
      (team) => emit(MostValuableTeamState.data(
        team: team,
        wins: occurences[team.id]!,
      )),
    );
  }
}

extension _EitherGet<L, R> on Either<L, R> {
  R get() => getOrElse(() => throw StateError('Either is left'));
}
