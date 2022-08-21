import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:football_mvp/core/domain/failure.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/football_match.dart';
import 'package:football_mvp/features/most_valuable_team/domain/enums/match_status.dart';
import 'package:football_mvp/features/most_valuable_team/domain/repositories/football_repository.dart';
import 'package:football_mvp/features/most_valuable_team/domain/use_cases/get_matches.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixtures.dart';

class MockFootballRepository extends Mock implements FootballRepository {}

void main() {
  late MockFootballRepository repository;
  late GetMatches getMatches;

  setUp(() {
    repository = MockFootballRepository();
    getMatches = GetMatches(repository);

    registerFallbackValue(MatchStatus.finished);
  });

  final matches = (jsonFixture('matches.json')['matches'] as List)
      .map((json) => FootballMatch.fromJson(json))
      .toList();

  group(GetMatches, () {
    test('success', () async {
      when(
        () => repository.getMatches(
          competition: any(named: 'competition'),
          dateFrom: any(named: 'dateFrom'),
          dateTo: any(named: 'dateTo'),
          status: any(named: 'status'),
        ),
      ).thenAnswer((_) async => Right(matches));

      final result = await getMatches(
        competition: '',
        dateFrom: DateTime.now(),
        dateTo: DateTime.now(),
        status: MatchStatus.finished,
      );

      expect(result, Right(matches));
    });

    test('failure', () async {
      when(
        () => repository.getMatches(
          competition: any(named: 'competition'),
          dateFrom: any(named: 'dateFrom'),
          dateTo: any(named: 'dateTo'),
          status: any(named: 'status'),
        ),
      ).thenAnswer((_) async => const Left(Failure(message: 'message')));

      final result = await getMatches(
        competition: '',
        dateFrom: DateTime.now(),
        dateTo: DateTime.now(),
        status: MatchStatus.finished,
      );

      expect(result, const Left(Failure(message: 'message')));
    });
  });
}
