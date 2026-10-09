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
  String _selectedLanguage = 'kk';

  BannerAd? _bannerAd;
  bool _isBannerLoaded = false;

  // Тікелей сіздің AdMob Баннер ID-іңіз
  final String _bannerAdUnitId = 'ca-app-pub-3613410984183490/6007334630';

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBannerLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  Future<void> _generateRecipeWithGemini() async {
    if (_ingredients.isEmpty) return;

    setState(() {
      _isLoading = true;
      _generatedRecipe = '';
    });

    const String apiKey = 'YOUR_GEMINI_API_KEY';
    final String prompt = '''
    Сен BiteCraft AI кәсіби аспаз көмекшісісің. 
    Пайдаланушы енгізген ингредиенттер/тағам: ${_ingredients.join(", ")}.
    Тіл: $_selectedLanguage (kk = Қазақша, ru = Орысша, en = Ағылшынша).
    
    Осы ингредиенттерге сәйкес келетін ТОЛЫҚ, НАҚТЫ әрі ДӘМДІ рецепт құрастыр.
    Құрылымы:
    - Тағамның аты (emoji-мен)
    - Дайындалу уақыты мен калориясы
    - Толық Ингредиенттер тізімі (өлшем бірліктерімен)
    - Қадамдық егжей-тегжейлі дайындау нұсқаулығы.
    ''';

    try {
      final response = await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String text = data['candidates'][0]['content']['parts'][0]['text'];
        setState(() {
          _generatedRecipe = text;
        });
      } else {
        _fallbackRecipe();
      }
    } catch (e) {
      _fallbackRecipe();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _fallbackRecipe() {
    final String query = _ingredients.join(" ").toLowerCase();
    setState(() {
      if (query.contains('плов') || query.contains('палау')) {
        _generatedRecipe = _selectedLanguage == 'kk'
            ? '🍲 **Дәмді Өзбек Палауы (Плов)**\n⏱ Дайындалу уақыты: 60 мин | 🔥 550 ккал\n\nҚұрамы:\n- Күріш (Алаңғасар немесе Лазер) - 500г\n- Қой немесе сиыр еті - 500г\n- Сәбіз - 500г\n- Пияз - 2 дана\n- Өсімдік майы - 150мл\n- Сарымсақ - 1 бас\n- Тұз, зыра (зиры), барбарис - талғамға қарай\n\nДайындау қадамдары:\n1. Қазанда майды жақсылап қыздырып, етті алтын түске енгенше қуырыңыз.\n2. Пиязды қосып, жұмсарғанша қуырыңыз, сосын сәбізді салып, жұмсарғанша араластырыңыз.\n3. Үстіне ыстық су құйып, тұз, зыра қосып, 25 минут баяу отта бұқтырыңыз (Зирвак дайындау).\n4. Күрішті жуып, зирвактың үстіне тегістеп салыңыз. Ортасына сарымсақты батырыңыз.\n5. Күріштің үстін 1 см су жауып тұратындай су құйып, су тартылғанша қайнатыңыз.\n6. Отты азайтып, қазанның бетін жауып, 20 минутқа демдеп қойыңыз.'
            : '🍲 **Ароматный Узбекский Плов**\n⏱ Время: 60 мин | 🔥 550 ккал\n\nИнгредиенты:\n- Рис - 500г\n- Мясо (говядина/баранина) - 500г\n- Морковь - 500г\n- Лук - 2 шт.\n- Растительное масло - 150мл\n- Чеснок - 1 головка\n- Специи (зира, барбарис, соль)\n\nИнструкция:\n1. Обжарьте мясо в раскаленном казане до золотистой корочки.\n2. Добавьте лук и морковь, обжаривайте 10-15 минут.\n3. Залейте водой, добавьте специи и томите зирвак 25 минут.\n4. Выложите промытый рис, добавьте чеснок и залейте водой на 1 см выше риса.\n5. Когда вода впитается, закройте крышку и томите на слабом огне 20 минут.';
      } else {
        _generatedRecipe = _selectedLanguage == 'kk'
            ? '🍳 **${_ingredients.join(", ")} тағамы**\n⏱ Дайындалу уақыты: 20 мин | 🔥 300 ккал\n\nҚұрамы:\n- ${_ingredients.join("\n- ")}\n- Тұз, бұрыш, май\n\nДайындалуы:\n1. Ингредиенттерді жуып, тураңыз.\n2. Қызып тұрған табада майға қуырыңыз.\n3. Тұз бен дәмдеуіштер қосып, дайын болғанша пісіріңіз.'
            : '🍳 **Блюдо из ${_ingredients.join(", ")}**\n⏱ Время: 20 мин | 🔥 300 ккал\n\nИнгредиенты:\n- ${_ingredients.join("\n- ")}\n- Соль, перец, масло\n\nИнструкция:\n1. Подготовьте и нарежьте ингредиенты.\n2. Обжарьте на разогретой сковороде.\n3. Добавьте специи и доведите до готовности.';
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                            hintText: 'Ингредиент немесе тағам аты...',
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
                    onPressed: _isLoading ? null : _generateRecipeWithGemini,
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
                        style: const TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (_isBannerLoaded && _bannerAd != null)
            SizedBox(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
        ],
      ),
    );
  }
}
