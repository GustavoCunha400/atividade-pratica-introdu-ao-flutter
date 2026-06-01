import 'dart:math';

import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

enum GameState { playing, won, lost }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final Random random = Random();

  late int correctButton;
  int attempts = 0;
  int wins = 0;
  int losses = 0;
  GameState gameState = GameState.playing;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    correctButton = random.nextInt(3);
    attempts = 0;
    gameState = GameState.playing;
  }

  void _attempt(int option) {
    if (gameState != GameState.playing) return;

    setState(() {
      if (option == correctButton) {
        wins++;
        gameState = GameState.won;
        return;
      }

      attempts++;
      if (attempts >= 2) {
        losses++;
        gameState = GameState.lost;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScorePanel(wins: wins, losses: losses, attempts: attempts),
          const SizedBox(height: 24),
          switch (gameState) {
            GameState.playing => GamePlayingWidget(
                  onButtonPressed: _attempt,
                  attempts: attempts,
                ),
            GameState.won => GameResultWidget(
                  message: 'Você ganhou',
                  backgroundColor: Colors.green,
                  buttonText: 'Reiniciar jogo',
                  onRestart: () {
                    setState(_startNewGame);
                  },
                ),
            GameState.lost => GameResultWidget(
                  message: 'Você perdeu',
                  backgroundColor: Colors.red,
                  buttonText: 'Reiniciar jogo',
                  onRestart: () {
                    setState(_startNewGame);
                  },
                ),
          },
        ],
      ),
    );
  }
}

class ScorePanel extends StatelessWidget {
  const ScorePanel({
    super.key,
    required this.wins,
    required this.losses,
    required this.attempts,
  });

  final int wins;
  final int losses;
  final int attempts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Vitórias: $wins   |   Derrotas: $losses',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Tentativas usadas: $attempts / 2',
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class GamePlayingWidget extends StatelessWidget {
  const GamePlayingWidget({
    super.key,
    required this.onButtonPressed,
    required this.attempts,
  });

  final void Function(int) onButtonPressed;
  final int attempts;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          attempts == 0
              ? 'Escolha o botão correto'
              : 'Errado! Você ainda tem ${2 - attempts} tentativa(s)',
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => onButtonPressed(0),
              child: const Text('A'),
            ),
            ElevatedButton(
              onPressed: () => onButtonPressed(1),
              child: const Text('B'),
            ),
            ElevatedButton(
              onPressed: () => onButtonPressed(2),
              child: const Text('C'),
            ),
          ],
        ),
      ],
    );
  }
}

class GameResultWidget extends StatelessWidget {
  const GameResultWidget({
    super.key,
    required this.message,
    required this.backgroundColor,
    required this.buttonText,
    required this.onRestart,
  });

  final String message;
  final Color backgroundColor;
  final String buttonText;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRestart,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
