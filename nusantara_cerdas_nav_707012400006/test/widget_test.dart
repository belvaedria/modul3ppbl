// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:nusantara_cerdas_nav_707012400006/main.dart';
import 'package:nusantara_cerdas_nav_707012400006/models/favorit_model.dart';
import 'package:nusantara_cerdas_nav_707012400006/models/pengajuan_model.dart';

void main() {
  testWidgets('app starts and shows the home screen',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(411, 866);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    addTearDown(() => tester.view.resetDevicePixelRatio());

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FavoritModel()),
          ChangeNotifierProvider(create: (_) => PengajuanModel()),
        ],
        child: const NusantaraCerdasApp(),
      ),
    );

    expect(find.text('Kota Nusantara'), findsOneWidget);
    expect(find.text('Menuju Kota Cerdas dan Berkelanjutan'), findsOneWidget);
  });
}
