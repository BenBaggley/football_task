import 'package:flutter/material.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/coach.dart';
import 'package:football_mvp/features/most_valuable_team/domain/entities/team.dart';
import 'package:football_mvp/l10n/l10n.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// {@template team_details_widget}
/// Widget displaying details of a team.
/// {@endtemplate}
class TeamDetailsWidget extends StatelessWidget {
  /// {@macro team_details_widget}
  const TeamDetailsWidget({Key? key, required this.team}) : super(key: key);

  /// The team to display.
  final Team team;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _coachCard(context, team.coach),
        if (team.venue != null) _venueCard(context, team),
        if (team.website != null) _websiteCard(context, team.website!),
      ],
    );
  }

  Widget _coachCard(BuildContext context, Coach coach) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.l10n.coachLabel,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _detailWidget(
              context,
              label: context.l10n.nameLabel,
              value: coach.name,
            ),
            const SizedBox(height: 4),
            _detailWidget(
              context,
              label: context.l10n.nationalityLabel,
              value: coach.nationality,
            ),
          ],
        ),
      ),
    );
  }

  Widget _venueCard(BuildContext context, Team team) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.l10n.venueLabel,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              team.venue ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (team.address != null) ...[
              const SizedBox(height: 4),
              _detailWidget(
                context,
                label: context.l10n.addressLabel,
                value: team.address!,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _openMaps(team.address!),
                child: Text(context.l10n.viewMapButton),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _websiteCard(BuildContext context, String website) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.l10n.websiteLabel,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              website,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _openWebsite(website),
              child: Text(context.l10n.visitButton),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailWidget(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Text(
          '$label:',
          style: Theme.of(context).textTheme.caption?.copyWith(
                fontSize: 14,
              ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Future<void> _openMaps(String address) => MapsLauncher.launchQuery(address);

  Future<void> _openWebsite(String website) => launchUrlString(
        website,
        mode: LaunchMode.externalApplication,
      );
}
