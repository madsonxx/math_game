import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class DivisionGamePage extends StatefulWidget {
  const DivisionGamePage({super.key});

  @override
  State<DivisionGamePage> createState() => _DivisionGamePageState();
}

class _DivisionGamePageState extends State<DivisionGamePage> {
  List<List<int>> divisionTablePairs = [
    // Division by 1
    [1, 1], [2, 1], [3, 1], [4, 1], [5, 1], [6, 1], [7, 1], [8, 1], [9, 1],
    [10, 1],

    // Division by 2
    [2, 2], [4, 2], [6, 2], [8, 2], [10, 2], [12, 2], [14, 2], [16, 2], [18, 2],
    [20, 2],

    // Division by 3
    [3, 3], [6, 3], [9, 3], [12, 3], [15, 3], [18, 3], [21, 3], [24, 3],
    [27, 3], [30, 3],

// Division by 4
    [4, 4], [8, 4], [12, 4], [16, 4], [20, 4], [24, 4], [28, 4], [32, 4],
    [36, 4], [40, 4],
    // Division by 5
    [5, 5], [10, 5], [15, 5], [20, 5], [25, 5], [30, 5], [35, 5], [40, 5],
    [45, 5], [50, 5],
    // Division by 6
    [6, 6], [12, 6], [18, 6], [24, 6], [30, 6], [36, 6], [42, 6], [48, 6],
    [54, 6], [60, 6],
    // Division by 7
    [7, 7], [14, 7], [21, 7], [28, 7], [35, 7], [42, 7], [49, 7], [56, 7],
    [63, 7], [70, 7],
    // Division by 8
    [8, 8], [16, 8], [24, 8], [32, 8], [40, 8], [48, 8], [56, 8], [64, 8],
    [72, 8], [80, 8],
    // Division by 9
    [9, 9], [18, 9], [27, 9], [36, 9], [45, 9], [54, 9], [63, 9], [72, 9],
    [81, 9], [90, 9],
    // Division by 10
    [10, 10], [20, 10], [30, 10], [40, 10], [50, 10], [60, 10], [70, 10],
    [80, 10], [90, 10], [100, 10]
  ];

  String userInput = ''; // Store the user's input as a string
  int resultDiv = 0; // Initialize sum to 0
  String feedbackMessage = '';
  int num1 = 0;
  int num2 = 0;
  int score = 0;
  String userAnswer = '';
  String correctAnswer = '';
  late Timer timer;
  int remainingTime = 60;

  @override
  void initState() {
    super.initState();
    _generateNewDiv();
    startTimer();
  }

  void _generateNewDiv() {
    Random rand = Random();
    int randomIndex = rand.nextInt(divisionTablePairs.length);

    setState(() {
      num1 = divisionTablePairs[randomIndex][0];
      num2 = divisionTablePairs[randomIndex][1];

      resultDiv = num1 ~/ num2;
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
    if (userAnswerInt == resultDiv) {
      setState(() {
        score++;
        feedbackMessage = 'Correct!';
        _generateNewDiv();
        userAnswer = '';
      });
    } else if (userAnswer.length == resultDiv.toString().length) {
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
                  Text('$num1 ÷ $num2', style: const TextStyle(fontSize: 36)),
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
            if (userAnswer.length == resultDiv.toString().length) {
              _checkAnswer();
            }
          }
        });
      },
      child: Text(value, style: const TextStyle(fontSize: 24)),
    );
  }
}
