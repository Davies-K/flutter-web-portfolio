// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../presentation/pages/home_page.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<HomePageRouteArgs>(
              orElse: () => const HomePageRouteArgs());
          return _i3.HomePage(key: args.key);
        })
  };

  @override
  List<_i1.RouteConfig> get routes =>
      [_i1.RouteConfig(HomePageRoute.name, path: '/')];
}

class HomePageRoute extends _i1.PageRouteInfo<HomePageRouteArgs> {
  HomePageRoute({_i2.Key? key})
      : super(name, path: '/', args: HomePageRouteArgs(key: key));

  static const String name = 'HomePageRoute';
}

class HomePageRouteArgs {
  const HomePageRouteArgs({this.key});

  final _i2.Key? key;
}
