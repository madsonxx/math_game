import 'package:flutter/material.dart';

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
                Navigator.pushNamed(context, '/somaGame');
              },
              child: const Text('Soma'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle subtração button press
                Navigator.pushNamed(context, '/subtractionGame');
              },
              child: const Text('Subtração'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/multiplicationGame');
                // Handle multiplicação button press
              },
              child: const Text('Multiplicação'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/divisionGame');
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
