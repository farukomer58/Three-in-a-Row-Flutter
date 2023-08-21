import 'dart:math';

import 'package:flutter/material.dart';
import 'package:three_in_a_row/screens/home_screen.dart';

class GameScreen extends StatefulWidget {
  static const routeName = "/game_screen";

  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late String playerTurn; // Current player's turn
  var gameBoard = List<String>.generate(9, (index) => '',
      growable: false); // Represents the game board
  late bool gameOver;

  @override
  void initState() {
    super.initState();
    // Randomly determine the starting player
    playerTurn = (Random().nextInt(2) == 0) ? "X" : "O";
    gameOver = false;
  }

// Show a dialog to indicate game result and options
  void showFinalDialog(context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("GAME FINISHED"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.headline6,
            ),
            child: const Text('Go to Menu'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.headline6,
            ),
            child: const Text('Restart'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(GameScreen.routeName);
            },
          ),
        ],
      ),
    );
  }

  // Check for a horizontal win
  bool checkHorizontalWin() {
    for (int row = 0; row < 3; row++) {
      if (gameBoard[row * 3] != '' &&
          gameBoard[row * 3] == gameBoard[row * 3 + 1] &&
          gameBoard[row * 3 + 1] == gameBoard[row * 3 + 2]) {
        return true;
      }
    }
    return false;
  }

  // Check for a vertical win
  bool checkVerticalWin() {
    for (int col = 0; col < 3; col++) {
      if (gameBoard[col] != '' &&
          gameBoard[col] == gameBoard[col + 3] &&
          gameBoard[col + 3] == gameBoard[col + 6]) {
        return true;
      }
    }
    return false;
  }

  // Check for a diagonal win
  bool checkDiagonalWin() {
    if (gameBoard[0] != '' &&
        gameBoard[0] == gameBoard[4] &&
        gameBoard[4] == gameBoard[8]) {
      return true;
    }

    if (gameBoard[2] != '' &&
        gameBoard[2] == gameBoard[4] &&
        gameBoard[4] == gameBoard[6]) {
      return true;
    }

    return false;
  }

  // Check for a tie game
  bool checkTieGame() {
    return !gameBoard.contains('');
  }

  // Handle button press
  void handleButtonPress(int index) {
    if (gameOver) return;
    if (gameBoard[index] == "") {
      // if the button has no character yet then you can place
      setState(() {
        gameBoard[index] = playerTurn;
      });

      // Check for winning condition
      if (checkHorizontalWin() || checkVerticalWin() || checkDiagonalWin()) {
        gameOver = true;
        showFinalDialog(context, "THE WINNER IS PLAYER: $playerTurn");
      } else if (checkTieGame()) {
        showFinalDialog(context, "It's a Tie!");
      } else {
        // Switch player's turn
        playerTurn = (playerTurn == "X") ? "O" : "X";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Three-in-a-Row"),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              shrinkWrap: true,
              itemCount: 9,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () => handleButtonPress(index),
                  child: Text(gameBoard[index]),
                );
              },
            ),
            const SizedBox(height: 16),
            Text("TURN: $playerTurn"),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName),
                  child: const Text("Quit"),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  child: const Text('Restart'),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(GameScreen.routeName);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
