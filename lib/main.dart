import 'package:flutter/material.dart';
import 'package:myapp/division_game_page.dart';
import 'package:myapp/multiplication_game_page.dart';
import 'package:myapp/subtraction_game_page.dart';
import 'dart:async';
import 'dart:math';
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
        '/somaGame': (context) => SumGameScreen(),
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
                // Add functionality for "Liderança" button here
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

// Your existing SumGameScreen class remains unchanged
class SumGameScreen extends StatefulWidget {
  const SumGameScreen({super.key});

  @override
  _SumGameScreenState createState() => _SumGameScreenState();
}

class _SumGameScreenState extends State<SumGameScreen> {
  String userInput = ''; // Store the user's input as a string
  int sum = 0; // Initialize sum to 0
  String feedbackMessage = '';
  int firstNumber = 0;
  int secondNumber = 0;
  int score = 0;
  String userAnswer = '';
  String correctAnswer = '';
  late Timer timer;
  int remainingTime = 60;

  @override
  void initState() {
    super.initState();
    _generateNewSum();
    startTimer();
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

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _handleButtonClick(String buttonText) {
    setState(() {
      if (buttonText == '<') {
        // Back arrow button
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
      } else {
        userInput += buttonText;
      }
      _checkAnswer();
    });
  }

  void _checkAnswer() {
    int userAnswerInt = int.tryParse(userAnswer) ?? 0;
    if (userAnswerInt == sum) {
      setState(() {
        score++;
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

  void onNumberButtonPressed(String value) {
    setState(() {
      userAnswer += value;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sum Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('Time: $remainingTime',
                      style: const TextStyle(fontSize: 24)),
                  Text('Score: $score', style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 20),
                  Text(
                    feedbackMessage,
                    style: const TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('$firstNumber + $secondNumber',
                      style: const TextStyle(fontSize: 36)),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your Answer',
                    ),
                    readOnly: true,
                    controller: TextEditingController(text: userAnswer),
                  ),
                  const SizedBox(height: 20),
                  correctAnswer.isNotEmpty
                      ? Text('Correct Answer: $correctAnswer',
                          style:
                              const TextStyle(color: Colors.red, fontSize: 20))
                      : Container(),
                ],
              ),
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
            ]),
      ),
    );
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
            if (userAnswer.length == sum.toString().length) {
              _checkAnswer();
            }
          }
        });
      },
      child: Text(value, style: const TextStyle(fontSize: 24)),
    );
  }
}
