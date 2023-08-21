import 'package:flutter/material.dart';
import 'package:three_in_a_row/screens/game_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.red,
            child: const Padding(
              padding: EdgeInsets.only(top: 100.0),
              // Adjust the top padding as needed
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Three-in-a-Row", // Your custom title
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text("Start Game"),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, GameScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
