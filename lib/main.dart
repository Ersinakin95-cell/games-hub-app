<!DOCTYPE html>
<html lang="kk">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ersinakyn Aziz - Games Hub</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        }
        body {
            background-color: #0d1117;
            color: #ffffff;
            padding-bottom: 70px;
        }
        header {
            text-align: center;
            padding: 15px;
            font-size: 20px;
            font-weight: bold;
            color: #00e5ff;
            background: #161b22;
            border-bottom: 1px solid #30363d;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .page {
            display: none;
            padding: 15px;
        }
        .active-page {
            display: block;
        }
        .card {
            background-color: #161b22;
            border: 1px solid #30363d;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 12px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .card:active {
            background-color: #21262d;
        }
        .card h3 {
            font-size: 16px;
            color: #f0f6fc;
            margin-bottom: 5px;
        }
        .card p {
            font-size: 13px;
            color: #8b949e;
        }
        .coins-banner {
            background: #161b22;
            border: 1px solid #30363d;
            border-radius: 10px;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .coins-title {
            color: #00e5ff;
            font-weight: bold;
        }
        .coins-amount {
            color: #e3b341;
            font-weight: bold;
        }
        .ad-space {
            background: #161b22;
            border: 1px dashed #30363d;
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            margin-bottom: 15px;
        }
        .ad-space h4 {
            color: #f0f6fc;
            margin-bottom: 5px;
        }
        .ad-space p {
            font-size: 12px;
            color: #8b949e;
        }
        /* Detail viewer */
        .detail-content {
            display: none;
            background: #0d1117;
            padding: 10px 0;
            font-size: 14px;
            color: #c9d1d9;
            line-height: 1.6;
            border-top: 1px solid #30363d;
            margin-top: 10px;
        }
        /* Bottom Nav */
        .nav-bar {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            height: 60px;
            background-color: #161b22;
            border-top: 1px solid #30363d;
            display: flex;
            justify-content: space-around;
            align-items: center;
        }
        .nav-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            color: #8b949e;
            font-size: 11px;
            cursor: pointer;
            text-decoration: none;
            width: 16%;
        }
        .nav-item.active {
            color: #00e5ff;
        }
        .nav-icon {
            font-size: 18px;
            margin-bottom: 2px;
        }
        iframe {
            width: 100%;
            height: 400px;
            border: none;
            border-radius: 10px;
        }
    </style>
</head>
<body>

    <header>Ersinakyn Aziz - Games Hub</header>

    <!-- 1. GAMES PAGE -->
    <div id="page-games" class="page active-page">
        <div class="coins-banner">
            <span class="coins-title">GAMES HUB</span>
            <span class="coins-amount">150 Coins</span>
        </div>
        <div class="ad-space">
            <h4>Monetization Space (Google AdSense / Monetag)</h4>
            <p>Жарнама блогы осы жерде шығады</p>
        </div>
        
        <h3 style="margin-bottom: 10px; color: #8b949e;">Ойындар тізімі:</h3>
        <div class="card" onclick="playGame('https://m.famobi.com/html5/om-nom-run/')">
            <h3>🏃 Om Nom Run</h3>
            <p>Қызықты ранер ойыны</p>
        </div>
        <div class="card" onclick="playGame('https://m.famobi.com/html5/smart-bubble-shooter/')">
            <h3>🎯 Bubble Shooter</h3>
            <p>Шарларды ату ойыны</p>
        </div>
        <div class="card" onclick="playGame('https://m.famobi.com/html5/2048/')">
            <h3>🎲 2048 Game</h3>
            <p>Сандарды сәйкестендіру логикалық ойыны</p>
        </div>

        <div id="game-container" style="display:none; margin-top:15px;">
            <button onclick="closeGame()" style="background:#da3633; color:white; border:none; padding:8px 15px; border-radius:5px; margin-bottom:10px; cursor:pointer;">Ойынды жабу ✖</button>
            <iframe id="game-frame" src=""></iframe>
        </div>
    </div>

    <!-- 2. ABAI PAGE -->
    <div id="page-abai" class="page">
        <h3 style="margin-bottom: 10px; color: #8b949e;">Абай мұрасы:</h3>
        <div class="card" onclick="toggleDetail('abai-1')">
            <h3>📖 1. Бірінші қара сөз</h3>
            <p>Қазақша мазмұн (ашу үшін басыңыз)</p>
            <div id="abai-1" class="detail-content">
                Бұл жасқа келгенше жақсы өткіздік пе, жаман өткіздік пе, әйтеуір өмірді сүрдік... Енді не істеу керек? Ел бағу? Жоқ, елге бағым жоқ. Мал бағу? Жоқ, баға алмаймын. Ғылым бағу? Жоқ, ғылымды ұғатын кісі жоқ. Ақыры ойладым: осы ойыма келген нәрселерді жаза берейін, кімде-кім ішінен керекті сөз тапса, жазып алсын...
            </div>
        </div>
        <div class="card" onclick="toggleDetail('abai-2')">
            <h3>📖 2. Екінші қара сөз</h3>
            <p>Қазақша мазмұн (ашу үшін басыңыз)</p>
            <div id="abai-2" class="detail-content">
                Мен бала күнімде естуші едім, біздің қазақ сартты көрсе, «үлгісіз сарт» деуші еді... Енді қарап тұрсам, ноғайлар да, сарттар да, орыстар да бізден өнер-білімге алдеқайда ілгері екен.
            </div>
        </div>
    </div>

    <!-- 3. MUKAGALI PAGE -->
    <div id="page-mukagali" class="page">
        <h3 style="margin-bottom: 10px; color: #8b949e;">Мұқағали Мақатаев поэзиясы:</h3>
        <div class="card" onclick="toggleDetail('muka-1')">
            <h3>✍️ Көгілдір көлдей</h3>
            <p>Өлеңдер жинағы</p>
            <div id="muka-1" class="detail-content">
                Поэзия! Менімен егіз бе едің?<br>
                Сен мені сезесің бе, неге іздедім?<br>
                Сонда да бір өзіңмен тілдесемін...
            </div>
        </div>
    </div>

    <!-- 4. MUSIC PAGE -->
    <div id="page-music" class="page">
        <h3 style="margin-bottom: 10px; color: #8b949e;">Музыка:</h3>
        <div class="card">
            <h3>🎵 Қазақша әндер жинағы</h3>
            <p>Плейлист дайындалуда...</p>
        </div>
    </div>

    <!-- 5. VIDEO PAGE -->
    <div id="page-video" class="page">
        <h3 style="margin-bottom: 10px; color: #8b949e;">Видеолар:</h3>
        <div class="card">
            <h3>🎬 Видео контент</h3>
            <p>Жақында қосылады...</p>
        </div>
    </div>

    <!-- 6. PROFILE PAGE -->
    <div id="page-profile" class="page">
        <h3 style="margin-bottom: 10px; color: #8b949e;">Жеке профиль:</h3>
        <div class="card">
            <h3>👤 Пайдаланушы</h3>
            <p>Монеталар: 150 Coins</p>
        </div>
    </div>

    <!-- BOTTOM NAVIGATION -->
    <div class="nav-bar">
        <div class="nav-item active" onclick="switchTab('games', this)">
            <span class="nav-icon">🎮</span>
            <span>Games</span>
        </div>
        <div class="nav-item" onclick="switchTab('abai', this)">
            <span class="nav-icon">📙</span>
            <span>Абай</span>
        </div>
        <div class="nav-item" onclick="switchTab('mukagali', this)">
            <span class="nav-icon">📚</span>
            <span>Мұқағали</span>
        </div>
        <div class="nav-item" onclick="switchTab('music', this)">
            <span class="nav-icon">🎵</span>
            <span>Музыка</span>
        </div>
        <div class="nav-item" onclick="switchTab('video', this)">
            <span class="nav-icon">🎥</span>
            <span>Видео</span>
        </div>
        <div class="nav-item" onclick="switchTab('profile', this)">
            <span class="nav-icon">👤</span>
            <span>Профиль</span>
        </div>
    </div>

    <script>
        // Бөлімдерді ауыстыру функциясы
        function switchTab(tabId, element) {
            const pages = document.querySelectorAll('.page');
            pages.forEach(page => page.classList.remove('active-page'));

            const navItems = document.querySelectorAll('.nav-item');
            navItems.forEach(item => item.classList.remove('active'));

            document.getElementById('page-' + tabId).classList.add('active-page');
            element.classList.add('active');
        }

        // Тізімдегі мәтінді ашу/жабу функциясы
        function toggleDetail(id) {
            const el = document.getElementById(id);
            if (el.style.display === "block") {
                el.style.display = "none";
            } else {
                el.style.display = "block";
            }
        }

        // Ойынды іске қосу функциясы
        function playGame(url) {
            const container = document.getElementById('game-container');
            const frame = document.getElementById('game-frame');
            frame.src = url;
            container.style.display = 'block';
            window.scrollTo({ top: container.offsetTop, behavior: 'smooth' });
        }

        // Ойынды жабу
        function closeGame() {
            const container = document.getElementById('game-container');
            const frame = document.getElementById('game-frame');
            frame.src = '';
            container.style.display = 'none';
        }
    </script>
</body>
</html>
