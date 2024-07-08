import 'package:finger_gang/game/game.dart';
import 'package:finger_gang/l10n/l10n.dart';
import 'package:finger_gang/loading/cubit/cubit.dart';
import 'package:flame/game.dart' hide Route;
import 'package:flame_audio/bgm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    required this.players,
    this.useOnlyOn = false,
    this.basicMode = false,
    super.key,
  });

  final int players;
  final bool useOnlyOn;
  final bool basicMode;

  static Route<void> route({
    required int players,
    required bool useOnlyOn,
    required bool basicMode,
  }) {
    return MaterialPageRoute<void>(
      builder: (_) => GamePage(
        players: players,
        useOnlyOn: useOnlyOn,
        basicMode: basicMode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AudioCubit(audioCache: context.read<PreloadCubit>().audio);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: GameView(
            players: players,
            useOnlyOn: useOnlyOn,
            basicMode: basicMode,
          ),
        ),
      ),
    );
  }
}

class GameView extends StatefulWidget {
  const GameView({
    required this.players,
    this.useOnlyOn = false,
    this.basicMode = false,
    super.key,
    this.game,
  });

  final int players;
  final bool useOnlyOn;
  final bool basicMode;

  final FlameGame? game;

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  FlameGame? _game;

  late final Bgm bgm;

  @override
  void initState() {
    super.initState();
    bgm = context.read<AudioCubit>().bgm;
    //bgm.play(Assets.audio.background);
  }

  @override
  void dispose() {
    bgm.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.white,
          fontSize: 4,
        );

    _game ??= widget.game ??
        FingerGang(
          l10n: context.l10n,
          effectPlayer: context.read<AudioCubit>().effectPlayer,
          textStyle: textStyle,
          images: context.read<PreloadCubit>().images,
        );
    return Stack(
      children: [
        if (!widget.basicMode)
          Positioned.fill(
            child: FingersView(
              numberOfPlayers: widget.players,
              useOnlyOn: widget.useOnlyOn,
            ),
          ),
        if (widget.basicMode)
          Positioned.fill(
            child: FingersViewBasic(numberOfPlayers: widget.players),
          ),
        Align(
          alignment: Alignment.topRight,
          child: BlocBuilder<AudioCubit, AudioState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.volume == 0 ? Icons.volume_off : Icons.volume_up,
                ),
                onPressed: () => context.read<AudioCubit>().toggleVolume(),
              );
            },
          ),
        ),
      ],
    );
  }
}
