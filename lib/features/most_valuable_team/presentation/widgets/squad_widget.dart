import 'package:flutter/material.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/player.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/team.dart';

/// {@template squad_widget}
/// Widget displaying squad of a team.
/// {@endtemplate}
class SquadWidget extends StatelessWidget {
  /// {@macro squad_widget}
  const SquadWidget({Key? key, required this.team}) : super(key: key);

  /// The team to display.
  final Team team;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: team.squad.length,
      itemBuilder: (context, index) => _playerItem(
        context,
        team.squad[index],
      ),
    );
  }

  Widget _playerItem(BuildContext context, Player player) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.surface,
      title: Text(player.name),
      subtitle: Text(player.position),
    );
  }
}
