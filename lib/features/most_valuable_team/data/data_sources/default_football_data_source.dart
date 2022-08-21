import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:football_mvp/core/data/network_utils.dart';
import 'package:football_mvp/core/domain/failure.dart';
import 'package:football_mvp/core/extensions/date_time_format.dart';
import 'package:football_mvp/features/most_valuable_team/domain/data_sources/football_data_source.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/football_match.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/team.dart';
import 'package:football_mvp/features/most_valuable_team/domain/enums/match_status.dart';
import 'package:injectable/injectable.dart';

/// {@template default_football_data_source}
/// Default implementation of [FootballDataSource] using [Dio]
/// {@endtemplate}
@Injectable(as: FootballDataSource)
class DefaultFootballDataSource implements FootballDataSource {
  final Dio _dio;

  /// {@macro default_football_data_source}
  const DefaultFootballDataSource(this._dio);

  @override
  Future<Either<Failure, List<FootballMatch>>> getMatches({
    required String competition,
    required DateTime dateFrom,
    required DateTime dateTo,
    required MatchStatus status,
  }) {
    return catchFailure(() async {
      final result = await _dio.get<Map<String, dynamic>>(
        'v4/matches',
        queryParameters: {
          'competitions': [competition],
          'dateFrom': dateFrom.formatDate(),
          'dateTo': dateTo.formatDate(),
          'status': status.jsonValue,
          'limit': 1000,
        },
      );

      final matches = result.data!['matches'] as List;
      return matches.map((m) => FootballMatch.fromJson(m)).toList();
    });
  }

  @override
  Future<Either<Failure, Team>> getTeam(int id) {
    return catchFailure(() async {
      final result = await _dio.get<Map<String, dynamic>>(
        'v4/teams/$id',
      );

      return Team.fromJson(result.data!);
    });
  }
}
