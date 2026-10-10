import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const BiteCraftApp());
}

class BiteCraftApp extends StatelessWidget {
  const BiteCraftApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BiteCraft AI',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
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
  bool _isLoading = false;
  String _recipe = '';

  final String _geminiApiKey = const String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: 'AIzaSyAm44R-59SgK5k0J71XzE2v8Y3p0Q1w9Zx',
  );

  Future<void> _generate() async {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _isLoading = true;
      _recipe = '';
    });

    try {
      final response = await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_geminiApiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': 'Create a short recipe using: ${_controller.text}'}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _recipe = data['candidates'][0]['content']['parts'][0]['text'];
        });
      } else {
        setState(() {
          _recipe = 'Қате шықты. Қайталап көріңіз.';
        });
      }
    } catch (e) {
      setState(() {
        _recipe = 'Интернет байланысын тексеріңіз.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BiteCraft AI 🍳')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Ингредиент жазыңыз...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isLoading ? null : _generate,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Рецепт табу'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_recipe, style: const TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
