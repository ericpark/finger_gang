// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of '../player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerImpl _$$PlayerImplFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$PlayerImpl',
      json,
      ($checkedConvert) {
        final val = _$PlayerImpl(
          id: $checkedConvert('id', (v) => v as String),
          safe: $checkedConvert('safe', (v) => v as bool),
          ready: $checkedConvert('ready', (v) => v as bool),
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$PlayerStatusEnumMap, v) ??
                  PlayerStatus.initial),
        );
        return val;
      },
    );

Map<String, dynamic> _$$PlayerImplToJson(_$PlayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'safe': instance.safe,
      'ready': instance.ready,
      'status': _$PlayerStatusEnumMap[instance.status]!,
    };

const _$PlayerStatusEnumMap = {
  PlayerStatus.initial: 'initial',
  PlayerStatus.won: 'won',
  PlayerStatus.lost: 'lost',
  PlayerStatus.finished: 'finished',
};
