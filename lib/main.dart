import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Games Hub',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const GamesTab(),
    const VideosTab(),
    const SongsTab(),
    const MakalTab(),
    const AbayTab(),
    const MukagaliTab(),
    const AdminTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎮 Games Hub — Қазақша Платформа'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            color: Colors.blueAccent,
            child: const Text(
              '✨ Қош келдіңіз! Платформамызға қош келдіңіз! ✨',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
            ),
          ),
          Expanded(child: _pages[_currentIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.black87,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: 'Ойындар'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Видео'),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Әндер'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Мақалдар'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_stories), label: 'Абай'),
          BottomNavigationBarItem(icon: Icon(Icons.history_edu), label: 'Мұқағали'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Админ'),
        ],
      ),
    );
  }
}

class GamesTab extends StatelessWidget {
  const GamesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 100,
      itemBuilder: (context, i) => Card(
        child: ListTile(
          leading: const Icon(Icons.gamepad, color: Colors.amber),
          title: Text('🎮 Ойын #${i + 1}'),
        ),
      ),
    );
  }
}

class VideosTab extends StatelessWidget {
  const VideosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 100,
      itemBuilder: (context, i) => Card(
        child: ListTile(
          leading: const Icon(Icons.play_circle_fill, color: Colors.red),
          title: Text('🎥 Видео #${i + 1}'),
        ),
      ),
    );
  }
}

class SongsTab extends StatelessWidget {
  const SongsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 100,
      itemBuilder: (context, i) => Card(
        child: ListTile(
          leading: const Icon(Icons.music_note, color: Colors.green),
          title: Text('🎵 Ән #${i + 1}'),
        ),
      ),
    );
  }
}

class MakalTab extends StatelessWidget {
  const MakalTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('📖 "Өнер - ағып жатқан бұлақ, Тіл - таусылмайтын бұлақ."', style: TextStyle(fontSize: 15)),
          ),
        ),
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('📖 "Еңбек етсең ерінбей, Тояды қарның тіленбей."', style: TextStyle(fontSize: 15)),
          ),
        ),
      ],
    );
  }
}

class AbayTab extends StatelessWidget {
  const AbayTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('📜 Абай Құнанбайұлы — Бірінші сөз', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber)),
                SizedBox(height: 8),
                Text('Бұл жасқа келгенше жақсы өткіздік пе, жаман өткіздік пе, әйтеуір өмірді өткіздік: алыстық, жұлыстық, айтыстық, тартыстық - әрекет қылдық...'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MukagaliTab extends StatelessWidget {
  const MukagaliTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('✍️ Мұқағали Мақатаев — Отан', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber)),
                SizedBox(height: 8),
                Text('Отан! Отан!\nСен болмасаң, не етер ем?\nMәңгілікке бақытсыз боп өтер ем...'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AdminTab extends StatelessWidget {
  const AdminTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey.shade900,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('🟢 Онлайн: 1', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                Text('🔴 Офлайн: 0', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            color: Colors.green.shade900,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('👑 Администратор Кабинеті', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('💵 Баланс: 0.00 $', style: TextStyle(fontSize: 16, color: Colors.amber)),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                    child: const Text('💸 Ақшаны шығару (Вывод)'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
