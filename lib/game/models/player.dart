import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/player.freezed.dart';
part 'generated/player.g.dart';

enum PlayerStatus {
  initial, // Neutral
  won, // Playing/counting down
  lost, // Waiting for animations
  finished, // Completed
}

extension PlayerStatusX on PlayerStatus {
  bool get isPlaying => this == PlayerStatus.initial;
  bool get isDone => this == PlayerStatus.won || this == PlayerStatus.lost;
}

@freezed
class Player with _$Player {
  factory Player({
    required String id,
    required bool safe,
    required bool ready,
    @Default(PlayerStatus.initial) PlayerStatus status,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}
