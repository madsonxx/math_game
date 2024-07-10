import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:myapp/end_game_page.dart';

class SumGamePage extends StatefulWidget {
  const SumGamePage({super.key});

  @override
  _SumGamePageState createState() => _SumGamePageState();
}

class _SumGamePageState extends State<SumGamePage> {
  String userInput = ''; // Store the user's input as a string
  int sum = 0; // Initialize sum to 0
  String feedbackMessage = '';
  int firstNumber = 0;
  int secondNumber = 0;
  int score = 0;
  String userAnswer = '';
  String correctAnswer = '';
  late Timer timer;
  int remainingTime = 10;

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
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EndGamePage(
                      finalScore: score,
                      operation: 'soma',
                    )),
          );
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
    if (remainingTime > 0 && userAnswerInt == sum) {
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

  void resetGame() {
    setState(() {
      // 1. Reset the timer:
      remainingTime = 10; // Or your initial timer value
      timer?.cancel(); // Cancel the existing timer if it's running
      // 2. Reset the score:
      score = 0;
      // 3. Reset user input:
      userAnswer = '';
      // 4. Reset feedback message:
      feedbackMessage = ''; // Or your initial feedback message
      // 5. Generate a new sum (or other game elements):
      _generateNewSum(); // Or your equivalent function to set up a new game round
    });
    // 6. Restart the timer (if needed):
    startTimer();
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
