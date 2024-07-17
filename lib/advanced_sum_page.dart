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
  int currentStep = 0; // To track which digit the user is working on
  String feedbackMessage = '';
  int sum = 0; // Initialize sum to 0

  String userAnswer = '';
  List<int> carryOvers = [];
  List<TextEditingController> resultControllers = [];

  @override
  void initState() {
    super.initState();
    _generateNumbers();
    currentStep = resultControllers.length - 1;
  }

  void _generateNumbers() {
    Random random = Random();
    firstNumber = random.nextInt(900) + 100; // Numbers from 100 to 999
    secondNumber = random.nextInt(900) + 100;
    int actualSum = firstNumber + secondNumber; // Calculate the actual sum
    int numDigits = actualSum > 999 ? 4 : 3;
    resultControllers =
        List.generate(numDigits, (_) => TextEditingController());
    carryOvers = List.filled(numDigits, 0); // Reset carry-overs
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

  void onNumberButtonPressed(String value) {
    setState(() {
      userAnswer += value;
    });
  }

  void _checkAnswer() {
    int userAnswerInt = int.tryParse(userAnswer) ?? 0;
    int digitSum = 0;

    if (currentStep >= 0) {
      // Make sure currentStep is within bounds
      resultControllers[currentStep].text = userAnswer; // Fill the box
      // Calculate sum for current position (including carry-over)
      digitSum = int.parse(firstNumber.toString()[currentStep]) +
          int.parse(secondNumber.toString()[currentStep]) +
          carryOvers[currentStep];
    }

    if (currentStep == 0 && digitSum >= 10) {
      // If we're at the thousands digit and the sum is >= 10, there's a carry-over
      // You'll need to display this carry-over somehow (e.g., in a message or an extra box)
      print(
          "Carry-over for thousands: ${digitSum ~/ 10}"); // For now, just print it
    } else if (currentStep > 0) {
      carryOvers[currentStep - 1] = digitSum ~/ 10;
    }
    // Trigger a rebuild to show the carry-over box immediately
    setState(() {
      if (currentStep > 0) {
        currentStep--;
        userAnswer = '';
      }
    });

    if (userAnswerInt == sum) {
      setState(() {
        feedbackMessage = 'Correct!';
        _generateNewSum();
        userAnswer = '';
      });
    } else if (userAnswer.length == sum.toString().length) {
      setState(() {
        feedbackMessage = 'Ops! Você respondeu: $userAnswer';
        userAnswer = '';
      });
    }
  }

  void _generateNewSum() {
    Random rand = Random();
    setState(() {
      firstNumber = rand.nextInt(20) + 1;
      secondNumber = rand.nextInt(20) + 1;
      sum = firstNumber + secondNumber; // Calculate the sum
      feedbackMessage = ''; // Clear feedback message
    });
  }

  Widget numberButton(String value) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (value == 'Apagar') {
            if (userAnswer.isNotEmpty) {
              userAnswer = userAnswer.substring(0, userAnswer.length - 1);
            }
          } else {
            onNumberButtonPressed(value);
            // Check answer only if the number of digits in userAnswer matches the sum
            if (userAnswer.length == 1) {
              _checkAnswer();
            }
          }
        });
      },
      child: Text(value, style: const TextStyle(fontSize: 24)),
    );
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
            Text(
              currentStep == 0
                  ? 'Some primeiro os algarismos mais à direita'
                  : 'Continue somando da direita para a esquerda',
              style: const TextStyle(fontSize: 16),
            ),
            // Result row with carry-over boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ..._buildNumberDisplay(firstNumber.toString(), true),
                const SizedBox(width: 110),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Second Number Display
                ..._buildNumberDisplay(secondNumber.toString(), false),
                const SizedBox(width: 110),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                resultControllers.length,
                (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: index == currentStep ? Colors.blue : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: SizedBox(
                      width: 30,
                      height: 40,
                      child: TextField(
                        controller: resultControllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        enabled: index == currentStep,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _checkAnswer();
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ['1', '2', '3'].map((number) {
                    return numberButton(number);
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ['4', '5', '6'].map((number) {
                    return numberButton(number);
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ['7', '8', '9'].map((number) {
                    return numberButton(number);
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ['0', 'Apagar'].map((value) {
                    return numberButton(value);
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Button to check the result (you'll need to implement the verification logic)
            ElevatedButton(
              onPressed: () {
                // ... (Check if the user's input is correct)
              },
              child: const Text('Verificar'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build the number display with highlighted digits
  List<Widget> _buildNumberDisplay(String number, bool isTopNumber) {
    List<Widget> digits = [];
    for (int i = 0; i < number.length; i++) {
      digits.add(
        Column(
          children: [
            if (isTopNumber && i < number.length - 1 && carryOvers[i] > 0)
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                width: 30,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: (currentStep ==
                            i + 1) // Highlight if carry-over exists and it's the next step
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
                child: Center(
                  child: Text(
                    carryOvers[i].toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            Text(
              number[i],
              style: TextStyle(
                fontSize: 36,
                fontWeight:
                    i == currentStep ? FontWeight.bold : FontWeight.normal,
                color: i == currentStep ? Colors.red : Colors.black,
              ),
            ),
            SizedBox(
              width: 45,
            )
          ],
        ),
      );
    }
    return digits;
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
