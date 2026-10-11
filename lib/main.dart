import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MahjongApp());
}

class MahjongApp extends StatelessWidget {
  const MahjongApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Махджонг Нақыштары',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFF0F381E),
      ),
      home: const MainMenuScreen(),
    );
  }
}

// ------------------- БАСҚЫ МӘЗІР -------------------
class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int coins = 500;
  int gems = 50;
  int level = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [Color(0xFF1E5E35), Color(0xFF0A2413)],
              radius: 0.8,
            ),
          ),
          child: Column(
            children: [
              // Жоғарғы панель (Монета мен Кристалл)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainSpanAlignment.between,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.amber, width: 1.5),
                      ),
                      child: Text('ДЕҢГЕЙ: $level', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: [
                        _buildCurrencyBox('🪙', '$coins', Colors.amber),
                        const SizedBox(width: 10),
                        _buildCurrencyBox('💎', '$gems', Colors.cyanAccent),
                      ],
                    ),
                  ],
                ),
              ),
              
              const Spacer(),

              // Ортадағы Логотип
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.amber.shade900.withOpacity(0.3),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.amber, width: 3),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.shield, size: 70, color: Colors.amber),
                    SizedBox(height: 10),
                    Text(
                      'МАХДЖОНГ\nНАҚЫШТАРЫ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent,
                        shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                      ),
                    ),
                    Text(
                      'КӘСІПКЕР НҰСҚАСЫ',
                      style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 2),
                    )
                  ],
                ),
              ),

              const Spacer(),

              // Мәзір батырмалары
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildMenuButton(
                      context,
                      title: '▶ ЖАҢА ОЙЫН',
                      color: Colors.amber.shade800,
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameScreen(level: level, coins: coins),
                          ),
                        );
                        if (result != null && result is Map) {
                          setState(() {
                            coins += (result['earnedCoins'] as int);
                            if (result['win'] == true) level++;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildMenuButton(
                            context,
                            title: '🏪 ДҮКЕН',
                            color: Colors.green.shade700,
                            onTap: () => _showShopDialog(context),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildMenuButton(
                            context,
                            title: '💰 БОНУС АЛУ',
                            color: Colors.deepOrange,
                            onTap: () {
                              setState(() => coins += 100);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('+100 Тиын сыйлыққа берілді!')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyBox(String icon, String amount, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 5),
          Text(amount, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, {required String title, required Color color, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.amber, width: 2),
          ),
          elevation: 5,
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  void _showShopDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E5E35),
        title: const Text('🏪 Кәсіпкер Дүкені', style: TextStyle(color: Colors.amber)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text('💎', style: TextStyle(fontSize: 24)),
              title: const Text('50 Гауһар Тас', style: TextStyle(color: Colors.white)),
              subtitle: const Text('500 тиынға сатып алу', style: TextStyle(color: Colors.white70)),
              onTap: () {
                if (coins >= 500) {
                  setState(() {
                    coins -= 500;
                    gems += 50;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('50 Гауһар сатылып алынды!')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- ОЙЫН ЭКРАНЫ -------------------
class GameScreen extends StatefulWidget {
  final int level;
  final int coins;

  const GameScreen({super.key, required this.level, required this.coins});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<String> symbols = ['🦅', '☀️', '⛺', '🐎', '🇰🇿', '🛡️', '🪙', '💎'];
  List<String> tiles = [];
  int? selectedIndex;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _generateTiles();
  }

  void _generateTiles() {
    tiles.clear();
    // 12 жұп (24 тас)
    List<String> deck = [];
    for (int i = 0; i < 12; i++) {
      String sym = symbols[i % symbols.length];
      deck.add(sym);
      deck.add(sym);
    }
    deck.shuffle(Random());
    setState(() {
      tiles = deck;
    });
  }

  void _onTileTap(int index) {
    if (selectedIndex == null) {
      setState(() => selectedIndex = index);
    } else if (selectedIndex == index) {
      setState(() => selectedIndex = null);
    } else {
      if (tiles[selectedIndex!] == tiles[index]) {
        // Мемлекеттік/Ұлттық жұп табылды!
        setState(() {
          tiles[selectedIndex!] = '';
          tiles[index] = '';
          selectedIndex = null;
          score += 20;
        });

        // Ойын аяқталды ма тексеру
        if (tiles.every((element) => element == '')) {
          _showWinDialog();
        }
      } else {
        setState(() => selectedIndex = index);
      }
    }
  }

  void _showWinDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E5E35),
        title: const Text('🎉 ЖЕҢІС!', style: TextStyle(color: Colors.amber, fontSize: 24)),
        content: Text(
          'Сіз деңгейді өтіп, $score тиын таптыңыз!',
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, {'earnedCoins': score, 'win': true});
            },
            child: const Text('МӘЗІРГЕ ҚАЙТУ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A2413),
        title: Text('${widget.level}-Деңгей | Ұпай: $score'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.amber),
            onPressed: _generateTiles,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF1E5E35), Color(0xFF0A2413)],
            radius: 0.9,
          ),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: tiles.length,
          itemBuilder: (context, index) {
            if (tiles[index] == '') return const SizedBox.shrink();

            bool isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () => _onTileTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.amber : const Color(0xFFFFF8E7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.white : Colors.amber.shade900,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 5,
                      offset: const Offset(2, 4),
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    tiles[index],
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
