import 'package:flutter/material.dart';

void main() {
  runApp(const BiteCraftApp());
}

class BiteCraftApp extends StatelessWidget {
  const BiteCraftApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BiteCraft AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        primaryColor: const Color(0xFF2ECC71),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2ECC71),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _ingredients = [];
  bool _isLoading = false;
  String _generatedRecipe = '';
  String _selectedLanguage = 'kk'; // Әдепкі тіл: Қазақша

  void _generateRecipe() async {
    if (_ingredients.isEmpty) return;

    setState(() {
      _isLoading = true;
      _generatedRecipe = '';
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      if (_selectedLanguage == 'kk') {
        _generatedRecipe = '🥗 **Дәмді лағман мен көкөністер жиынтығы**\n⏱ Дайындалу уақыты: 25 мин | 🔥 380 ккал\n\nҚұрамы:\n- ${_ingredients.join(", ")}\n\nДайындау қадамдары:\n1. Қазанда майды қыздырып, ет пен көкөністерді қуырыңыз.\n2. Тұз, бұрыш және дәмдеуіштер қосып, баяу отта бұқтырыңыз.\n3. Лағман кеспесін қайнатып, үстіне дайын соусты құйып ұсыныңыз.';
      } else if (_selectedLanguage == 'ru') {
        _generatedRecipe = '🥗 **Ароматный лагман с овощами**\n⏱ Время: 25 мин | 🔥 380 ккал\n\nИнгредиенты:\n- ${_ingredients.join(", ")}\n\nИнструкция:\n1. Обжарьте ингредиенты на среднем огне.\n2. Добавьте специи и соус по вкусу.\n3. Подавайте блюдо горячим!';
      } else {
        _generatedRecipe = '🥗 **Delicious Lagman Special**\n⏱ Prep: 25 mins | 🔥 380 kcal\n\nIngredients:\n- ${_ingredients.join(", ")}\n\nInstructions:\n1. Fry all components with spices.\n2. Simmer for 15 minutes.\n3. Serve hot!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BiteCraft AI 🍳'),
        actions: [
          DropdownButton<String>(
            value: _selectedLanguage,
            dropdownColor: const Color(0xFF2ECC71),
            icon: const Icon(Icons.language, color: Colors.white),
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedLanguage = newValue;
                });
              }
            },
            items: const [
              DropdownMenuItem(value: 'kk', child: Text('🇰🇿 Қаз', style: TextStyle(color: Colors.white))),
              DropdownMenuItem(value: 'ru', child: Text('🇷🇺 Рус', style: TextStyle(color: Colors.white))),
              DropdownMenuItem(value: 'en', child: Text('🇺🇸 Eng', style: TextStyle(color: Colors.white))),
            ],
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                ],
              ),
              child: Column(
                children: const [
                  Icon(Icons.kitchen, size: 60, color: Color(0xFF2ECC71)),
                  SizedBox(height: 10),
                  Text(
                    'BiteCraft AI Assistant',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ингредиент қосыңыз (мисалы: Лағман)...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Color(0xFF2ECC71), size: 40),
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      setState(() {
                        _ingredients.add(_controller.text.trim());
                        _controller.clear();
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              children: _ingredients.map((item) {
                return Chip(
                  label: Text(item, style: const TextStyle(fontWeight: FontWeight.w600)),
                  backgroundColor: const Color(0xFF2ECC71).withOpacity(0.2),
                  deleteIcon: const Icon(Icons.cancel, size: 18),
                  onDeleted: () {
                    setState(() {
                      _ingredients.remove(item);
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _generateRecipe,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC71),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Рецепт табу / Найти рецепт',
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 24),
            if (_generatedRecipe.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF2ECC71).withOpacity(0.3)),
                ),
                child: Text(
                  _generatedRecipe,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
