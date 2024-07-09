import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/title_cubit.freezed.dart';
part 'generated/title_cubit.g.dart';
part 'title_state.dart';

class TitleCubit extends Cubit<TitleState> {
  TitleCubit() : super(TitleState.initial());

  void init() {
    final games = <String>[
      'Fingers',
      'Fingers Survival',
      'Spinner',
      'Struggle Bus',
    ];
    emit(state.copyWith(selectedGameIndex: 0, games: games));
  }

  void changeGame(int index) {
    emit(state.copyWith(selectedGameIndex: index));
  }
}
