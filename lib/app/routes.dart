import 'package:football_mvp/features/most_valuable_team/presentation/most_valuable_team_page.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> get appRoutes => [
      GoRoute(
        path: '/',
        builder: ((context, state) => const MostValuableTeamPage()),
      ),
    ];
