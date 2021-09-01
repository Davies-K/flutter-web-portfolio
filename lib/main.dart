import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:portfolio/routes/router.gr.dart';

import 'presentation/pages/home_page.dart';

void main() {
  runApp(FolioApp());
}

class FolioApp extends StatelessWidget {
  // This widget is the root of your application.
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp.router(
        title: "Portfolio",
        //theme: AppTheme.lightThemeData,
        debugShowCheckedModeBanner: false,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
