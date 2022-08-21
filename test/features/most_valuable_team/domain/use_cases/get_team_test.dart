import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:football_mvp/core/domain/failure.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/team.dart';
import 'package:football_mvp/features/most_valuable_team/domain/repositories/football_repository.dart';
import 'package:football_mvp/features/most_valuable_team/domain/use_cases/get_team.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixtures.dart';

class MockFootballRepository extends Mock implements FootballRepository {}

void main() {
  late MockFootballRepository repository;
  late GetTeam getTeam;

  setUp(() {
    repository = MockFootballRepository();
    getTeam = GetTeam(repository);
  });

  final team = Team.fromJson(jsonFixture('team.json'));

  group(GetTeam, () {
    test('success', () async {
      when(
        () => repository.getTeam(any()),
      ).thenAnswer((_) async => Right(team));

      final result = await getTeam(1);

      expect(result, Right(team));
    });

    test('failure', () async {
      when(
        () => repository.getTeam(1),
      ).thenAnswer((_) async => const Left(Failure(message: 'message')));

      final result = await getTeam(1);

      expect(result, const Left(Failure(message: 'message')));
    });
  });
}
