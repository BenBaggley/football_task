import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_mvp/features/most_valuable_team/application/cubit/most_valuable_team_cubit.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/team.dart';
import 'package:football_mvp/features/most_valuable_team/domain/enums/match_status.dart';
import 'package:football_mvp/features/most_valuable_team/domain/enums/match_winner.dart';
import 'package:football_mvp/features/most_valuable_team/domain/use_cases/get_matches.dart';
import 'package:football_mvp/features/most_valuable_team/domain/use_cases/get_team.dart';
import 'package:football_mvp/l10n/l10n.dart';
import 'package:get_it/get_it.dart';

class MostValuableTeamPage extends StatefulWidget {
  const MostValuableTeamPage({Key? key}) : super(key: key);

  @override
  State<MostValuableTeamPage> createState() => _MostValuableTeamPageState();
}

class _MostValuableTeamPageState extends State<MostValuableTeamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return state.maybeWhen(
              initial: () => const SizedBox(),
              data: (team) => buildBody(context, team),
              loading: () => buildLoading(context),
              orElse: () => throw FallThroughError(),
            );
          },
        ),
      ),
    );
  }

  Widget buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  Widget buildBody(BuildContext context, Team team) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(team.name),
          ),
        ),
      ],
    );
  }
}
