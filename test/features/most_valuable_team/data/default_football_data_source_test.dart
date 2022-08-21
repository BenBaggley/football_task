import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:football_mvp/core/domain/failure.dart';
import 'package:football_mvp/features/most_valuable_team/data/data_sources/default_football_data_source.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/football_match.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/team.dart';
import 'package:football_mvp/features/most_valuable_team/domain/enums/match_status.dart';
import 'package:mocktail/mocktail.dart';

import '../../../common.dart';
import '../../../fixtures/fixtures.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio dio;
  late DefaultFootballDataSource dataSource;

  setUp(() {
    dio = MockDio();
    dataSource = DefaultFootballDataSource(dio);
  });

  group(DefaultFootballDataSource, () {
    group('getMatches', () {
      test('success', () async {
        final json = jsonFixture('matches.json');
        final matchesJson = json['matches'] as List;
        final expected = matchesJson
            .map<FootballMatch>(
              (m) => FootballMatch.fromJson(m),
            )
            .toList();

        when(() => dio.get<Map<String, dynamic>>('v4/matches',
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: json,
          ),
        );

        final result = await dataSource.getMatches(
          competition: '',
          dateFrom: DateTime.now(),
          dateTo: DateTime.now(),
          status: MatchStatus.finished,
        );

        final matches = result.getOrElse(() => []);

        expect(matches, containsAll(expected));
      });

      test('failure', () async {
        when(() => dio.get<Map<String, dynamic>>('v4/matches',
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Future.error(dioError()),
        );

        final result = await dataSource.getMatches(
          competition: '',
          dateFrom: DateTime.now(),
          dateTo: DateTime.now(),
          status: MatchStatus.finished,
        );

        expect(result, equals(left(const Failure(message: 'message'))));
      });
    });

    group('getTeam', () {
      test('success', () async {
        final json = jsonFixture('team.json');
        final expected = Team.fromJson(json);

        when(() => dio.get<Map<String, dynamic>>('v4/teams/1')).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: json,
          ),
        );

        final result = await dataSource.getTeam(1);

        expect(result, equals(right(expected)));
      });

      test('failure', () async {
        when(() => dio.get<Map<String, dynamic>>('v4/teams/1')).thenAnswer(
          (_) async => Future.error(dioError()),
        );

        final result = await dataSource.getTeam(1);

        expect(result, equals(left(const Failure(message: 'message'))));
      });
    });
  });
}
