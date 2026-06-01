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
      title: 'Sortear Cor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RandomColorTextPage(),
    );
  }
}

class RandomColorTextPage extends StatefulWidget {
  const RandomColorTextPage({super.key});

  @override
  State<RandomColorTextPage> createState() => _RandomColorTextPageState();
}

class _RandomColorTextPageState extends State<RandomColorTextPage> {
  final Random _random = Random();
  Color _textColor = Colors.black;

  void _sortearCor() {
    setState(() {
      _textColor = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sortear cor'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Toque no botão para sortear a cor do texto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _textColor,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _sortearCor,
                child: const Text('Sortear cor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
