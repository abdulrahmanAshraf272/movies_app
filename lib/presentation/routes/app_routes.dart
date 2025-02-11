import 'package:flutter/material.dart';
import 'package:movies_app/presentation/routes/route_names.dart';
import 'package:movies_app/presentation/screens/home/home_screen.dart';

class AppRoutes {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
