import 'package:football_mvp/features/most_valuable_team/presentation/pages/most_valuable_team_page.dart';
import 'package:go_router/go_router.dart';

/// Routes for the app
List<GoRoute> get appRoutes => [
      GoRoute(
        path: '/',
        builder: ((context, state) => const MostValuableTeamPage()),
      ),
    ];
