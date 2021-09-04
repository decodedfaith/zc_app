// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import '../ui/view/login/login_view.dart';
import '../ui/view/nav_bar/nav_bar_view.dart';
import '../ui/view/preference/preference_view.dart';
import '../ui/view/workspace/workspace_different_email/difference_email_workspace_view.dart';

class Routes {
  static const String navBarView = '/';
  static const String loginView = '/login-view';
  static const String preferenceView = '/preference-view';
  static const String useDifferentEmailView = '/use-different-email-view';
  static const all = <String>{
    navBarView,
    loginView,
    preferenceView,
    useDifferentEmailView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.navBarView, page: NavBarView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.preferenceView, page: PreferenceView),
    RouteDef(Routes.useDifferentEmailView, page: UseDifferentEmailView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    NavBarView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const NavBarView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    PreferenceView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const PreferenceView(),
        settings: data,
      );
    },
     UseDifferentEmailView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const UseDifferentEmailView(),
        settings: data,
      );
    },
  };
}
