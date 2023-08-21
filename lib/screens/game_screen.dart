import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {

  static const routeName = "/game_screen";

  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Screen"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(child: Text("Center Text")),
    );
  }
}
