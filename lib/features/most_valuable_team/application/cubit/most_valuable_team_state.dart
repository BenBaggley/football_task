part of 'most_valuable_team_cubit.dart';

/// States of the [MostValuableTeamCubit]
@freezed
class MostValuableTeamState with _$MostValuableTeamState {
  /// Initial state
  const factory MostValuableTeamState.initial() = MostValuableStateInitial;

  /// Loading state
  const factory MostValuableTeamState.loading() = MostValuableStateLoading;

  /// Data (successful) state
  const factory MostValuableTeamState.data({
    required Team team,
    required int wins,
  }) = MostValuableStateData;

  /// Error state
  const factory MostValuableTeamState.failure(String message) =
      MostValuableStateFailure;
}
