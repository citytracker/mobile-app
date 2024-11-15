import 'package:flutter/material.dart';
import 'package:minhacidademeuproblema/core/get_it/getit_core.dart';
import 'package:minhacidademeuproblema/core/routes/routes.dart';

void main() {
  GetItCore.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha cidade, meu problema',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
              toolbarHeight: 50,
              toolbarTextStyle: const TextStyle(fontSize: 20),
              titleTextStyle: const TextStyle(fontSize: 18),
              shadowColor: Colors.white,
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue.shade300),
          primaryColor: Colors.blue),
      routes: Routes.getRoutes(context),
    );
  }
}
