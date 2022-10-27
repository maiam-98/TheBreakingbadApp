import 'package:flutter/material.dart';
import 'package:movies_app/generate_route.dart';

void main() {
  runApp( MyApp(appRoute: AppRoute(),));
}

class MyApp extends StatelessWidget {

  final AppRoute appRoute;

  const MyApp({super.key, required this.appRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoute.generateRoute,
    );
  }
}
