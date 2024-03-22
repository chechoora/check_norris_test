import 'package:check_norris_test/router/navigation_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationManager = Provider<NavigationManager>((ref) {
  return NavigationManager();
});
