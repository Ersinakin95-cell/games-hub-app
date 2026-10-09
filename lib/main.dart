import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const BiteCraftApp());
}

class BiteCraftApp extends StatefulWidget {
  const BiteCraftApp({Key? key}) : super(key: key);

  @override
  State<BiteCraftApp> createState() => _BiteCraftAppState();
}

class _BiteCraftAppState extends State<BiteCraftApp> {
  String _selectedLanguage = 'kk';

  void _changeLanguage(String langCode) {
    setState(() {
      _selectedLanguage = langCode;
    });
  }

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
      home: HomeScreen(
        currentLang: _selectedLanguage,
        onLangChanged: _changeLanguage,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String currentLang;
  final Function(String) onLangChanged;

  const HomeScreen({
    Key? key,
    required this.currentLang,
    required this.onLangChanged,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _ingredients = [];
  bool _isLoading = false;
  String _generatedRecipe = '';

  BannerAd? _bannerAd;
  bool _isBannerLoaded = false;

  final String _bannerAdUnitId = 'ca-app-pub-3613410984183490/6007334630';

  final Map<String, Map<String, String>> _localizedStrings = {
    'kk': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'Ингредиент немесе тағам атын жазыңыз...',
      'btn_search': 'Рецепт табу',
      'subtitle': 'Аспаздық көмекші',
      'recipe_title': 'Дайын рецепт:',
      'empty_alert': 'Өтініш, тағам немесе ингредиент атын енгізіңіз!',
    },
    'ru': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'Введите ингредиент или название блюда...',
      'btn_search': 'Найти рецепт',
      'subtitle': 'Кулинарный помощник',
      'recipe_title': 'Готовый рецепт:',
      'empty_alert': 'Пожалуйста, введите название блюда или ингредиенты!',
    },
    'en': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'Enter ingredient or dish name...',
      'btn_search': 'Find Recipe',
      'subtitle': 'AI Culinary Assistant',
      'recipe_title': 'Generated Recipe:',
      'empty_alert': 'Please enter a dish or ingredient name!',
    },
    'tr': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'Malzeme veya yemek adı girin...',
      'btn_search': 'Tarif Bul',
      'subtitle': 'Mutfak Asistanı',
      'recipe_title': 'Hazır Tarif:',
      'empty_alert': 'Lütfen bir yemek veya malzeme adı girin!',
    },
    'ar': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'أدخل المكون أو اسم الطبق...',
      'btn_search': 'البحث عن وصفة',
      'subtitle': 'مساعد الطهي',
      'recipe_title': 'الوصفة الجاهزة:',
      'empty_alert': 'الرجاء إدخال اسم الطبق أو المكونات!',
    },
    'de': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'Zutat oder Gerichtsnamen eingeben...',
      'btn_search': 'Rezept finden',
      'subtitle': 'Kulinarischer Assistent',
      'recipe_title': 'Generiertes Rezept:',
      'empty_alert': 'Bitte geben Sie ein Gericht oder Zutaten ein!',
    },
    'fr': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'Entrez un ingrédient ou le nom d\'un plat...',
      'btn_search': 'Trouver une recette',
      'subtitle': 'Assistant Culinaire',
      'recipe_title': 'Recette Générée:',
      'empty_alert': 'Veuillez entrer un nom de plat ou des ingrédients !',
    },
    'es': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'Escriba un ingrediente o nombre del plato...',
      'btn_search': 'Buscar Receta',
      'subtitle': 'Asistente Culinario',
      'recipe_title': 'Receta Generada:',
      'empty_alert': '¡Por favor ingrese un plato o ingredientes!',
    },
    'zh': {
      'title': 'BiteCraft AI 🍳',
      'hint': '输入食材或菜名...',
      'btn_search': '查找食谱',
      'subtitle': '烹饪助手',
      'recipe_title': '生成的食谱：',
      'empty_alert': '请输入菜名或食材！',
    },
    'ja': {
      'title': 'BiteCraft AI 🍳',
      'hint': '食材や料理名を入力...',
      'btn_search': 'レシピを検索',
      'subtitle': 'AI料理アシスタント',
      'recipe_title': '生成されたレシピ:',
      'empty_alert': '料理名または食材を入力してください！',
    },
    'ko': {
      'title': 'BiteCraft AI 🍳',
      'hint': '재료나 요리 이름을 입력하세요...',
      'btn_search': '레시피 찾기',
      'subtitle': '요리 도우미',
      'recipe_title': '생성된 레시피:',
      'empty_alert': '요리 이름이나 재료를 입력해주세요!',
    },
  };

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
          Future.delayed(const Duration(seconds: 10), () {
            if (mounted) _loadBannerAd();
          });
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _controller.dispose();
    super.dispose();
  }

  String _getText(String key) {
    return _localizedStrings[widget.currentLang]?[key] ?? _localizedStrings['en']![key]!;
  }

  Future<void> _generateRecipeWithGemini() async {
    if (_controller.text.trim().isNotEmpty) {
      _ingredients.add(_controller.text.trim());
      _controller.clear();
    }

    if (_ingredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_getText('empty_alert'))),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _generatedRecipe = '';
    });

    const String apiKey = 'YOUR_GEMINI_API_KEY';
    final String prompt = '''
    You are BiteCraft AI professional chef assistant.
    User input ingredients/dish: ${_ingredients.join(", ")}.
    Target Language Code: ${widget.currentLang}.
    
    Provide a detailed, delicious recipe in the target language (${widget.currentLang}).
    Format:
    - Dish Name (with emoji)
    - Cooking Time & Calories
    - Complete Ingredient List (with measurements)
    - Step-by-step cooking instructions.
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
      if (query.contains('плов') || query.contains('палау') || query.contains('rice')) {
        _generatedRecipe = widget.currentLang == 'kk'
            ? '🍲 **Дәмді Өзбек Палауы**\n⏱ Дайындалу уақыты: 60 мин | 🔥 550 ккал\n\nҚұрамы:\n- Күріш - 500г\n- Ет - 500г\n- Сәбіз - 500г\n- Пияз - 2 дана\n- Май - 150мл\n- Тұз, дәмдеуіштер\n\nНұсқаулық:\n1. Ет пен пиязды, сәбізді қуырыңыз.\n2. Су құйып 25 мин бұқтырыңыз.\n3. Күрішті салып, су тартылғанша қайнатып, 20 мин демдеңіз.'
            : '🍲 **Delicious Pilaf / Плов**\n⏱ Prep: 60 min | 🔥 550 kcal\n\nIngredients:\n- Rice - 500g\n- Meat - 500g\n- Carrots - 500g\n- Onions - 2 pcs\n- Oil, Salt & Spices\n\nInstructions:\n1. Fry meat, onions, and carrots in oil.\n2. Add water and simmer for 25 minutes.\n3. Add rice, cook until water evaporates, then cover for 20 minutes.';
      } else {
        _generatedRecipe = widget.currentLang == 'kk'
            ? '🍳 **${_ingredients.join(", ")} тағамы**\n⏱ Дайындалу уақыты: 20 мин | 🔥 300 ккал\n\nҚұрамы:\n- ${_ingredients.join("\n- ")}\n- Тұз, бұрыш, май\n\nДайындалуы:\n1. Ингредиенттерді жуып, тураңыз.\n2. Қызып тұрған табада майға қуырыңыз.\n3. Тұз бен дәмдеуіштер қосып, пісіріңіз.'
            : '🍳 **Dish: ${_ingredients.join(", ")}**\n⏱ Prep: 20 min | 🔥 300 kcal\n\nIngredients:\n- ${_ingredients.join("\n- ")}\n- Salt, Pepper, Oil\n\nInstructions:\n1. Prepare and chop ingredients.\n2. Fry on medium heat.\n3. Season to taste and serve.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getText('title')),
        actions: [
          DropdownButton<String>(
            value: widget.currentLang,
            dropdownColor: const Color(0xFF2ECC71),
            icon: const Icon(Icons.language, color: Colors.white),
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                widget.onLangChanged(newValue);
              }
            },
            items: const [
              DropdownMenuItem(value: 'kk', child: Text('🇰🇿 Қаз', style: TextStyle(color: Colors.white))),
              DropdownMenuItem(value: 'ru', child: Text('🇷🇺 Рус', style: TextStyle(color: Colors.white))),
              DropdownMenuItem(value: 'en', child: Text('🇺🇸 Eng', style: TextStyle(color: Colors.white))),
              DropdownMenuItem(value: 'tr', child: Text('🇹🇷 Tür', style: TextStyle(color: Colors.white))),
              DropdownMenuItem(value: 'ar', child: Text('🇸🇦 Arb', style: TextStyle(color: Colors.white))),
              DropdownMenuItem(value: 'de', child: Text('🇩🇪 Deu', style: TextStyle(color: Colors.white))),
              DropdownMenuItem(value: 'fr', child: Text('🇫🇷 Fra', style: TextStyle(color: Colors.white))),
              DropdownMenuItem(value: 'es', child: Text('🇪🇸 Esp', style: TextStyle(color: Colors.white))),
              DropdownMenuItem(value: 'zh', child: Text('🇨🇳 Zho', style: TextStyle(color: Colors.white))),
              DropdownMenuItem(value: 'ja', child: Text('🇯🇵 Jpn', style: TextStyle(color: Colors.white))),
              DropdownMenuItem(value: 'ko', child: Text('🇰🇷 Kor', style: TextStyle(color: Colors.white))),
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
                      children: [
                        const Icon(Icons.kitchen, size: 60, color: Color(0xFF2ECC71)),
                        const SizedBox(height: 10),
                        Text(
                          _getText('subtitle'),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                            hintText: _getText('hint'),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onSubmitted: (_) => _generateRecipeWithGemini(),
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
                  if (_ingredients.isNotEmpty) const SizedBox(height: 12),
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
                        : Text(
                            _getText('btn_search'),
                            style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getText('recipe_title'),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2ECC71)),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _generatedRecipe,
                            style: const TextStyle(fontSize: 15, height: 1.5),
                          ),
                        ],
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
