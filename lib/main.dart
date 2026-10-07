import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GamesHubApp());
}

class GamesHubApp extends StatelessWidget {
  const GamesHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ersinakyn Aziz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6C5CE7),
        scaffoldBackgroundColor: const Color(0xFF0F0F1E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A2E),
          elevation: 0,
        ),
      ),
      home: const MainGameScreen(),
    );
  }
}

class MainGameScreen extends StatefulWidget {
  const MainGameScreen({super.key});

  @override
  State<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen> {
  InAppWebViewController? webViewController;
  double progress = 0;
  bool isOffline = false;

  final String appUrl = "https://chipper-quokka-a36d95.netlify.app";

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isOffline = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ersinakyn Aziz',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.cyanAccent,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              webViewController?.reload();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (progress < 1.0)
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.transparent,
                color: Colors.cyanAccent,
              ),
            Expanded(
              child: isOffline
                  ? _buildOfflineWidget()
                  : InAppWebView(
                      initialUrlRequest: URLRequest(
                        url: WebUri(appUrl),
                      ),
                      initialSettings: InAppWebViewSettings(
                        useShouldOverrideUrlLoading: true,
                        mediaPlaybackRequiresUserGesture: false,
                        javaScriptEnabled: true,
                        domStorageEnabled: true,
                        allowsInlineMediaPlayback: true,
                      ),
                      onWebViewCreated: (controller) {
                        webViewController = controller;
                      },
                      onProgressChanged: (controller, newProgress) {
                        setState(() {
                          progress = newProgress / 100;
                        });
                      },
                      onReceivedError: (controller, request, error) {
                        setState(() {
                          isOffline = true;
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfflineWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Интернет байланышы жок',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
            ),
            onPressed: () {
              setState(() {
                isOffline = false;
              });
              webViewController?.reload();
            },
            child: const Text('Кайра аракет кылуу', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
