import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_mvp/core/widgets/loading_indicator.dart';
import 'package:football_mvp/core/widgets/restricted_width.dart';
import 'package:football_mvp/features/most_valuable_team/application/cubit/most_valuable_team_cubit.dart';
import 'package:football_mvp/features/most_valuable_team/presentation/widgets/squad_widget.dart';
import 'package:football_mvp/features/most_valuable_team/presentation/widgets/team_details_widget.dart';
import 'package:football_mvp/l10n/l10n.dart';
import 'package:get_it/get_it.dart';
import 'package:sliver_tools/sliver_tools.dart';

const _maxWidth = 800.0;

/// {@template most_valuable_team_page}
/// Widget displaying the team with most wins in the last 30 days
/// {@endtemplate}
class MostValuableTeamPage extends StatelessWidget {
  /// {@macro most_valuable_team_page}
  const MostValuableTeamPage({super.key});

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
                data: (data) => _TeamBody(data: data),
                loading: (_) => const LoadingIndicator(),
                orElse: () => throw UnimplementedError(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TeamTabBar extends StatelessWidget {
  const _TeamTabBar();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SliverPinnedHeader(
      child: Card(
        margin: EdgeInsets.zero,
        color: colorScheme.surface,
        child: RestrictedWidth(
            maxWidth: _maxWidth,
            child: TabBar(
              labelColor: colorScheme.onSurface,
              indicatorColor: colorScheme.primary,
              tabs: [
                Tab(text: context.l10n.detailsLabel),
                Tab(text: context.l10n.squadLabel),
              ],
            )),
      ),
    );
  }
}

class _TeamHeader extends StatelessWidget {
  final MostValuableStateData data;

  const _TeamHeader({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ignore: avoid_unnecessary_containers
    return Container(
      padding: const EdgeInsets.all(16),
      color: theme.colorScheme.surface,
      alignment: Alignment.center,
      child: RestrictedWidth(
        maxWidth: _maxWidth,
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

class _TeamBody extends StatelessWidget {
  final MostValuableStateData data;

  const _TeamBody({required this.data});

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          if (queryData.orientation == Orientation.portrait)
            SliverPinnedHeader(child: _TeamHeader(data: data))
          else
            SliverToBoxAdapter(
              child: _TeamHeader(data: data),
            ),
          const _TeamTabBar(),
        ];
      },
      body: SafeArea(
        child: TabBarView(
          children: [
            RestrictedWidth(
                maxWidth: _maxWidth, child: TeamDetailsWidget(team: data.team)),
            RestrictedWidth(
                maxWidth: _maxWidth, child: SquadWidget(team: data.team)),
          ],
        ),
      ),
    );
  }
}
