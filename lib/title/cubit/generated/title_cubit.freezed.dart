// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../title_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TitleState _$TitleStateFromJson(Map<String, dynamic> json) {
  return _TitleState.fromJson(json);
}

/// @nodoc
mixin _$TitleState {
  int get selectedGameIndex => throw _privateConstructorUsedError;
  List<String> get games => throw _privateConstructorUsedError;
  int get numberOfPlayers => throw _privateConstructorUsedError;
  int get minPlayers => throw _privateConstructorUsedError;
  int get maxPlayers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TitleStateCopyWith<TitleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TitleStateCopyWith<$Res> {
  factory $TitleStateCopyWith(
          TitleState value, $Res Function(TitleState) then) =
      _$TitleStateCopyWithImpl<$Res, TitleState>;
  @useResult
  $Res call(
      {int selectedGameIndex,
      List<String> games,
      int numberOfPlayers,
      int minPlayers,
      int maxPlayers});
}

/// @nodoc
class _$TitleStateCopyWithImpl<$Res, $Val extends TitleState>
    implements $TitleStateCopyWith<$Res> {
  _$TitleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedGameIndex = null,
    Object? games = null,
    Object? numberOfPlayers = null,
    Object? minPlayers = null,
    Object? maxPlayers = null,
  }) {
    return _then(_value.copyWith(
      selectedGameIndex: null == selectedGameIndex
          ? _value.selectedGameIndex
          : selectedGameIndex // ignore: cast_nullable_to_non_nullable
              as int,
      games: null == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as List<String>,
      numberOfPlayers: null == numberOfPlayers
          ? _value.numberOfPlayers
          : numberOfPlayers // ignore: cast_nullable_to_non_nullable
              as int,
      minPlayers: null == minPlayers
          ? _value.minPlayers
          : minPlayers // ignore: cast_nullable_to_non_nullable
              as int,
      maxPlayers: null == maxPlayers
          ? _value.maxPlayers
          : maxPlayers // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TitleStateImplCopyWith<$Res>
    implements $TitleStateCopyWith<$Res> {
  factory _$$TitleStateImplCopyWith(
          _$TitleStateImpl value, $Res Function(_$TitleStateImpl) then) =
      __$$TitleStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int selectedGameIndex,
      List<String> games,
      int numberOfPlayers,
      int minPlayers,
      int maxPlayers});
}

/// @nodoc
class __$$TitleStateImplCopyWithImpl<$Res>
    extends _$TitleStateCopyWithImpl<$Res, _$TitleStateImpl>
    implements _$$TitleStateImplCopyWith<$Res> {
  __$$TitleStateImplCopyWithImpl(
      _$TitleStateImpl _value, $Res Function(_$TitleStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedGameIndex = null,
    Object? games = null,
    Object? numberOfPlayers = null,
    Object? minPlayers = null,
    Object? maxPlayers = null,
  }) {
    return _then(_$TitleStateImpl(
      selectedGameIndex: null == selectedGameIndex
          ? _value.selectedGameIndex
          : selectedGameIndex // ignore: cast_nullable_to_non_nullable
              as int,
      games: null == games
          ? _value._games
          : games // ignore: cast_nullable_to_non_nullable
              as List<String>,
      numberOfPlayers: null == numberOfPlayers
          ? _value.numberOfPlayers
          : numberOfPlayers // ignore: cast_nullable_to_non_nullable
              as int,
      minPlayers: null == minPlayers
          ? _value.minPlayers
          : minPlayers // ignore: cast_nullable_to_non_nullable
              as int,
      maxPlayers: null == maxPlayers
          ? _value.maxPlayers
          : maxPlayers // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TitleStateImpl implements _TitleState {
  _$TitleStateImpl(
      {this.selectedGameIndex = 0,
      final List<String> games = const [''],
      this.numberOfPlayers = 3,
      this.minPlayers = 2,
      this.maxPlayers = 5})
      : _games = games;

  factory _$TitleStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TitleStateImplFromJson(json);

  @override
  @JsonKey()
  final int selectedGameIndex;
  final List<String> _games;
  @override
  @JsonKey()
  List<String> get games {
    if (_games is EqualUnmodifiableListView) return _games;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_games);
  }

  @override
  @JsonKey()
  final int numberOfPlayers;
  @override
  @JsonKey()
  final int minPlayers;
  @override
  @JsonKey()
  final int maxPlayers;

  @override
  String toString() {
    return 'TitleState(selectedGameIndex: $selectedGameIndex, games: $games, numberOfPlayers: $numberOfPlayers, minPlayers: $minPlayers, maxPlayers: $maxPlayers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TitleStateImpl &&
            (identical(other.selectedGameIndex, selectedGameIndex) ||
                other.selectedGameIndex == selectedGameIndex) &&
            const DeepCollectionEquality().equals(other._games, _games) &&
            (identical(other.numberOfPlayers, numberOfPlayers) ||
                other.numberOfPlayers == numberOfPlayers) &&
            (identical(other.minPlayers, minPlayers) ||
                other.minPlayers == minPlayers) &&
            (identical(other.maxPlayers, maxPlayers) ||
                other.maxPlayers == maxPlayers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedGameIndex,
      const DeepCollectionEquality().hash(_games),
      numberOfPlayers,
      minPlayers,
      maxPlayers);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TitleStateImplCopyWith<_$TitleStateImpl> get copyWith =>
      __$$TitleStateImplCopyWithImpl<_$TitleStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TitleStateImplToJson(
      this,
    );
  }
}

abstract class _TitleState implements TitleState {
  factory _TitleState(
      {final int selectedGameIndex,
      final List<String> games,
      final int numberOfPlayers,
      final int minPlayers,
      final int maxPlayers}) = _$TitleStateImpl;

  factory _TitleState.fromJson(Map<String, dynamic> json) =
      _$TitleStateImpl.fromJson;

  @override
  int get selectedGameIndex;
  @override
  List<String> get games;
  @override
  int get numberOfPlayers;
  @override
  int get minPlayers;
  @override
  int get maxPlayers;
  @override
  @JsonKey(ignore: true)
  _$$TitleStateImplCopyWith<_$TitleStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
