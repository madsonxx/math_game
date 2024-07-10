import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});
  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  Map<String, List<String>> highScores = {};
  @override
  void initState() {
    super.initState();
    _loadHighScores();
  }

  Future<void> _loadHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      highScores['Soma'] = prefs.getStringList('highScores_Soma') ?? [];
      highScores['Subtração'] =
          prefs.getStringList('highScores_Subtração') ?? [];
      highScores['Multiplicação'] =
          prefs.getStringList('highScores_Multiplicação') ?? [];
      highScores['Divisão'] = prefs.getStringList('highScores_Divisão') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liderança'),
      ),
      body: PageView(
        children: [
          _buildHighScoreList('Soma'),
          _buildHighScoreList('Subtração'),
          _buildHighScoreList('Multiplicação'),
          _buildHighScoreList('Divisão'),
        ],
      ),
    );
  }

  Widget _buildHighScoreList(String operation) {
    return ListView.builder(
      itemCount: highScores[operation]?.length ?? 0,
      itemBuilder: (context, index) {
        String scoreEntry = highScores[operation]![index];
        List<String> parts = scoreEntry.split(' - ');
        return ListTile(
          title: Text('Score: ${parts[0]}'),
          subtitle: Text('Date: ${parts[1]}'),
        );
      },
    );
  }
}
