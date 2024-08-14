import 'package:flutter/material.dart';
import 'package:myapp/division_game_page.dart';
import 'package:myapp/end_game_page.dart';
import 'package:myapp/leaderboard_page.dart';
import 'package:myapp/multiplication_game_page.dart';
import 'package:myapp/subtraction_game_page.dart';
import 'package:myapp/sum_game_page.dart';
import 'operation_selection_page.dart'; // Import the new

void main() {
  runApp(SumGameApp());
}

class SumGameApp extends StatelessWidget {
  const SumGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sum Game',
      theme: ThemeData.light(),
      home: MainMenuScreen(), // Start with the menu screen
      routes: {
        '/somaGame': (context) => SumGamePage(),
        '/subtractionGame': (context) => SubtractionGamePage(),
        '/multiplicationGame': (context) => MultiplicationGamePage(),
        '/divisionGame': (context) => DivisionGamePage(),
      },
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Matemática Super Tabuada',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue, // Dark app bar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Cor de destaque
                padding: const EdgeInsets.symmetric(
                    horizontal: 80, vertical: 25), // Aumenta o tamanho
                textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold), // Texto maior e em negrito
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Cantos arredondados
                ),
                elevation: 10, // Sombra para destacar
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OperationSelectionPage(isLearningMode: false)),
                );
              },
              child:
                  const Text('Começar', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20), // Space between buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400],
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OperationSelectionPage(isLearningMode: true)),
                );
              },
              child:
                  const Text('Aprender', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400],
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LeaderboardPage()),
                );
              },
              child: const Text('Pontuações',
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400],
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                // Add functionality for "Sobre" button here
              },
              child: const Text('Sobre', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
