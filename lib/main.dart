import 'package:flutter/material.dart';

void main() {
  runApp(const GamesHubApp());
}

class GamesHubApp extends StatelessWidget {
  const GamesHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Games Hub',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const GamesView(),
    const VideosView(),
    const SongsView(),
    const MakalView(),
    const AbayView(),
    const MukagaliView(),
    const AdminView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎮 Games Hub — Қазақша Платформа'),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.blueAccent,
            child: const Text(
              '✨ Қош келдіңіз! Платформамызға қош келдіңіз! ✨',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
            ),
          ),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white70,
        backgroundColor: const Color(0xFF1E1E1E),
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

class GamesView extends StatelessWidget {
  const GamesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 100,
      itemBuilder: (context, i) => Card(
        color: const Color(0xFF2C2C2C),
        child: ListTile(
          leading: const Icon(Icons.sports_esports, color: Colors.amber),
          title: Text('🎮 Ойын #${i + 1}'),
        ),
      ),
    );
  }
}

class VideosView extends StatelessWidget {
  const VideosView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 100,
      itemBuilder: (context, i) => Card(
        color: const Color(0xFF2C2C2C),
        child: ListTile(
          leading: const Icon(Icons.play_circle_fill, color: Colors.red),
          title: Text('🎥 Видео #${i + 1}'),
        ),
      ),
    );
  }
}

class SongsView extends StatelessWidget {
  const SongsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 100,
      itemBuilder: (context, i) => Card(
        color: const Color(0xFF2C2C2C),
        child: ListTile(
          leading: const Icon(Icons.music_note, color: Colors.green),
          title: Text('🎵 Ән #${i + 1}'),
        ),
      ),
    );
  }
}

class MakalView extends StatelessWidget {
  const MakalView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        Card(
          color: Color(0xFF252525),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('📖 "Өнер - ағып жатқан бұлақ, Тіл - таусылмайтын бұлақ."', style: TextStyle(fontSize: 16)),
          ),
        ),
        Card(
          color: Color(0xFF252525),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('📖 "Еңбек етсең ерінбей, Тояды қарның тіленбей."', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}

class AbayView extends StatelessWidget {
  const AbayView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        Card(
          color: Color(0xFF252525),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('📜 Абай Құнанбайұлы — Бірінші сөз', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
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

class MukagaliView extends StatelessWidget {
  const MukagaliView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        Card(
          color: Color(0xFF252525),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('✍️ Мұқағали Мақатаев — Отан', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
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

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(8)),
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
