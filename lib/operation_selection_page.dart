// Suggested code may be subject to a license. Learn more: ~LicenseLog:639453604.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2921497802.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1693533145.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1576461102.
import 'package:flutter/material.dart';
import 'package:myapp/learn_sum_page.dart';
import 'package:myapp/practice_or_compete.dart';
import 'package:myapp/sum_game_page.dart';

class OperationSelectionPage extends StatefulWidget {
  final bool isLearningMode;
  const OperationSelectionPage({super.key, required this.isLearningMode});

  @override
  State<OperationSelectionPage> createState() => _OperationSelectionPageState();
}

class _OperationSelectionPageState extends State<OperationSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha sua operação'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[100],
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              onPressed: () {
                if (widget.isLearningMode) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LearnSumPage()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SumGamePage()));
                }
              },
              child: const Text('Soma'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[200],
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(
                    fontSize: 24,
                    color: Colors.white), // Increased font size and white color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PracticeSelectionPage(operation: 'Subtração')),
                );
              },
              child: const Text('Subtração'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[300],
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(
                    fontSize: 24,
                    color: Colors.white), // Increased font size and white color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PracticeSelectionPage(operation: 'Multiplicação')),
                );
              },
              child: const Text('Multiplicação'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400],
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(
                    fontSize: 24,
                    color: Colors.white), // Increased font size and white color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PracticeSelectionPage(operation: 'Divisão')),
                );
              },
              child: const Text('Divisão'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
