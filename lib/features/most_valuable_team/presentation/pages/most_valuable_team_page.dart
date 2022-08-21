import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_mvp/features/most_valuable_team/application/cubit/most_valuable_team_cubit.dart';
import 'package:football_mvp/features/most_valuable_team/presentation/widgets/squad_widget.dart';
import 'package:football_mvp/features/most_valuable_team/presentation/widgets/team_details_widget.dart';
import 'package:football_mvp/l10n/l10n.dart';
import 'package:get_it/get_it.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// {@template most_valuable_team_page}
/// Widget displaying the team with most wins in the last 30 days
/// {@endtemplate}
class MostValuableTeamPage extends StatefulWidget {
  /// {@macro most_valuable_team_page}
  const MostValuableTeamPage({Key? key}) : super(key: key);

  @override
  State<MostValuableTeamPage> createState() => _MostValuableTeamPageState();
}

class _MostValuableTeamPageState extends State<MostValuableTeamPage> {
  final maxWidth = 800.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.appName),
          centerTitle: true,
        ),
        body: BlocProvider<MostValuableTeamCubit>(
          create: (_) => GetIt.I()..load(),
          child: BlocConsumer<MostValuableTeamCubit, MostValuableTeamState>(
            listener: (context, state) {},
            buildWhen: (_, state) => state is! MostValuableStateFailure,
            builder: (context, state) {
              return state.maybeMap(
                initial: (_) => const SizedBox(),
                data: (data) => buildBody(context, data),
                loading: (_) => buildLoading(context),
                orElse: () => throw FallThroughError(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  Widget buildBody(BuildContext context, MostValuableStateData data) {
    final queryData = MediaQuery.of(context);

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          if (queryData.orientation == Orientation.portrait)
            SliverPinnedHeader(child: buildHeader(context, data))
          else
            SliverToBoxAdapter(
              child: buildHeader(context, data),
            ),
          tabBar(context),
        ];
      },
      body: SafeArea(
        child: TabBarView(
          children: [
            restrictWidth(child: TeamDetailsWidget(team: data.team)),
            restrictWidth(child: SquadWidget(team: data.team)),
          ],
        ),
      ),
    );
  }

  Widget tabBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SliverPinnedHeader(
      child: Card(
        margin: EdgeInsets.zero,
        color: colorScheme.surface,
        child: restrictWidth(
          child: TabBar(
            labelColor: colorScheme.onSurface,
            indicatorColor: colorScheme.primary,
            tabs: [
              Tab(text: context.l10n.detailsLabel),
              Tab(text: context.l10n.squadLabel),
            ],
          ),
        ),
      ),
    );
  }

  Widget restrictWidth({required Widget child}) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }

  Widget buildHeader(BuildContext context, MostValuableStateData data) {
    final theme = Theme.of(context);

    // ignore: avoid_unnecessary_containers
    return Container(
      padding: const EdgeInsets.all(16),
      color: theme.colorScheme.surface,
      alignment: Alignment.center,
      child: restrictWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.l10n.mostValuableHeader(data.wins),
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (data.team.crestUrl != null)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Image.network(
                      data.team.crestUrl!,
                      height: 40,
                      width: 40,
                    ),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    data.team.name,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
