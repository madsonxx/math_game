// Suggested code may be subject to a license. Learn more: ~LicenseLog:301004402.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2411095923.
import 'package:flutter/material.dart';
import 'package:myapp/leaderboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndGamePage extends StatelessWidget {
  final int finalScore;
  final String operation;

  const EndGamePage(
      {Key? key, required this.finalScore, required this.operation})
      : super(key: key);

  void _saveScore(int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String highScoreKey = 'highScores_${operation}';
    List<String> highScores = prefs.getStringList('highScores') ?? [];
    String newScoreEntry = '$score - ${DateTime.now().toIso8601String()}';
    highScores.add(newScoreEntry);
    // Sort the high scores (optional, but recommended)
    highScores.sort((a, b) {
      int scoreA = int.parse(a.split(' - ')[0]);
      int scoreB = int.parse(b.split(' - ')[0]);
      return scoreB.compareTo(scoreA); // Sort in descending order
    });
    await prefs.setStringList('highScores', highScores);
  }

  @override
  Widget build(BuildContext context) {
    _saveScore(finalScore); // Call _saveScore here

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fim de Jogo!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Você fez $finalScore pontos!',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 30),
            // Add more UI elements as needed (e.g., animations, images)
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LeaderboardPage()),
                );
              },
              child: const Text('Liderança'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the game page
                // You might need to call resetGame() here or on the previous page
              },
              child: const Text('Jogar Novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
