import 'package:check_norris_test/di/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.read(navigationManager);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: manager.router,
    );
  }
}
