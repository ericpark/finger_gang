import 'package:finger_gang/l10n/l10n.dart';
import 'package:finger_gang/title/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const TitlePage(),
    );
  }

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  late InfiniteScrollController controller;

  final _itemExtent = 200.0;

  @override
  void initState() {
    super.initState();
    controller = InfiniteScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.titleAppBarTitle)),
      body: BlocBuilder<TitleCubit, TitleState>(
        builder: (context, state) {
          return SafeArea(
            child: Flex(
              direction: Axis.vertical,
              children: [
                SizedBox(
                  height: 200,
                  child: InfiniteCarousel.builder(
                    itemCount: 3,
                    itemExtent: _itemExtent,
                    // center: true,
                    //anchor: 0.0,
                    velocityFactor: 0.85,
                    onIndexChanged: (index) {
                      setState(() {
                        context.read<TitleCubit>().changeGame(index);
                      });
                    },
                    controller: controller,
                    //axisDirection: Axis.horizontal,
                    itemBuilder: (context, itemIndex, realIndex) {
                      final currentOffset = _itemExtent * realIndex;
                      return AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) {
                          // ignore: unnecessary_parenthesis
                          final diff = (controller.offset - currentOffset);
                          const maxPadding = 10.0;
                          final carouselRatio = _itemExtent / maxPadding;

                          return Padding(
                            padding: EdgeInsets.only(
                              top: (diff / carouselRatio).abs(),
                              bottom: (diff / carouselRatio).abs(),
                            ),
                            child: child,
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Center(
                              child: Text(
                                state.games[itemIndex],
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Expanded(child: TitleView()),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TitleView extends StatelessWidget {
  const TitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TitleCubit, TitleState>(
      builder: (context, state) {
        return Center(
          child: switch (state.games[state.selectedGameIndex]) {
            'Fingers' => const FingersTitleView(),
            'Fingers Survival' => const FingersSurvivalView(),
            'Spinner' => const SpinnerTitleView(),
            'Struggle Bus' => const Text('Struggle Bus'),
            String() => Container(),
          },
        );
      },
    );
  }
}
