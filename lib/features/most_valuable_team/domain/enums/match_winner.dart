// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

/// Represents the winner of a [Match].
@JsonEnum()
enum MatchWinner {
  @JsonValue('HOME_TEAM')
  home,
  @JsonValue('AWAY_TEAM')
  away,
  @JsonValue('DRAW')
  draw
}
