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
      home: MainMenuScreen(), // Start with the menu screen
      routes: {
        '/somaGame': (context) => SumGamePage(),
        '/operations': (context) => OperationSelectionPage(),
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
      backgroundColor: Colors.grey[900], // Dark background
      appBar: AppBar(
        title:
            const Text('Sum Game Menu', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[800], // Dark app bar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400], // Futuristic blue button
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OperationSelectionPage()),
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
                      builder: (context) => const LeaderboardPage()),
                );
              },
              child: const Text('Liderança',
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
                // Add functionality for "Configurações" button here
              },
              child: const Text('Configurações',
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

