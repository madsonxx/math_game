import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});
  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage>
    with SingleTickerProviderStateMixin {
  // Add this mixin
  Map<String, List<String>> highScores = {};
  late TabController _tabController; // Tab controller
  @override
  void initState() {
    super.initState();
    _loadHighScores();
    _tabController = TabController(length: 4, vsync: this);
    // Initialize with 4 tabs
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the controller
    super.dispose();
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
        bottom: TabBar(
          // Add TabBar
          controller: _tabController,
          tabs: const [
            Tab(text: 'Soma'),
            Tab(text: 'Subtração'),
            Tab(text: 'Multiplicação'),
            Tab(text: 'Divisão'),
          ],
        ),
      ),
      body: TabBarView(
        // Add TabBarView
        controller: _tabController,
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
    if (highScores[operation]?.isEmpty ?? true) {
      return Center(
        child: Text('No high scores for $operation yet!'),
      );
    }

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
