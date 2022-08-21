// ignore_for_file: public_member_api_docs
// coverage:ignore-file

/// Represents the status of a [Match].
enum MatchStatus {
  scheduled,
  live,
  inPlay,
  finished,
  paused,
  postponed,
  suspended,
  cancelled
}

extension MatchStatusX on MatchStatus {
  String get jsonValue {
    switch (this) {
      case MatchStatus.scheduled:
        return 'SCHEDULED';
      case MatchStatus.live:
        return 'LIVE';
      case MatchStatus.inPlay:
        return 'IN_PLAY';
      case MatchStatus.finished:
        return 'FINISHED';
      case MatchStatus.paused:
        return 'PAUSED';
      case MatchStatus.postponed:
        return 'POSTPONED';
      case MatchStatus.suspended:
        return 'SUSPENDED';
      case MatchStatus.cancelled:
        return 'CANCELED';
    }
  }
}
