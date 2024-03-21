import 'package:check_norris_test/view/category/category_widget.dart';
import 'package:check_norris_test/view/favorites_widget/favorites_widget.dart';
import 'package:check_norris_test/view/home_navigation_page.dart';
import 'package:check_norris_test/view/random_joke/random_joke_widget.dart';
import 'package:check_norris_test/view/search/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationManager {
  static void init() {
    final routes = [
      homeNavigationRoute(),
      randomJoke(),
    ];

    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: categoryPath,
      routes: routes,
    );
  }

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> categoryTabNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> searchTabNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> favoritesTabNavigatorKey = GlobalKey<NavigatorState>();

  static const String categoryPath = '/categoryPath';
  static const String searchPath = '/search';
  static const String favoritesPath = '/favorites';

  static const String randomJokePath = '/random_joke';

  static StatefulShellRoute homeNavigationRoute() {
    return StatefulShellRoute.indexedStack(
      parentNavigatorKey: parentNavigatorKey,
      branches: [
        StatefulShellBranch(
          navigatorKey: categoryTabNavigatorKey,
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
          navigatorKey: searchTabNavigatorKey,
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
          navigatorKey: favoritesTabNavigatorKey,
          routes: [
            GoRoute(
              path: favoritesPath,
              pageBuilder: (context, state) {
                return MaterialPage(
                  child: const FavoritesWidget(),
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

  static GoRoute randomJoke() {
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
