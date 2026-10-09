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

  void _generateRecipe() async {
    if (_ingredients.isEmpty) return;

    setState(() {
      _isLoading = true;
      _generatedRecipe = '';
    });

    final String userLanguage = Localizations.localeOf(context).languageCode;

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _generatedRecipe = userLanguage == 'ru'
          ? '🥗 **Овощной салат с сыром**\n⏱ Время: 15 мин | 🔥 220 ккал\n\nИнгредиенты:\n- Помидор, огурец, сыр\n\nИнструкция:\n1. Нарежьте овощи кубиками.\n2. Добавьте сыр и заправьте маслом.'
          : userLanguage == 'kk'
              ? '🥗 **Көкөніс пен ірімшік салаты**\n⏱ Уақыты: 15 мин | 🔥 220 ккал\n\nҚұрамы:\n- Қызанақ, қияр, ірімшік\n\nДайындалуы:\n1. Көкөністерді тураңыз.\n2. Ірімшік қосып, маймен араластырыңыз.'
              : '🥗 **Fresh Vegetable Salad**\n⏱ Prep: 15 mins | 🔥 220 kcal\n\nIngredients:\n- Tomato, Cucumber, Cheese\n\nInstructions:\n1. Dice all vegetables.\n2. Add cheese and drizzle with olive oil.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BiteCraft AI 🍳'),
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
                      hintText: 'Add ingredient (e.g. Milk, Eggs)...',
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
                  : const Text('Generate Recipes / Рецепт табу',
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
