// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of '../title_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TitleStateImpl _$$TitleStateImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TitleStateImpl',
      json,
      ($checkedConvert) {
        final val = _$TitleStateImpl(
          selectedGameIndex: $checkedConvert(
              'selected_game_index', (v) => (v as num?)?.toInt() ?? 0),
          games: $checkedConvert(
              'games',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const ['']),
          numberOfPlayers: $checkedConvert(
              'number_of_players', (v) => (v as num?)?.toInt() ?? 3),
          minPlayers:
              $checkedConvert('min_players', (v) => (v as num?)?.toInt() ?? 2),
          maxPlayers:
              $checkedConvert('max_players', (v) => (v as num?)?.toInt() ?? 5),
        );
        return val;
      },
      fieldKeyMap: const {
        'selectedGameIndex': 'selected_game_index',
        'numberOfPlayers': 'number_of_players',
        'minPlayers': 'min_players',
        'maxPlayers': 'max_players'
      },
    );

Map<String, dynamic> _$$TitleStateImplToJson(_$TitleStateImpl instance) =>
    <String, dynamic>{
      'selected_game_index': instance.selectedGameIndex,
      'games': instance.games,
      'number_of_players': instance.numberOfPlayers,
      'min_players': instance.minPlayers,
      'max_players': instance.maxPlayers,
    };
