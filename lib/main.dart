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
        primaryColor: Colors.blue,
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
    const GamesTab(),
    const VideosTab(),
    const SongsTab(),
    const MakalTab(),
    const AbayTab(),
    const MukagaliTab(),
    const ChatTab(),
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Чат'),
        ],
      ),
    );
  }
}

// 1. Ойындар
class GamesTab extends StatelessWidget {
  const GamesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 100,
      itemBuilder: (context, index) {
        return Card(
          color: const Color(0xFF2C2C2C),
          child: Center(
            child: Text(
              '🎮 Ойын #${index + 1}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}

// 2. Видеолар
class VideosTab extends StatelessWidget {
  const VideosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 100,
      itemBuilder: (context, index) {
        return Card(
          color: const Color(0xFF2C2C2C),
          child: ListTile(
            leading: const Icon(Icons.play_circle_fill, color: Colors.red, size: 36),
            title: Text('🎥 Видео Ролик #${index + 1}'),
            subtitle: const Text('Қарау үшін басыңыз'),
          ),
        );
      },
    );
  }
}

// 3. Әндер
class SongsTab extends StatelessWidget {
  const SongsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 100,
      itemBuilder: (context, index) {
        return Card(
          color: const Color(0xFF2C2C2C),
          child: ListTile(
            leading: const Icon(Icons.music_note, color: Colors.green, size: 36),
            title: Text('🎵 Қазақша Ән #${index + 1}'),
            subtitle: const Text('Тыңдау'),
          ),
        );
      },
    );
  }
}

// 4. Мақал-мәтелдер
class MakalTab extends StatelessWidget {
  const MakalTab({super.key});

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

// 5. Абайдың қара сөздері
class AbayTab extends StatelessWidget {
  const AbayTab({super.key});

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
                Text('📜 Бірінші сөз', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
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

// 6. Мұқағали өлеңдері
class MukagaliTab extends StatelessWidget {
  const MukagaliTab({super.key});

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
                Text('✍️ Отан', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
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

// 7. Чат және Админ Панель
class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // Онлайн статус
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(8)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('🟢 Онлайн: 1 адам', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                Text('🔴 Офлайн: 0 адам', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
              ],
            ),
          ),
          const SizedBox(height: 15),

          // Чат
          Container(
            padding: const EdgeInsets.all(12),
            height: 200,
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text('💬 Чатқа қош келдіңіз!'),
            ),
          ),
          const SizedBox(height: 15),

          // 👑 Админ Панель (Жеке Табыс)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Text('👑 Администратор Кабинеті', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('💵 Сіздің Табысыңыз: 0.00 $', style: TextStyle(fontSize: 16, color: Colors.amberAccent)),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ақша шығару сұранысы қабылданды!')),
                    );
                  },
                  child: const Text('💸 Ақшаны шығару (Вывод)'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
