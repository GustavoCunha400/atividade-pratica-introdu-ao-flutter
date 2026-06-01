import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo do Botão Correto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ButtonGamePage(),
    );
  }
}

class ButtonGamePage extends StatefulWidget {
  const ButtonGamePage({super.key});

  @override
  State<ButtonGamePage> createState() => _ButtonGamePageState();
}

class _ButtonGamePageState extends State<ButtonGamePage> {
  final Random _random = Random();
  late int _correctButtonIndex;
  int _attempts = 0;
  String? _message;
  Color _backgroundColor = Colors.white;
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    _correctButtonIndex = _random.nextInt(3);
    _attempts = 0;
    _gameOver = false;
    _message = 'Escolha o botão correto em até 2 tentativas';
    _backgroundColor = Colors.white;
  }

  void _pressButton(int index) {
    if (_gameOver) return;

    setState(() {
      _attempts += 1;

      if (index == _correctButtonIndex) {
        _message = 'Parabéns! Você acertou.';
        _backgroundColor = Colors.green.shade400;
        _gameOver = true;
        return;
      }

      if (_attempts >= 2) {
        _message = 'Você perdeu';
        _backgroundColor = Colors.red.shade400;
        _gameOver = true;
      } else {
        _message = 'Errado! Tente novamente.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Jogo do Botão Correto'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _message ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildGameButton('A', 0),
                  _buildGameButton('B', 1),
                  _buildGameButton('C', 2),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _resetGame,
                child: const Text('Reiniciar jogo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameButton(String label, int index) {
    return ElevatedButton(
      onPressed: _gameOver ? null : () => _pressButton(index),
      child: Text(label),
    );
  }
}
