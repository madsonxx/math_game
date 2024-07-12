import 'package:flutter/material.dart';
import 'package:myapp/division_game_page.dart';
import 'package:myapp/learn_page.dart';
import 'package:myapp/learn_sum_page.dart';
import 'package:myapp/multiplication_game_page.dart';
import 'package:myapp/subtraction_game_page.dart';
import 'package:myapp/sum_game_page.dart';

class PracticeSelectionPage extends StatelessWidget {
  final String operation; // To identify the operation

  const PracticeSelectionPage({Key? key, required this.operation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pratique $operation'), // Dynamic title based on operation
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LearnSumPage(),
                  ),
                );
              },
              child: const Text('Aprender'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Widget gamePage;
                if (operation == 'Soma') {
                  gamePage = const SumGamePage();
                } else if (operation == 'Subtração') {
                  gamePage = const SubtractionGamePage();
                } else if (operation == 'Multiplicação') {
                  gamePage = const MultiplicationGamePage();
                } else if (operation == 'Divisão') {
                  gamePage = const DivisionGamePage();
                } else {
                  // Handle invalid operation (optional)
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => gamePage,
                  ),
                );
              },
              child: const Text('Competir'),
            ),
          ],
        ),
      ),
    );
  }
}
