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
    const GamesView(),
    const VideosView(),
    const SongsView(),
    const TextContentView(title: '📖 Мақал-мәтелдер', text: '"Өнер - ағып жатқан бұлақ, Тіл - таусылмайтын бұлақ."\n\n"Еңбек етсең ерінбей, Тояды қарның тіленбей."'),
    const TextContentView(title: '📜 Абайдың қара сөздері', text: 'Бірінші сөз:\nБұл жасқа келгенше жақсы өткіздік пе, жаман өткіздік пе, әйтеуір өмірді өткіздік...'),
    const TextContentView(title: '✍️ Мұқағали өлеңдері', text: 'Отан:\nОтан! Отан!\nСен болмасаң, не етер ем?\nMәңгілікке бақытсыз боп өтер ем...'),
    const AdminView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎮 Games Hub'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.blue.shade900,
            child: const Text(
              '✨ Қош келдіңіз! Платформамызға қош келдіңіз! ✨',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
        unselectedItemColor: Colors.white60,
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

class GamesView extends StatelessWidget {
  const GamesView({super.key});

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

class VideosView extends StatelessWidget {
  const VideosView({super.key});

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

class SongsView extends StatelessWidget {
  const SongsView({super.key});

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

class TextContentView extends StatelessWidget {
  final String title;
  final String text;

  const TextContentView({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
              const SizedBox(height: 12),
              Text(text, style: const TextStyle(fontSize: 15, height: 1.4)),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminView extends StatelessWidget {
  const AdminView({super.key});

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
                Text('🟢 Онлайн: 1', style: TextStyle(color: Colors.green)),
                Text('🔴 Офлайн: 0', style: TextStyle(color: Colors.red)),
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
