import 'package:flutter/material.dart';
import 'package:portfolio/home_page.dart';
import 'package:portfolio/theme/app_theme.dart';
import 'package:portfolio/widgets/custom_cursor.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  // Check visibility often enough that scroll reveals feel immediate.
  VisibilityDetectorController.instance.updateInterval =
      const Duration(milliseconds: 60);
  runApp(const FolioApp());
}

class FolioApp extends StatelessWidget {
  const FolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Davies Opoku-Kwarteng — Senior Software Engineer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // Wrapping at the app level keeps the cursor above drawers and dialogs.
      builder: (context, child) => CustomCursor(child: child!),
      home: const HomePage(),
    );
  }
}
