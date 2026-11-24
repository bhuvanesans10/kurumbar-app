import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kurumbar/pages/home_page.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// Single-source-of-truth route configuration following `.ai-skills/frontend/state-network-ui.md`.
final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      name: 'HomePage',
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
