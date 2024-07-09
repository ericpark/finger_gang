part of 'title_cubit.dart';

@freezed
abstract class TitleState with _$TitleState {
  factory TitleState({
    @Default(0) int selectedGameIndex,
    @Default(['']) List<String> games,
    @Default(3) int numberOfPlayers,
    @Default(2) int minPlayers,
    @Default(5) int maxPlayers,
  }) = _TitleState;

  factory TitleState.initial() => _TitleState();

  factory TitleState.fromJson(Map<String, dynamic> json) =>
      _$TitleStateFromJson(json);
}
