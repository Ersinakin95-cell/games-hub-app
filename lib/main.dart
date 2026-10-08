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
      title: 'Ersinakyn Aziz - Games Hub',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF161B22),
          elevation: 0,
        ),
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
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const GamesPage(),
    const AbaiPage(),
    const MukagaliPage(),
    const MusicPage(),
    const VideoPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ersinakyn Aziz - Games Hub',
          style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF161B22),
        selectedItemColor: const Color(0xFF00E5FF),
        unselectedItemColor: const Color(0xFF8B949E),
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Абай'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Мұқағали'),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Музыка'),
          BottomNavigationBarItem(icon: Icon(Icons.videocam), label: 'Видео'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}

// 1. GAMES PAGE
class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF161B22),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF30363D)),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('GAMES HUB', style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold)),
              Text('150 Coins', style: TextStyle(color: Color(0xFFE3B341), fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF161B22),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF30363D)),
          ),
          child: const Column(
            children: [
              Text('Monetization Space (Google AdSense)', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text('Жарнама блогы осы жерде шығады', style: TextStyle(color: Color(0xFF8B949E), fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text('Ойындар тізімі:', style: TextStyle(color: Color(0xFF8B949E), fontSize: 16)),
        const SizedBox(height: 10),
        _buildGameCard(context, '🏃 Om Nom Run', 'Қызықты ранер ойыны'),
        _buildGameCard(context, '🎯 Bubble Shooter', 'Шарларды ату ойыны'),
        _buildGameCard(context, '🎲 2048 Game', 'Логикалық сан ойыны'),
      ],
    );
  }

  static Widget _buildGameCard(BuildContext context, String title, String subtitle) {
    return Card(
      color: const Color(0xFF161B22),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Color(0xFF8B949E))),
        trailing: const Icon(Icons.play_arrow, color: Color(0xFF00E5FF)),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title ойыны таңдалды')),
          );
        },
      ),
    );
  }
}

// 2. ABAI PAGE
class AbaiPage extends StatelessWidget {
  const AbaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Абай мұрасы:', style: TextStyle(color: Color(0xFF8B949E), fontSize: 16)),
        const SizedBox(height: 10),
        _buildExpandableCard(
          '📖 1. Бірінші қара сөз',
          'Бұл жасқа келгенше жақсы өткіздік пе, жаман өткіздік пе, әйтеуір өмірді сүрдік... Енді не істеу керек? Ел бағу? Жоқ, елге бағым жоқ. Мал бағу? Жоқ, баға алмаймын. Ғылым бағу? Жоқ, ғылымды ұғатын кісі жоқ. Ақыры ойладым: осы ойыма келген нәрселерді жаза берейін, кімде-кім ішінен керекті сөз тапса, жазып алсын...',
        ),
        _buildExpandableCard(
          '📖 2. Екінші қара сөз',
          'Мен бала күнімде естуші едім, біздің қазақ сартты көрсе, «үлгісіз сарт» деуші еді... Енді қарап тұрсам, ноғайлар да, сарттар да, орыстар да бізден өнер-білімге алдеқайда ілгері екен.',
        ),
      ],
    );
  }

  static Widget _buildExpandableCard(String title, String content) {
    return Card(
      color: const Color(0xFF161B22),
      margin: const EdgeInsets.only(bottom: 10),
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: const Text('Қазақша мазмұн (ашу үшін басыңыз)', style: TextStyle(color: Color(0xFF8B949E), fontSize: 12)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(content, style: const TextStyle(color: Color(0xFFC9D1D9), height: 1.5)),
          ),
        ],
      ),
    );
  }
}

// 3. MUKAGALI PAGE
class MukagaliPage extends StatelessWidget {
  const MukagaliPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Мұқағали Мақатаев поэзиясы:', style: TextStyle(color: Color(0xFF8B949E), fontSize: 16)),
        const SizedBox(height: 10),
        AbaiPage._buildExpandableCard(
          '✍️ Поэзия',
          'Поэзия! Менімен егіз бе едің?\nСен мені сезесің бе, неге іздедім?\nСонда да бір өзіңмен тілдесемін...',
        ),
      ],
    );
  }
}

// 4. MUSIC PAGE
class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('🎵 Музыка бөлімі дайындалуда...', style: TextStyle(color: Color(0xFF8B949E))),
    );
  }
}

// 5. VIDEO PAGE
class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('🎬 Видео контент жақында қосылады...', style: TextStyle(color: Color(0xFF8B949E))),
    );
  }
}

// 6. PROFILE PAGE
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: const Color(0xFF161B22),
        child: const ListTile(
          leading: Icon(Icons.person, color: Color(0xFF00E5FF)),
          title: Text('Пайдаланушы'),
          subtitle: Text('Баланс: 150 Coins', style: TextStyle(color: Color(0xFFE3B341))),
        ),
      ),
    );
  }
}
