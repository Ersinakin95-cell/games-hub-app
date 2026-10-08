import 'package:flutter/material.dart';

void main() {
  runApp(const CombinedGamesHubApp());
}

class CombinedGamesHubApp extends StatelessWidget {
  const CombinedGamesHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Games Hub',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF090A10),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D0E15),
          elevation: 0,
        ),
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWelcomeDialog();
    });
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF161B26),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.stars, color: Colors.amber),
              SizedBox(width: 10),
              Text('Қош келдіңіз!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          content: const Text(
            'Платформаға қош келдіңіз! Мұнда сіз Абай мен Мұқағалидың мол мұрасын оқып, 100-ден астам қазақша ән, видео және ойындарды тамашалай аласыз.',
            style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.4),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00F2FE),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Бастау', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  final List<Widget> _pages = const [
    GamesHubHomePage(),
    AbaiPage(),
    MukaqaliPage(),
    MusicPage(),
    VideoPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF00F2FE),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF0D0E15),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports),
            label: 'Games Hub',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Абай',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Мұқағали',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Музыка',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            label: 'Видео',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}

// 1. GAMES HUB БАСТЫ БЕТІ (100 ОЙЫН)
class GamesHubHomePage extends StatelessWidget {
  const GamesHubHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ersinakyn Aziz',
          style: TextStyle(color: Color(0xFF00F2FE), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.sports_esports, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'GAMES HUB',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyanAccent),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161B26),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amber.withOpacity(0.5)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.monetization_on, color: Colors.amber, size: 20),
                      SizedBox(width: 6),
                      Text('150 Coins', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Жарнама блогы
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF161B26),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('Ad', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAlignment.start,
                          children: [
                            Text('Monetization Space (Google AdSense / Banner)', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text('In real deployments, users viewing ads here generate revenue for you!', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {},
                      child: const Text('Simulate Ad Click (+10 Coins)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.sports_esports),
                    label: const Text('Playable Games'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.play_circle_outline),
                    label: const Text('Watch & Earn Videos'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Text(
              '100 Ойын каталогы',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Ойын ойнап, ұпай жинаңыз',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF161B26),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAlignment.start,
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F2B2B),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(Icons.extension, size: 60, color: Colors.greenAccent),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Classic Snake', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('+20 Coins/Win', style: TextStyle(color: Colors.tealAccent, fontSize: 12)),
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text('Eat apples, grow longer, and avoid hitting the walls!', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                      onPressed: () {},
                      child: const Text('Play Now'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. АБАЙ ҚАРА СӨЗДЕРІ МЕН ӨЛЕҢДЕРІ
class AbaiPage extends StatelessWidget {
  const AbaiPage({super.key});

  List<Map<String, String>> get abaiItems {
    List<Map<String, String>> items = [];
    for (int i = 1; i <= 45; i++) {
      items.add({
        'title': '$i-ші қара сөз',
        'text': 'Абай Құнанбайұлының $i-ші қара сөзі. Терең философиялық ойлар мен адамгершілік өсиеттері.'
      });
    }
    List<String> poems = [
      'Ғылым таппай мақтанба', 'Көзімнің қарасы', 'Желсіз түнде жарық ай',
      'Күз', 'Қыс', 'Жаз', 'Жасымда ғылым бар деп ескермедім',
      'Интернатта оқып жүр', 'Сегіз аяқ', 'Өлең – сөздің патшасы'
    ];
    for (int i = 0; i < 60; i++) {
      String title = poems[i % poems.length];
      items.add({
        'title': 'Өлең: $title (${i + 1})',         'text': '$title...\n\nАбайдың бұл туындысы халқын білім мен өнерге шақырады.'
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final list = abaiItems;
    return Scaffold(
      appBar: AppBar(
        title: Text('Абай мұрасы (${list.length} шығарма)'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return Card(
            color: const Color(0xFF161B26),
            margin: const EdgeInsets.
