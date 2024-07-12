import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp/advanced_sum_page.dart';

class LearnSumPage extends StatefulWidget {
  const LearnSumPage({super.key});

  @override
  State<LearnSumPage> createState() => _LearnSumPageState();
}

class _LearnSumPageState extends State<LearnSumPage> {
  int firstNumber = 0;
  int secondNumber = 0;
  int correctAnswer = 0;
  bool showIncorrectMessage = false;

  List<int> answerOptions = [];
  @override
  void initState() {
    super.initState();
    _generateNewSum();
  }

  void _generateNewSum() {
    Random random = Random();
    firstNumber = random.nextInt(10) + 1; // Numbers from 1 to 10
    secondNumber = random.nextInt(10) + 1;
    correctAnswer = firstNumber + secondNumber;
    // Generate answer options
    answerOptions = [
      correctAnswer,
      correctAnswer + random.nextInt(3) + 1, // Wrong answers close to correct
      correctAnswer - random.nextInt(3) - 1
    ];
    answerOptions.shuffle(); // Shuffle the options
  }

  void _handleAnswer(int selectedAnswer) {
    if (selectedAnswer == correctAnswer) {
      // Handle correct answer (e.g., show feedback, increment score)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Correto!')),
      );
      setState(() {
        // Trigger UI update
        _generateNewSum();
      });
    } else {
      setState(() {
        showIncorrectMessage = true;
      });
      // Optionally, hide the message after a short delay:
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          showIncorrectMessage = false;
        });
      });
      // Handle incorrect answer (e.g., show feedback)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tente novamente!')),
      );
    }
    _generateNewSum(); // Generate a new sum after each answer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aprenda Soma'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the sum
            Text(
              '$firstNumber + $secondNumber = ?',
              style: const TextStyle(fontSize: 36),
            ),
            const SizedBox(height: 20),
            // Display the dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Dots for the first number
                _buildDotGroup(firstNumber),
                const SizedBox(width: 30),

                // Dots for the second number
                _buildDotGroup(secondNumber),
              ],
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround, // Distribute buttons evenly
              children: answerOptions
                  .map((option) => ElevatedButton(
                        onPressed: () => _handleAnswer(option),
                        child: Text(option.toString()),
                      ))
                  .toList(), // Convert the Iterable to a List
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        // Add BottomAppBar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back
              },
              child: const Text('Voltar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdvancedSumPage()));
              },
              child: const Text('Avançar'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildDot() {
  return Container(
    margin: const EdgeInsets.all(5),
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.blue,
    ),
    width: 15,
    height: 15,
  );
}

Widget _buildDotGroup(int number) {
  List<Widget> dots = [];
  int fullGroups = number ~/ 5; // Number of full 5-dot groups
  int remainingDots = number % 5; // Remaining dots
  // Build full 5-dot groups
  for (int i = 0; i < fullGroups; i++) {
    dots.add(_buildFiveDotPattern());
    dots.add(const SizedBox(width: 10)); // Space between groups
  }
  // Build remaining dots
  if (remainingDots > 0) {
    dots.add(_buildPartialDotPattern(remainingDots));
  }
  return Row(children: dots);
}

// Widget for a full 5-dot pattern
Widget _buildFiveDotPattern() {
  return SizedBox(
    height: 70,
    width: 60, // Adjust width as needed
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Four dots in a square
        Positioned(top: 10, left: 0, child: _buildDot()),
        Positioned(top: 10, right: 0, child: _buildDot()),
        Positioned(bottom: 10, left: 0, child: _buildDot()),
        Positioned(bottom: 10, right: 0, child: _buildDot()),
        // Center dot
        Positioned(child: _buildDot())
      ],
    ),
  );
}

// Widget for a partial dot pattern (less than 5 dots)
Widget _buildPartialDotPattern(int count) {
  if (count == 1) {
    return _buildDot();
  } else if (count == 2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(),
        _buildDot(),
      ],
    );
  } else if (count == 3) {
    return SizedBox(
      height: 70,
      width: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              _buildDot(),
            ],
          ),
          Column(
            children: [
              _buildDot(),
              _buildDot(),
            ],
          ),
        ],
      ),
    );
  } else if (count == 4) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Positioned(top: 10, left: 0, child: _buildDot()),
              Positioned(top: 10, right: 0, child: _buildDot()),
            ],
          ),
          Column(
            children: [
              Positioned(bottom: 10, left: 0, child: _buildDot()),
              Positioned(bottom: 10, right: 0, child: _buildDot()),
            ],
          ),
        ],
      ),
    );
  } else if (count == 5) {
    return _buildFiveDotPattern(); // Use the existing function
  }
  return Container(); // Handle invalid count (optional)
}

// Widget for a single dot

