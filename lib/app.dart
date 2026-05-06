import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/app_theme.dart';
import 'features/grid/grid_screen.dart';
import 'features/gym_list/gym_list_screen.dart';
import 'features/gym_settings/gym_settings_screen.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const GymListScreen(),
    ),
    GoRoute(
      path: '/gym/:gymId',
      builder: (_, state) =>
          GridScreen(gymId: state.pathParameters['gymId']!),
      routes: [
        GoRoute(
          path: 'settings',
          builder: (_, state) =>
              GymSettingsScreen(gymId: state.pathParameters['gymId']!),
        ),
      ],
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ボルダリング',
      theme: AppTheme.light,
      routerConfig: _router,
    );
  }
}
