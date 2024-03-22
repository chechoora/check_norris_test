import 'package:check_norris_test/view/category/category_widget.dart';
import 'package:check_norris_test/view/favorites_widget/favorite_widget.dart';
import 'package:check_norris_test/view/home_navigation_page.dart';
import 'package:check_norris_test/view/random_joke/random_joke_widget.dart';
import 'package:check_norris_test/view/search/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationManager {
  static const String categoryPath = '/categoryPath';
  static const String searchPath = '/search';
  static const String favoritesPath = '/favorites';
  static const String randomJokePath = '/random_joke';

  late final GoRouter router;
  final GlobalKey<NavigatorState> _parentNavigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _categoryTabNavigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _searchTabNavigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _favoritesTabNavigatorKey = GlobalKey<NavigatorState>();

  NavigationManager() {
    final routes = [
      _homeNavigationRoute(),
      _randomJoke(),
    ];

    router = GoRouter(
      navigatorKey: _parentNavigatorKey,
      initialLocation: categoryPath,
      routes: routes,
    );
  }

  StatefulShellRoute _homeNavigationRoute() {
    return StatefulShellRoute.indexedStack(
      parentNavigatorKey: _parentNavigatorKey,
      branches: [
        StatefulShellBranch(
          navigatorKey: _categoryTabNavigatorKey,
          routes: [
            GoRoute(
              path: categoryPath,
              pageBuilder: (context, GoRouterState state) {
                return MaterialPage(
                  child: CategoryWidget(),
                  key: state.pageKey,
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _searchTabNavigatorKey,
          routes: [
            GoRoute(
              path: searchPath,
              pageBuilder: (context, state) {
                return MaterialPage(
                  child: SearchWidget(),
                  key: state.pageKey,
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _favoritesTabNavigatorKey,
          routes: [
            GoRoute(
              path: favoritesPath,
              pageBuilder: (context, state) {
                return MaterialPage(
                  child: FavoriteWidget(),
                  key: state.pageKey,
                );
              },
            ),
          ],
        ),
      ],
      pageBuilder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        return MaterialPage(
          child: HomeNavigationPage(
            child: navigationShell,
          ),
          key: state.pageKey,
        );
      },
    );
  }

  GoRoute _randomJoke() {
    return GoRoute(
      path: randomJokePath,
      pageBuilder: (context, state) {
        final category = state.extra as String;
        return MaterialPage(
          child: RandomJokeWidget(
            category: category,
          ),
          key: state.pageKey,
        );
      },
    );
  }
}
