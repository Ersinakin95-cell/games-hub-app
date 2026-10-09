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

  // 🔑 Gemini API кілті (GitHub Secrets арқылы немесе автоматты түрде беріледі)
  final String _geminiApiKey = const String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: 'AIzaSyAm44R-59SgK5k0J71XzE2v8Y3p0Q1w9Zx',
  );

  final Map<String, Map<String, String>> _localizedStrings = {
    'kk': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'Ингредиент немесе тағам атын жазыңыз...',
      'btn_search': 'Рецепт табу',
      'subtitle': 'Аспаздық көмекші',
      'recipe_title': 'Дайын рецепт:',
      'empty_alert': 'Өтініш, тағам немесе ингредиент атын енгізіңіз!',
      'lang_name': 'Kazakh',
    },
    'ru': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'Введите ингредиент или название блюда...',
      'btn_search': 'Найти рецепт',
      'subtitle': 'Кулинарный помощник',
      'recipe_title': 'Готовый рецепт:',
      'empty_alert': 'Пожалуйста, введите название блюда или ингредиенты!',
      'lang_name': 'Russian',
    },
    'en': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'Enter ingredient or dish name...',
      'btn_search': 'Find Recipe',
      'subtitle': 'AI Culinary Assistant',
      'recipe_title': 'Generated Recipe:',
      'empty_alert': 'Please enter a dish or ingredient name!',
      'lang_name': 'English',
    },
    'tr': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'Malzeme veya yemek adı girin...',
      'btn_search': 'Tarif Bul',
      'subtitle': 'Mutfak Asistanı',
      'recipe_title': 'Hazır Tarif:',
      'empty_alert': 'Lütfen bir yemek veya malzeme adı girin!',
      'lang_name': 'Turkish',
    },
    'ar': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'أدخل المكون أو اسم الطبق...',
      'btn_search': 'البحث عن وصفة',
      'subtitle': 'مساعد الطهي',
      'recipe_title': 'الوصفة الجاهزة:',
      'empty_alert': 'الرجاء إدخال اسم الطبق أو المكونات!',
      'lang_name': 'Arabic',
    },
    'de': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'Zutat oder Gerichtsnamen eingeben...',
      'btn_search': 'Rezept finden',
      'subtitle': 'Kulinarischer Assistent',
      'recipe_title': 'Generiertes Rezept:',
      'empty_alert': 'Bitte geben Sie ein Gericht oder Zutaten ein!',
      'lang_name': 'German',
    },
    'fr': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'Entrez un ingrédient ou le nom d\'un plat...',
      'btn_search': 'Trouver une recette',
      'subtitle': 'Assistant Culinaire',
      'recipe_title': 'Recette Générée:',
      'empty_alert': 'Veuillez entrer un nom de plat ou des ingrédients !',
      'lang_name': 'French',
    },
    'es': {
      'title': 'BiteCraft AI 🍳',
      'hint': 'Escriba un ingrediente o nombre del plato...',
      'btn_search': 'Buscar Receta',
      'subtitle': 'Asistente Culinario',
      'recipe_title': 'Receta Generada:',
      'empty_alert': '¡Por favor ingrese un plato или ingredientes!',
      'lang_name': 'Spanish',
    },
    'zh': {
      'title': 'BiteCraft AI 🍳',
      'hint': '输入食材或菜名...',
      'btn_search': '查找食谱',
      'subtitle': '烹饪助手',
      'recipe_title': '生成的食谱：',
      'empty_alert': '请输入菜名或食材！',
      'lang_name': 'Chinese',
    },
    'ja': {
      'title': 'BiteCraft AI 🍳',
      'hint': '食材や料理名を入力...',
      'btn_search': 'レシピを検索',
      'subtitle': 'AI料理アシスタント',
      'recipe_title': '生成されたレシピ:',
      'empty_alert': '料理名または食材を入力してください！',
      'lang_name': 'Japanese',
    },
    'ko': {
      'title': 'BiteCraft AI 🍳',
      'hint': '재료나 요리 이름을 입력하세요...',
      'btn_search': '레시피 찾기',
      'subtitle': '요리 도우미',
      'recipe_title': '생성된 레시피:',
      'empty_alert': '요리 이름이나 재료를 입력해주세요!',
      'lang_name': 'Korean',
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

    final String langName = _getText('lang_name');
    final String prompt = '''
    You are BiteCraft AI, an expert master chef.
    Requested inputs: ${_ingredients.join(", ")}.
    
    STRICT LANGUAGE REQUIREMENT:
    Write the ENTIRE recipe output STRICTLY AND ONLY in this language: $langName (Language code: ${widget.currentLang}).
    Do NOT output in any other language.
    
    Provide a full, highly authentic and accurate step-by-step recipe:
    - Dish Name (with emoji)
    - Preparation & Cooking Time | Estimated Calories
    - Complete Ingredient List (with precise quantities/measurements)
    - Clear Step-by-Step Instructions.
    ''';

    try {
      final response = await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_geminiApiKey'),
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
        _generateSmartFallbackRecipe();
      }
    } catch (e) {
      _generateSmartFallbackRecipe();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _generateSmartFallbackRecipe() {
    final String query = _ingredients.join(" ").toLowerCase();
    String lang = widget.currentLang;

    setState(() {
      if (query.contains('пицца') || query.contains('pizza')) {
        if (lang == 'kk') {
          _generatedRecipe = '🍕 **Дәмді Үй Пиццасы**\n⏱ Дайындалу уақыты: 30 мин | 🔥 420 ккал\n\nҚұрамы:\n- Ұн - 250г, Ыстық су - 150мл, Ашытқы - 1 ш.қ.\n- Моцарелла сыры - 150г\n- Колбаса/Пепперони - 100г\n- Томат соусы, зәйтүн майы\n\nДайындалуы:\n1. Қамырды илеп, 15 минутқа қалдырыңыз.\n2. Қамырды жайып, соус жағыңыз, сыр мен колбасаны тізіңіз.\n3. 220°C духовкада 12-15 минут пісіріңіз.';
        } else if (lang == 'ru') {
          _generatedRecipe = '🍕 **Домашняя Пицца**\n⏱ Время: 30 мин | 🔥 420 ккал\n\nИнгредиенты:\n- Мука - 250г, Вода - 150мл, Дрожжи - 1 ч.л.\n- Сыр Моцарелла - 150г\n- Колбаса/Пепперони - 100г\n- Томатный соус, специи\n\nИнструкция:\n1. Замесите тесто и раскатайте круглую основу.\n2. Смажьте соусом, выложите сыр и начинку.\n3. Выпекайте при 220°C в течение 12-15 минут.';
        } else {
          _generatedRecipe = '🍕 **Homemade Pizza**\n⏱ Prep: 30 min | 🔥 420 kcal\n\nIngredients:\n- Flour - 250g, Water - 150ml, Yeast - 1 tsp\n- Mozzarella cheese - 150g\n- Pepperoni/Sausage - 100g\n- Tomato sauce\n\nInstructions:\n1. Prepare dough, roll into shape.\n2. Spread sauce, add cheese and toppings.\n3. Bake at 220°C for 12-15 minutes.';
        }
      } else {
        if (lang == 'kk') {
          _generatedRecipe = '🍳 **${_ingredients.join(", ")} тағамы**\n⏱ Дайындалу уақыты: 20 мин | 🔥 300 ккал\n\nҚұрамы:\n- ${_ingredients.join("\n- ")}\n- Дәмдеуіштер, май\n\nДайындалуы:\n1. Ингредиенттерді жуып тураңыз.\n2. Табада қуырып, пісіріңіз.';
        } else if (lang == 'en') {
          _generatedRecipe = '🍳 **Dish with ${_ingredients.join(", ")}**\n⏱ Prep: 20 min | 🔥 300 kcal\n\nIngredients:\n- ${_ingredients.join("\n- ")}\n- Spices, Oil\n\nInstructions:\n1. Prepare and chop ingredients.\n2. Fry on medium heat until ready.';
        } else {
          _generatedRecipe = '🍳 **Блюдо из ${_ingredients.join(", ")}**\n⏱ Время: 20 мин | 🔥 300 ккал\n\nИнгредиенты:\n- ${_ingredients.join("\n- ")}\n- Специи, Масло\n\nИнструкция:\n1. Нарежьте ингредиенты.\n2. Обжарьте на среднем огне до готовности.';
        }
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
