import 'package:flutter/material.dart';
import 'package:three_in_a_row/screens/game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Start Game"),
          onPressed: () {
            Navigator.pushReplacementNamed(context, GameScreen.routeName);
          },
        ),
      ),
    );
  }
}
