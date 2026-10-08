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
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
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

  final List<Widget> _pages = const [
    AbaiPage(),
    MukaqaliPage(),
    GamesPage(),
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
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF1F1F1F),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Абай',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Мұқағали',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports),
            label: 'Ойындар',
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

class AbaiPage extends StatelessWidget {
  const AbaiPage({super.key});

  final List<Map<String, String>> abaiWords = const [
    {
      'title': 'Бірінші қара сөз',
      'text': 'Бұл жасқа келгенше жақсы өткіздік пе, жаман өткіздік пе, әйтеуір өмірдің біршамасын өткіздік...'
    },
    {
      'title': 'Екінші қара сөз',
      'text': 'Мен бала күнімде естуші едім, біздің қазақ өзбекті көрсе «сарт-сұрт» деуші еді...'
    },
    {
      'title': 'Үшінші қара сөз',
      'text': 'Қазақтың бір-біріне қастық қылатынының себебі неде?..'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Абайдың Қара сөздері'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: abaiWords.length,
        itemBuilder: (context, index) {
          final item = abaiWords[index];
          return Card(
            color: const Color(0xFF2C2C2C),
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              title: Text(
                item['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    item['text']!,
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MukaqaliPage extends StatelessWidget {
  const MukaqaliPage({super.key});

  final List<Map<String, String>> poems = const [
    {
      'title': 'Поэзия',
      'text': 'Поэзия! Мұңдасым да, сырдасым,\nӨзің барда өзгеге есе бермеймін!'
    },
    {
      'title': 'Үш бақытым',
      'text': 'Ең бірінші бақытым — Халқым менің,\nСоған берем ойымның алтын кенін...'
    },
    {
      'title': 'Фаризаға',
      'text': 'Фариза! Фаризажан, Фариза қыз,\nӨмірде ақындардың бәрі жалғыз...'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мұқағали Мақатаев өлеңдері'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: poems.length,
        itemBuilder: (context, index) {
          final item = poems[index];
          return Card(
            color: const Color(0xFF2C2C2C),
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              title: Text(
                item['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    item['text']!,
                    style: const TextStyle(fontSize: 15, height: 1.4, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  final List<String> games = const ['Ойын 1', 'Ойын 2', 'Ойын 3', 'Ойын 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎮 Ойындар каталогы'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: games.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF2C2C2C),
            child: Center(
              child: Text(
                games[index],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  final List<String> tracks = const ['Ән 1', 'Ән 2', 'Ән 3', 'Ән 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎵 Музыкалар'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: tracks.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF2C2C2C),
            child: ListTile(
              leading: const Icon(Icons.music_note, color: Colors.amber),
              title: Text(tracks[index]),
              trailing: const Icon(Icons.play_arrow, color: Colors.green),
            ),
          );
        },
      ),
    );
  }
}

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  final List<String> videos = const ['Видео 1', 'Видео 2', 'Видео 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎬 Видеолар'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF2C2C2C),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.play_circle_fill, color: Colors.redAccent, size: 40),
              title: Text(videos[index]),
              subtitle: const Text('Түрлі контент'),
            ),
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Жеке кабинет'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.amber,
              child: Icon(Icons.person, size: 50, color: Colors.black),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amber.withOpacity(0.5)),
              ),
              child: const Text(
                '💵 Баланс: 0.00 \$',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Қош келдіңіз!',
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
