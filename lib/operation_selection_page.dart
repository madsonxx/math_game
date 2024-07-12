import 'package:flutter/material.dart';
import 'package:myapp/practice_or_compete.dart';

class OperationSelectionPage extends StatefulWidget {
  const OperationSelectionPage({super.key});

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
            ElevatedButton(
              onPressed: () {
                // Navigate to the Soma game page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PracticeSelectionPage(operation: 'Soma'),
                  ),
                );
              },
              child: const Text('Soma'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle subtração button press
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PracticeSelectionPage(operation: 'Subtração'),
                  ),
                );
              },
              child: const Text('Subtração'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PracticeSelectionPage(operation: 'Multiplicação'),
                  ),
                );
                // Handle multiplicação button press
              },
              child: const Text('Multiplicação'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PracticeSelectionPage(operation: 'Divisão'),
                  ),
                );

                // Handle divisão button press
              },
              child: const Text('Divisão'),
            ),
          ],
        ),
      ),
    );
  }
}
