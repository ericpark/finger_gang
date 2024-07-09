import 'package:finger_gang/title/title.dart';
import 'package:finger_gang/title/view/fingers_title_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../helpers/helpers.dart';

void main() {
  group('TitlePage', () {
    testWidgets('renders TitleView', (tester) async {
      await tester.pumpApp(const TitlePage());
      expect(find.byType(FingersTitleView), findsOneWidget);
    });
  });

  group('TitleView', () {
    testWidgets('renders start button', (tester) async {
      await tester.pumpApp(const FingersTitleView());

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('starts the game when start button is tapped', (tester) async {
      final navigator = MockNavigator();
      when(navigator.canPop).thenReturn(true);
      when(
        () => navigator.pushReplacement<void, void>(any()),
      ).thenAnswer((_) async {});

      await tester.pumpApp(const FingersTitleView(), navigator: navigator);

      await tester.tap(find.byType(ElevatedButton));

      verify(() => navigator.pushReplacement<void, void>(any())).called(1);
    });
  });
}
