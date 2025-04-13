//Dylan Neese
//3/13/25
//Rock paper Scissors against CPU

import 'package:flutter/material.dart';
import 'dart:math';
import 'FinalModel.dart'; 

void main() {
  runApp(RockPaperScissorsApp());
}

class RockPaperScissorsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock Paper Scissors',
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GameModel gameModel = GameModel(
    userChoice: '',
    computerChoice: '',
    result: 'Choose your move!',
  );

  final List<String> choices = ['Rock', 'Paper', 'Scissors'];

  String getRandomChoice() {
    final random = Random();
    return choices[random.nextInt(3)];
  }

  String determineWinner(String user, String computer) {
    if (user == computer) return 'Draw!';
    if ((user == 'Rock' && computer == 'Scissors') ||
        (user == 'Paper' && computer == 'Rock') ||
        (user == 'Scissors' && computer == 'Paper')) {
      return 'You Win!';
    } else {
      return 'You Lose!';
    }
  }

  void playGame(String userPick) {
    String compPick = getRandomChoice();
    String outcome = determineWinner(userPick, compPick);

    setState(() {
      gameModel = GameModel(
        userChoice: userPick,
        computerChoice: compPick,
        result: outcome,
      );
    });
  }

  void resetGame() {
    setState(() {
      gameModel = GameModel(
        userChoice: '',
        computerChoice: '',
        result: 'Choose your move!',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rock Paper Scissors')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(gameModel.result, style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            if (gameModel.userChoice.isNotEmpty &&
                gameModel.computerChoice.isNotEmpty)
              Text('You: ${gameModel.userChoice} | CPU: ${gameModel.computerChoice}',
                  style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: choices.map((choice) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () => playGame(choice),
                    child: Text(choice),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: resetGame,
              child: Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }
}
