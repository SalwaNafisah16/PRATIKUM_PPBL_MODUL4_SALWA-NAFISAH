// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:nusantara_cerdas_nav_707012400112/main.dart';


void main() {
  testWidgets(
    'Nusantara Cerdas Mobile menampilkan halaman awal',
    (WidgetTester tester) async {
      await tester.pumpWidget(const NusantaraCerdasApp());
      await tester.pump();

      expect(find.text('Nusantara Cerdas'), findsWidgets);
    },
  );
}
