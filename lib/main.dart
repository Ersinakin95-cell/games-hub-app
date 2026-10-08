import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GamesHubMain(),
  ));
}

class GamesHubMain extends StatefulWidget {
  const GamesHubMain({super.key});

  @override
  State<GamesHubMain> createState() => _GamesHubMainState();
}

class _GamesHubMainState extends State<GamesHubMain> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF161B26),
          title: const Text('Қош келдіңіз!', style: TextStyle(color: Colors.white)),
          content: const Text('Платформаға қош келдіңіз! Мұнда Абай мен Мұқағали мұрасы, 100 қазақша ән, видео және ойындар жинақталған.', style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Бастау', style: TextStyle(color: Color(0xFF00F2FE))),
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090A10),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0E15),
        title: const Text('Ersinakyn Aziz - Games Hub', style: TextStyle(color: Color(0xFF00F2FE))),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildGamesTab(),
          _buildContentTab('Абай мұрасы (45 қара сөз, өлеңдер)', Colors.amber, Icons.book),
          _buildContentTab('Мұқағали өлеңдері (100-ден астам өлең)', Colors.cyanAccent, Icons.auto_stories),
          _buildContentTab('Таза Қазақша Әндер (100 ән)', Colors.lightGreenAccent, Icons.music_note),
          _buildContentTab('Таза Қазақша Видеолар (100 видео)', Colors.redAccent, Icons.videocam),
          _buildProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (idx) => setState(() => _selectedIndex = idx),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF00F2FE),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF0D0E15),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Абай'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_stories), label: 'Мұқағали'),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Музыка'),
          BottomNavigationBarItem(icon: Icon(Icons.videocam), label: 'Видео'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }

  Widget _buildGamesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFF161B26), borderRadius: BorderRadius.circular(12)),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('GAMES HUB', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
              Text('150 Coins', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFF161B26), borderRadius: BorderRadius.circular(12)),
          child: const Column(
            children: [
              Text('Monetization Space (Google AdSense)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 8),
              Text('In real deployments, users viewing ads here generate revenue for you!', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContentTab(String title, Color color, IconData icon) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 100,
      itemBuilder: (context, i) => Card(
        color: const Color(0xFF161B26),
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text('${i + 1}. $title', style: const TextStyle(color: Colors.white)),
          subtitle: const Text('Қазақша мазмұн', style: TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }

  Widget _buildProfileTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_circle, size: 80, color: Color(0xFF00F2FE)),
          SizedBox(height: 12),
          Text('Ersinakyn Aziz', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Баланс: 0.00 USD', style: TextStyle(color: Colors.amber, fontSize: 16)),
        ],
      ),
    );
  }
}
