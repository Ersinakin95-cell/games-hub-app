import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const QazaqTileApp());
}

class QazaqTileApp extends StatelessWidget {
  const QazaqTileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Қазақша Махджонг',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0C2D17),
      ),
      home: const PalaceHomeScreen(),
    );
  }
}

class PalaceHomeScreen extends StatefulWidget {
  const PalaceHomeScreen({super.key});

  @override
  State<PalaceHomeScreen> createState() => _PalaceHomeScreenState();
}

class _PalaceHomeScreenState extends State<PalaceHomeScreen> {
  int currentLevel = 135;
  int coins = 750;
  int gems = 120;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A90E2), Color(0xFF2E8B57)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Color(0xFF8B4513),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    Row(
                      children: [
                        Text('💎 $gems', style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Icon(Icons.castle, size: 100, color: Colors.amberAccent),
              const SizedBox(height: 10),
              const Text(
                'ҚАЗАҚ ХАНДЫҒЫ САРАЙЫ',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5CB85C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.amber, width: 2),
                      ),
                    ),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GamePlayScreen(level: currentLevel),
                        ),
                      );
                      if (result == true) {
                        setState(() {
                          currentLevel++;
                          coins += 50;
                        });
                      }
                    },
                    child: Text(
                      'Деңгей $currentLevel',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GamePlayScreen extends StatefulWidget {
  final int level;
  const GamePlayScreen({super.key, required this.level});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  final List<String> qazaqIcons = ['⛺', '🪕', '🐎', '⚜️', '🪙', '🦅', '☀️'];
  List<String> boardTiles = [];
  List<String> collectedBox = [];

  @override
  void initState() {
    super.initState();
    _setupLevel();
  }

  void _setupLevel() {
    boardTiles.clear();
    collectedBox.clear();
    int tileCount = 12; 
    for (int i = 0; i < tileCount; i++) {
      String icon = qazaqIcons[i % qazaqIcons.length];
      boardTiles.add(icon);
      boardTiles.add(icon);
    }
    boardTiles.shuffle(Random());
    setState(() {});
  }

  void _onTileTap(int index) {
    String tappedTile = boardTiles[index];
    setState(() {
      boardTiles.removeAt(index);
      collectedBox.add(tappedTile);
      _checkMatches();
    });
  }

  void _checkMatches() {
    Map<String, int> counts = {};
    for (var item in collectedBox) {
      counts[item] = (counts[item] ?? 0) + 1;
    }

    counts.forEach((key, val) {
      if (val >= 3) {
        collectedBox.removeWhere((element) => element == key);
      }
    });

    if (boardTiles.isEmpty && collectedBox.isEmpty) {
      _showEndDialog(true);
    } else if (collectedBox.length >= 4) {
      _showEndDialog(false);
    }
  }

  void _showEndDialog(bool win) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1B4D2E),
        title: Text(win ? '🎉 ЖЕҢІС!' : '❌ АЯҚТАЛДЫ', style: const TextStyle(color: Colors.amber)),
        content: Text(win ? 'Деңгей сәтті аяқталды!' : 'Орын толып қалды!', style: const TextStyle(color: Colors.white)),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, win);
            },
            child: const Text('ҚАЙТУ', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F381E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A2413),
        title: Text('Деңгей ${widget.level}', style: const TextStyle(color: Colors.amber)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.amber),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFF05190D),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.amber, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E5E35),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      index < collectedBox.length ? collectedBox[index] : '',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                );
              }),
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: boardTiles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _onTileTap(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E7),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber.shade900, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          boardTiles[index],
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
