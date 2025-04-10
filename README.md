<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VROT-X Casino</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        body {
            background-color: #f5f5f5;
            color: #333;
        }
        .header {
            background-color: #1a1a1a;
            color: white;
            padding: 15px 0;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        }
        .logo {
            color: #4285F4;
            font-size: 24px;
            font-weight: bold;
            letter-spacing: 1px;
        }
        .account-button {
            background: white;
            margin: 20px;
            padding: 15px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            cursor: pointer;
            font-size: 18px;
            font-weight: bold;
            color: #333;
            transition: all 0.2s;
        }
        .account-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .account-button:active {
            background: linear-gradient(rgba(66, 133, 244, 0.1), rgba(66, 133, 244, 0.1)), white;
            transform: translateY(0);
        }
        /* Игры */
        .games-container {
            padding: 0 20px;
        }
        .games-title-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }
        .games-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 8px;
        }
        .title-gradient-line {
            width: 100px;
            height: 3px;
            background: linear-gradient(90deg, #4285F4, #34A853);
            border-radius: 3px;
        }
        .games-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }
        .game-card {
            background: white;
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: all 0.2s;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }
        .game-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .game-card:active::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(rgba(66, 133, 244, 0.3), rgba(66, 133, 244, 0.1));
            border-radius: 10px;
        }
        .game-icon {
            font-size: 30px;
            margin-bottom: 10px;
        }
        .game-name {
            font-weight: bold;
        }
        .loading {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.8);
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-size: 20px;
            z-index: 1000;
        }
    </style>
</head>
<body>
    <div class="loading" id="loading">Инициализация...</div>

    <div class="header">
        <div class="logo">VROT-X</div>
    </div>
    <div class="account-button" id="accountButton" onclick="goToProfile()">
        👤 Мой аккаунт
    </div>
    <div class="games-container">
        <div class="games-title-container">
            <div class="games-title">Наши игры</div>
            <div class="title-gradient-line"></div>
        </div>
        <div class="games-grid">
            <div class="game-card" onclick="openGame('miner')">
                <div class="game-icon">💣</div>
                <div class="game-name">Минер</div>
            </div>
            <div class="game-card" onclick="openGame('dice')">
                <div class="game-icon">🎲</div>
                <div class="game-name">Кости</div>
            </div>
            <div class="game-card" onclick="openGame('slots')">
                <div class="game-icon">🎰</div>
                <div class="game-name">Слоты</div>
            </div>
            <div class="game-card" onclick="openGame('wheel')">
                <div class="game-icon">🎡</div>
                <div class="game-name">Колесо</div>
            </div>
        </div>
    </div>
    <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-database.js"></script>
    <script>
        const firebaseConfig = {
            apiKey: "AIzaSyCMos6Y7C-krTLuKCI4VJG-TFLo6QI--k8",
            authDomain: "vrot-x-7a48f.firebaseapp.com",
            databaseURL: "https://vrot-x-7a48f-default-rtdb.firebaseio.com",
            projectId: "vrot-x-7a48f",
            storageBucket: "vrot-x-7a48f.firebasestorage.app",
            messagingSenderId: "622297225288",
            appId: "1:622297225288:web:5df6a5b02ffddedd96e07d"
        };
        
        // Инициализация Firebase
        firebase.initializeApp(firebaseConfig);
        const database = firebase.database();
        
        // Глобальные переменные
        let userId = null;
        let dbRef = null;
        let isFirebaseConnected = false;
        let loadingElement = document.getElementById('loading');

        // Функция для создания/получения локального ID пользователя
        function getOrCreateUserId() {
            let localUserId = localStorage.getItem('vrot-x_userId');
            if (!localUserId) {
                // Генерируем уникальный ID: local_ + случайная строка + timestamp
                localUserId = 'local_' + Math.random().toString(36).substr(2, 12) + 
                            '_' + Date.now().toString(36);
                localStorage.setItem('vrot-x_userId', localUserId);
            }
            return localUserId;
        }

        // Инициализация пользователя
        async function initUser() {
            // Получаем или создаем локальный ID
            userId = getOrCreateUserId();
            dbRef = database.ref('users/' + userId);
            
            try {
                // Проверяем соединение с Firebase
                await database.ref('.info/connected').once('value');
                isFirebaseConnected = true;
                
                // Проверяем существование пользователя в базе
                const snapshot = await dbRef.once('value');
                
                if (!snapshot.exists()) {
                    // Создаем нового пользователя
                    await dbRef.set({
                        balance: 0,
                        created_at: new Date().toISOString(),
                        last_active: new Date().toISOString(),
                        is_local_user: true
                    });
                } else {
                    // Обновляем время последней активности
                    await dbRef.update({
                        last_active: new Date().toISOString()
                    });
                }
                
                loadingElement.style.display = 'none';
                
            } catch (error) {
                console.error("Ошибка подключения к Firebase:", error);
                // Все равно продолжаем работу, но в оффлайн режиме
                loadingElement.textContent = "Работаем в оффлайн режиме";
                setTimeout(() => {
                    loadingElement.style.display = 'none';
                }, 2000);
            }
        }

        // Открытие игры
        function openGame(game) {
            switch(game) {
                case 'miner':
                    window.location.href = "miner.html";
                    break;
                case 'dice':
                    alert('Игра "Кости" в разработке');
                    break;
                case 'slots':
                    alert('Игра "Слоты" в разработке');
                    break;
                case 'wheel':
                    alert('Игра "Колесо" в разработке');
                    break;
                default:
                    console.error('Unknown game:', game);
            }
        }

        // Переход в профиль
        function goToProfile() {
            window.location.href = "profile.html";
        }

        // Инициализация при загрузке страницы
        document.addEventListener('DOMContentLoaded', () => {
            initUser();
            
            // Гарантированное закрытие загрузки через 5 секунд
            setTimeout(() => {
                if (loadingElement.style.display !== 'none') {
                    loadingElement.style.display = 'none';
                }
            }, 5000);
        });
    </script>
</body>
</html>
