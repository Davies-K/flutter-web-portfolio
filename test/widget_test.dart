import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/showcase/code_panel.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  testWidgets('home page renders key sections', (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const FolioApp());
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Connect with Me'), findsOneWidget);
    expect(find.text('Services'), findsWidgets);
    expect(find.text('Resume'), findsWidgets);
  });

  testWidgets('show me the code panel opens and shows source', (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const FolioApp());
    await tester.pump(const Duration(seconds: 2));

    ShowcaseController.instance.open();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('~/davies/show-me-the-code'), findsOneWidget);

    await tester.tap(find.text('Code'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('dashboard.dart'), findsOneWidget);

    ShowcaseController.instance.close();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('~/davies/show-me-the-code'), findsNothing);
  });
}
