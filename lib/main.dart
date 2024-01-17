import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rickandmortyapp/views/character_screen.dart';
import 'package:rickandmortyapp/views/home_screen.dart';

import 'models/character_model.dart';
import 'view_models/api_provider.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: 'character',
          builder: (context, state) {
            final character = state.extra as Character;
            return CharacterScreen(
              character: character,
            );
          },
        )
      ]),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiProvider(),
      child: MaterialApp.router(
        title: 'Rick & Morty Apps',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        routerConfig: _router,
      ),
    );
  }
}
