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
      title: 'Махджонг Нақыштары',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF0C2D17)),
      home: const PalaceHomeScreen(),
    );
  }
}

// 1. Сарай фоны және баптаулар экраны (Суреттегідей)
class PalaceHomeScreen extends StatefulWidget {
  const PalaceHomeScreen({super.key});

  @override
  State<PalaceHomeScreen> createState() => _PalaceHomeScreenState();
}

class _PalaceHomeScreenState extends State<PalaceHomeScreen> {
  int currentLevel = 135; // Суретте көрсетілгендей 135-деңгей
  int gems = 120;

  void _openSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1B4D2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Colors.amber, width: 2)),
        title: const Text('Настройки', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.music_off, color: Colors.redAccent, size: 32),
                Icon(Icons.volume_up, color: Colors.amber, size: 32),
                Icon(Icons.vibration, color: Colors.amber, size: 32),
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.white),
              title: const Text('Язык', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.amber, size: 16),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.white),
              title: const Text('О Нас', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.amber, size: 16),
              onTap: () {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Жабу', style: TextStyle(color: Colors.amber, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF4A90E2), Color(0xFF87CEEB), Color(0xFF2E8B57)],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(30)),
                  child: const Column(
                    children: [
                      Icon(Icons.castle, size: 110, color: Colors.amberAccent),
                      SizedBox(height: 10),
                      Text('ҚАЗАҚ ХАНДЫҒЫ САРАЙЫ', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(backgroundColor: Color(0xFF8B4513), child: Icon(Icons.person, color: Colors.white)),
                  Row(
                    children: [
                      Text('💎 $gems', style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(width: 10),
                      IconButton(icon: const Icon(Icons.settings, color: Colors.white, size: 30), onPressed: _openSettings),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 65,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5CB85C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: const BorderSide(color: Colors.amber, width: 3),
                  ),
                ),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GamePlayScreen(level: currentLevel)),
                  );
                  if (result == true) {
                    setState(() {
                      currentLevel++;
                    });
                  }
                },
                child: Text(
                  'Уровень $currentLevel',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 2. Ойын алаңы және 4 слоттық жинайтын панель (Суреттегідей механика)
class GamePlayScreen extends StatefulWidget {
  final int level;
  const GamePlayScreen({super.key, required this.level});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  final List<String> qazaqIcons = ['⛺', '🪕', '🐎', '⚜️', '🪙', '🦅', '☀️'];
  List<String> boardTiles = [];
  List<String> collectedBox = []; // Жоғарғы 4 орындық панель

  @override
  void initState() {
    super.initState();
    _setupLevel();
  }

  void _setupLevel() {
    boardTiles.clear();
    collectedBox.clear();
    int tileCount = 12 + (widget.level % 3) * 3;
    for (int i = 0; i < tileCount; i++) {
      String icon = qazaqIcons[i % qazaqIcons.length];
      boardTiles.add(icon);
      boardTiles.add(icon);
    }
    boardTiles.shuffle(Random());
    setState(() {});
  }

  void _onTileTap(int index) {
    if (collectedBox.length >= 4) return;
    String tapped = boardTiles[index];
    setState(() {
      boardTiles.removeAt(index);
      collectedBox.add(tapped);
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
        title: Text(win ? '🎉 ЖЕҢІС!' : '❌ ОЙЫН АЯҚТАЛДЫ', style: const TextStyle(color: Colors.amber)),
        content: Text(win ? 'Деңгей сәтті аяқталды!' : 'Панель толып қалды!', style: const TextStyle(color: Colors.white)),
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
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.amber), onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          // Жоғарғы 4 слоттық жинайтын панель (скриншоттағыдай)
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
                    border: Border.all(color: Colors.amber.withOpacity(0.5)),
                  ),
                  child: Center(
                    child: Text(
                      index < collectedBox.length ? collectedBox[index] : '',
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                );
              }),
            ),
          ),
          const Spacer(),
          // Ортадағы тақтайшалар алаңы
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
                        border: Border.all(color: Colors.amber.shade900, width: 2.5),
                        boxShadow: const [BoxShadow(color: Colors.black38, offset: Offset(0, 3), blurRadius: 3)],
                      ),
                      child: Center(
                        child: Text(
                          boardTiles[index],
                          style: const TextStyle(fontSize: 30),
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
