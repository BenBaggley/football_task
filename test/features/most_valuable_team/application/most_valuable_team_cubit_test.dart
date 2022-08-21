import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:football_mvp/core/domain/failure.dart';
import 'package:football_mvp/features/most_valuable_team/application/cubit/most_valuable_team_cubit.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/football_match.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/team.dart';
import 'package:football_mvp/features/most_valuable_team/domain/enums/match_status.dart';
import 'package:football_mvp/features/most_valuable_team/domain/use_cases/get_matches.dart';
import 'package:football_mvp/features/most_valuable_team/domain/use_cases/get_team.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixtures.dart';

class MockGetMatches extends Mock implements GetMatches {}

class MockGetTeam extends Mock implements GetTeam {}

void main() {
  group(MostValuableTeamCubit, () {
    late MockGetMatches getMatches;
    late MockGetTeam getTeam;

    setUp(() {
      getMatches = MockGetMatches();
      getTeam = MockGetTeam();
      registerFallbackValue(MatchStatus.finished);
    });

    final matches = (jsonFixture('matches.json')['matches'] as List)
        .map((json) => FootballMatch.fromJson(json))
        .toList();
    final team = Team.fromJson(jsonFixture('team.json'));

    blocTest<MostValuableTeamCubit, MostValuableTeamState>(
      'emits data when loaded',
      setUp: () {
        when(
          () => getMatches(
            competition: any(named: 'competition'),
            dateFrom: any(named: 'dateFrom'),
            dateTo: any(named: 'dateTo'),
            status: any(named: 'status'),
          ),
        ).thenAnswer((_) async => Right(matches));
        when(
          () => getTeam(any()),
        ).thenAnswer((_) async => Right(team));
      },
      build: () => MostValuableTeamCubit(getMatches, getTeam),
      act: (cubit) => cubit.load(),
      expect: () => [
        const MostValuableTeamState.loading(),
        MostValuableTeamState.data(team: team, wins: 3),
      ],
      verify: (_) {
        verify(() => getMatches(
              competition: any(named: 'competition'),
              dateFrom: any(named: 'dateFrom'),
              dateTo: any(named: 'dateTo'),
              status: any(named: 'status'),
            )).called(3);
        verify(() => getTeam(any())).called(1);
      },
    );

    blocTest<MostValuableTeamCubit, MostValuableTeamState>(
        'emits failure when getMatches fails',
        setUp: () {
          when(
            () => getMatches(
              competition: any(named: 'competition'),
              dateFrom: any(named: 'dateFrom'),
              dateTo: any(named: 'dateTo'),
              status: any(named: 'status'),
            ),
          ).thenAnswer((_) async => const Left(Failure(message: 'message')));
        },
        build: () => MostValuableTeamCubit(getMatches, getTeam),
        act: (cubit) => cubit.load(),
        expect: () => [
              const MostValuableTeamState.loading(),
              const MostValuableTeamState.failure('message'),
            ],
        verify: (_) {
          verify(() => getMatches(
                competition: any(named: 'competition'),
                dateFrom: any(named: 'dateFrom'),
                dateTo: any(named: 'dateTo'),
                status: any(named: 'status'),
              )).called(3);
          verifyNever((() => getTeam(any())));
        });

    blocTest<MostValuableTeamCubit, MostValuableTeamState>(
      'emits failure when getTeam fails',
      setUp: () {
        when(
          () => getMatches(
            competition: any(named: 'competition'),
            dateFrom: any(named: 'dateFrom'),
            dateTo: any(named: 'dateTo'),
            status: any(named: 'status'),
          ),
        ).thenAnswer((_) async => Right(matches));
        when(
          () => getTeam(any()),
        ).thenAnswer((_) async => const Left(Failure(message: 'message')));
      },
      build: () => MostValuableTeamCubit(getMatches, getTeam),
      act: (cubit) => cubit.load(),
      expect: () => [
        const MostValuableTeamState.loading(),
        const MostValuableTeamState.failure('message'),
      ],
      verify: (_) {
        verify(() => getMatches(
              competition: any(named: 'competition'),
              dateFrom: any(named: 'dateFrom'),
              dateTo: any(named: 'dateTo'),
              status: any(named: 'status'),
            )).called(3);
        verify(() => getTeam(any())).called(1);
      },
    );
  });
}
