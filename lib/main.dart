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
        fontFamily: 'sans-serif',
        scaffoldBackgroundColor: const Color(0xFF0C2D17),
      ),
      home: const PalaceHomeScreen(),
    );
  }
}

// Сарай экраны (Басты бет)
class PalaceHomeScreen extends StatefulWidget {
  const PalaceHomeScreen({super.key});

  @override
  State<PalaceHomeScreen> createState() => _PalaceHomeScreenState();
}

class _PalaceHomeScreenState extends State<PalaceHomeScreen> {
  int currentLevel = 135; // Мысалдағыдай 135-деңгейден басталады
  int coins = 750;
  int gems = 120;

  void _openSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1B4D2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Colors.amber, width: 2)),
        title: const Text('Баптаулар', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.music_note, color: Colors.amber, size: 36),
                Icon(Icons.volume_up, color: Colors.amber, size: 36),
                Icon(Icons.vibration, color: Colors.amber, size: 36),
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.white),
              title: const Text('Тіл: Қазақша', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.amber, size: 16),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.white),
              title: const Text('Қолдау / Байланыс', style: TextStyle(color: Colors.white)),
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
          // Фон (Әдемі сарай көрінісі градиент арқылы)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF4A90E2), Color(0xFF87CEEB), Color(0xFF2E8B57)],
              ),
            ),
          ),
          
          // Ортадағы сарай иллюстрациясы симуляциясы
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.castle, size: 120, color: Colors.amberAccent),
                      SizedBox(height: 10),
                      Text(
                        'ҚАЗАҚ ХАНДЫҒЫ САРАЙЫ',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Жоғарғы панель (Профиль, Баптаулар, Валюта)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Профиль
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Color(0xFF8B4513),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                  
                  // Оң жақ батырмалар
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.amber),
                        ),
                        child: Row(
                          children: [
                            const Text('💎 ', style: TextStyle(fontSize: 14)),
                            Text('$gems', style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white, size: 32),
                        onPressed: _openSettings,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Төменгі деңгейге өту батырмасы (Үлкен жасыл батырма)
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5CB85C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                    side: const BorderSide(color: Colors.amber, width: 3),
                  ),
                  elevation: 10,
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
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white, shadows: [
                    Shadow(color: Colors.black45, offset: Offset(0, 2), blurRadius: 4)
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Ойын барысы (Қазақы нақыштағы элементтерді 3-тен жинау механикасы)
class GamePlayScreen extends StatefulWidget {
  final int level;
  const GamePlayScreen({super.key, required this.level});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  // Қазақы нақыштағы символдар (Киіз үй, Домбыра, Тұлпар, Ою, Бәйтерек, Алтын)
  final List<String> qazaqIcons = ['⛺', '🪕', '🐎', '⚜️', '🪙', '🦅', '☀️'];
  List<String> boardTiles = [];
  List<String> collectedBox = []; // Жоғарғы 4 орындық жинайтын панель
  bool isGameOver = false;
  bool isWon = false;

  @override
  void initState() {
    super.initState();
    _setupLevel();
  }

  void _setupLevel() {
    boardTiles.clear();
    collectedBox.clear();
    // Әр деңгей сайын тақтайшалар саны көбейіп күрделенеді (күрделілік)
    int tileCount = 15 + (widget.level % 5) * 3; 
    for (int i = 0; i < tileCount; i++) {
      boardTiles.add(qazaqIcons[i % qazaqIcons.length]);
      boardTiles.add(qazaqIcons[i % qazaqIcons.length]); // Жұптастыру үшін екі реттен қосамыз
    }
    boardTiles.shuffle(Random());
    setState(() {});
  }

  void _onTileTap(int index) {
    if (isGameOver || isWon) return;

    String tappedTile = boardTiles[index];
    setState(() {
      boardTiles.removeAt(index);
      collectedBox.add(tappedTile);
      _checkMatches();
    });
  }

  void _checkMatches() {
    // Ұқсас элементтерді тексеру (3 бірдей болса жойылады)
    Map<String, int> counts = {};
    for (var item in collectedBox) {
      counts[item] = (counts[item] ?? 0) + 1;
    }

    counts.forEach((key, val) {
      if (val >= 3) {
        collectedBox.removeWhere((element) => element == key);
      }
    });

    // Жеңісті тексеру
    if (boardTiles.isEmpty && collectedBox.isEmpty) {
      isWon = true;
      _showEndDialog(true);
    } else if (collectedBox.length >= 4) {
      // Панель толып қалса ұтылып қалады
      isGameOver = true;
      _showEndDialog(false);
    }
  }

  void _showEndDialog(bool win) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1B4D2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: Colors.amber, width: 3)),
        title: Text(win ? '🎉 КЕРЕМЕТ ЖЕҢІС!' : '❌ ОЙЫН АЯҚТАЛДЫ', style: TextStyle(color: win ? Colors.amber : Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold)),
        content: Text(
          win ? 'Сіз ${widget.level}-деңгейді сәтті аяқтадыңыз!' : 'Орын толып қалды! Қайта көріңіз.',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, win);
            },
            child: const Text('АРТҚА ҚАЙТУ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.amber),
            onPressed: _setupLevel,
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          // Жоғарғы жинайтын орын (4 слот — мысалдағыдай)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 75,
            decoration: BoxDecoration(
              color: const Color(0xFF05190D),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.amber.shade700, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  width: 55,
                  height: 55,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E5E35),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.amber.withOpacity(0.5)),
                  ),
                  child: Center(
                    child: Text(
                      index < collectedBox.length ? collectedBox[index] : '',
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                );
              }),
            ),
          ),
          
          const SizedBox(height: 10),
          // Прогресс шкаласы
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: LinearProgressIndicator(
              value: 1.0 - (boardTiles.length / 40),
              backgroundColor: Colors.black45,
              color: Colors.amber,
              minHeight: 8,
            ),
          ),

          const Spacer(),

          // Ортадағы қазақы тақтайшалар алаңы
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: boardTiles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _onTileTag(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E7),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber.shade900, width: 2.5),
                        boxShadow: const [
                          BoxShadow(color: Colors.black38, offset: Offset(0, 4), blurRadius: 4),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          boardTiles[index],
                          style: const TextStyle(fontSize: 32),
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
