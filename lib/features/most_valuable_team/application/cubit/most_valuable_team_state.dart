part of 'most_valuable_team_cubit.dart';

@freezed
class MostValuableTeamState with _$MostValuableTeamState {
  const factory MostValuableTeamState.initial() = MostValuableStateInitial;
  const factory MostValuableTeamState.loading() = MostValuableStateLoading;
  const factory MostValuableTeamState.data(Team team) = MostValuableStateData;
  const factory MostValuableTeamState.failure(String message) =
      MostValuableStateFailure;
}
