import 'package:check_norris_test/router/navigation_manager.dart';
import 'package:flutter/material.dart';

void main() {
  NavigationManager.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: NavigationManager.router,
    );
  }
}
