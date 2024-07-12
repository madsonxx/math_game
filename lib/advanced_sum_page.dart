import 'dart:math';

import 'package:flutter/material.dart';

class AdvancedSumPage extends StatefulWidget {
  const AdvancedSumPage({super.key});

  @override
  State<AdvancedSumPage> createState() => _AdvancedSumPageState();
}

class _AdvancedSumPageState extends State<AdvancedSumPage> {
  int firstNumber = 0;
  int secondNumber = 0;
  int carryOverTens = 0;
  int carryOverHundreds = 0;
  List<int> carryOvers = [];
  List<TextEditingController> resultControllers = [];

  @override
  void initState() {
    super.initState();
    _generateNumbers();
  }

  void _generateNumbers() {
    Random random = Random();
    firstNumber = random.nextInt(900) + 100; // Numbers from 100 to 999
    secondNumber = random.nextInt(900) + 100;
    int numDigits = firstNumber
        .toString()
        .length; // Assuming both numbers have the same number of digits
    resultControllers =
        List.generate(numDigits, (_) => TextEditingController());
    carryOvers = List.filled(numDigits, 0);
  }

  void _calculateResult() {
    int unitsDigit = (firstNumber % 10) + (secondNumber % 10);
    carryOverTens = unitsDigit ~/ 10;
    int tensDigit = ((firstNumber ~/ 10) % 10) +
        ((secondNumber ~/ 10) % 10) +
        carryOverTens;
    carryOverHundreds = tensDigit ~/ 10;
    int hundredsDigit =
        (firstNumber ~/ 100) + (secondNumber ~/ 100) + carryOverHundreds;
    // Update result controllers (you'll need to handle user input validation)
    resultControllers[0].text = hundredsDigit.toString();
    resultControllers[1].text = (tensDigit % 10).toString();
    resultControllers[2].text = (unitsDigit % 10).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soma Avançada'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Numbers to be added
            Text(firstNumber.toString(), style: const TextStyle(fontSize: 24)),
            Text(secondNumber.toString(), style: const TextStyle(fontSize: 24)),
            const Divider(),
            // Result row with carry-over boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Carry-over for hundreds
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(firstNumber.toString(), style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 20),
                const Text('+', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 20),
                Text(secondNumber.toString(), style: const TextStyle(fontSize: 24)),
              ],
            ),
            // Dynamic Divider
            LayoutBuilder(
              builder: (context, constraints) {
                return Divider(
                  indent: constraints.maxWidth * 0.2, // Adjust indent as needed
                  endIndent: constraints.maxWidth * 0.2,
                  thickness: 2,
                );
              },
            ),
            // Result row with carry-over boxes and input fields
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(resultControllers.length, (index) {
                return Column(
                  children: [
                    // Carry-over box
                    if (carryOvers[index] > 0)
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(carryOvers[index].toString()),
                      ),
                    // Input field for the digit
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: resultControllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 20),
            // Number buttons (you'll need to create these)
            // ... (Add number buttons from 0 to 9)
            const SizedBox(height: 20),
            // Button to check the result (you'll need to implement the verification logic)
            ElevatedButton(
              onPressed: () {
                // ... (Check if the user's input is correct)
              },
              child: const Text('Verificar'),),
          ],),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose text controllers to prevent memory leaks
    for (var controller in resultControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
