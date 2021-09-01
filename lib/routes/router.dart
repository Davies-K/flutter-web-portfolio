import 'package:auto_route/annotations.dart';
import 'package:portfolio/presentation/pages/home_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(page: HomePage, initial: true),
  ],
)
class $AppRouter {}
