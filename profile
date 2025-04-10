<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Профиль аккаунта - VROT-X</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background-color: #eaeaea;
            color: #333;
        }

        .header {
            display: flex;
            align-items: center;
            padding: 15px;
            background-color: #1a1a1a;
            color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            position: relative;
        }

        .back-button {
            cursor: pointer;
            font-size: 18px;
            margin-right: 20px;
            color: white;
        }

        .header-title {
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            color: #4285F4;
            font-weight: bold;
            font-size: 20px;
        }

        .profile-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }

        .avatar-container {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background-color: #2c3e50;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            overflow: hidden;
            border: 3px solid #4285F4;
            box-shadow: 0 0 10px rgba(66, 133, 244, 0.5);
        }

        .avatar-img {
            width: 80%;
            height: 80%;
            object-fit: contain;
            filter: brightness(0) invert(1) opacity(0.8);
        }

        .user-info {
            width: 100%;
            max-width: 400px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
            margin-bottom: 20px;
            position: relative;
        }

        .username-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-bottom: 10px;
        }

        .username {
            font-weight: bold;
            font-size: 20px;
        }

        .edit-username {
            cursor: pointer;
            font-size: 16px;
            color: #4285F4;
        }

        .user-id {
            color: #555;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .balance-container {
            background: #f0f0f0;
            padding: 15px;
            border-radius: 8px;
            margin-top: 15px;
            position: relative;
            overflow: hidden;
        }

        .balance-container::before {
            content: "💰💵💲";
            position: absolute;
            opacity: 0.1;
            font-size: 60px;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            white-space: nowrap;
        }

        .balance-title {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
            position: relative;
        }

        .balance-amount {
            font-size: 24px;
            font-weight: bold;
            color: #4285F4;
            position: relative;
        }

        .promo-card {
            width: 100%;
            max-width: 400px;
            background: linear-gradient(135deg, #4285F4, #34A853);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            color: white;
            margin-bottom: 20px;
        }

        .promo-title {
            font-weight: bold;
            margin-bottom: 15px;
            text-align: center;
            font-size: 18px;
        }

        .promo-input-container {
            display: flex;
            gap: 10px;
        }

        .promo-input {
            flex-grow: 1;
            padding: 12px;
            border: 1px solid rgba(255,255,255,0.3);
            border-radius: 5px;
            font-size: 16px;
            background: rgba(255,255,255,0.1);
            color: white;
            width: 70%;
        }

        .promo-input::placeholder {
            color: rgba(255,255,255,0.7);
        }

        .promo-button {
            padding: 0 20px;
            background-color: white;
            color: #4285F4;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            transition: all 0.2s;
        }

        .promo-button:hover {
            transform: scale(1.05);
        }

        .promo-button:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }

        .history-container {
            width: 100%;
            max-width: 400px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .history-title {
            font-weight: bold;
            margin-bottom: 15px;
            text-align: center;
            font-size: 18px;
        }

        .history-table {
            width: 100%;
            border-collapse: collapse;
        }

        .history-table th {
            text-align: left;
            padding: 8px;
            border-bottom: 1px solid #ddd;
            font-weight: bold;
        }

        .history-table td {
            padding: 8px;
            border-bottom: 1px solid #eee;
        }

        .history-type {
            font-weight: 500;
        }

        .history-amount.positive {
            color: #4CAF50;
            font-weight: bold;
        }

        .history-amount.negative {
            color: #f44336;
            font-weight: bold;
        }

        .no-history {
            text-align: center;
            color: #777;
            padding: 20px 0;
        }

        .loader {
            border: 4px solid #f3f3f3;
            border-top: 4px solid #4285F4;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            animation: spin 1s linear infinite;
            margin: 0 auto;
        }

        .notification {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            width: 90%;
            max-width: 400px;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.2);
            z-index: 1000;
            display: flex;
            flex-direction: column;
            animation: slideIn 0.3s ease-out;
        }

        .notification.success {
            background-color: #4CAF50;
            color: white;
        }

        .notification.error {
            background-color: #f44336;
            color: white;
        }

        .notification.warning {
            background-color: #FF9800;
            color: white;
        }

        .notification-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .notification-close {
            background: none;
            border: none;
            color: inherit;
            font-size: 20px;
            cursor: pointer;
        }

        .notification-progress {
            height: 4px;
            background-color: rgba(255,255,255,0.3);
            border-radius: 2px;
            margin-top: 10px;
            overflow: hidden;
        }

        .notification-progress-bar {
            height: 100%;
            background-color: white;
            width: 100%;
            animation: progress 5s linear forwards;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes slideIn {
            from { transform: translateX(-50%) translateY(-50px); opacity: 0; }
            to { transform: translateX(-50%) translateY(0); opacity: 1; }
        }

        @keyframes progress {
            from { width: 100%; }
            to { width: 0%; }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="back-button" onclick="goBack()">← Назад</div>
        <div class="header-title">VROT-X</div>
    </div>

    <div class="profile-content">
        <div class="avatar-container">
            <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTEyLDJBMTAsMTAgMCAwLDAgMiwxMkExMCwxMCAwIDAsMCAxMiwyMkExMCwxMCAwIDAsMCAyMiwxMkExMCwxMCAwIDAsMCAxMiwyTTEyLDRBNyw3IDAgMCwxIDE5LDExQTcsNyAwIDAsMSAxMiwxOEE3LDcgMCAwLDEgNSwxMUE3LDcgMCAwLDEgMTIsNE0xMiw2QTUsNSAwIDAsMCA3LDExQTUsNSAwIDAsMCAxMiwxNkE1LDUgMCAwLDAgMTcsMTFBNSw1IDAgMCwwIDEyLDZNMTIsOEEzLDMgMCAwLDEgMTUsMTFBNCw0IDAgMCwxIDEyLDE1QTQsNCAwIDAsMSA5LDExQTMsMyAwIDAsMSAxMiw4WiIgZmlsbD0id2hpdGUiLz48L3N2Zz4=" 
                 class="avatar-img" 
                 alt="Аватар" />
        </div>

        <div class="user-info">
            <div class="username-container">
                <div class="username" id="username">Игрок</div>
                <div class="edit-username" id="editUsername">✏️</div>
            </div>
            <div class="user-id" id="userId">ID: Загрузка...</div>
            
            <div class="balance-container">
                <div class="balance-title">Ваш баланс</div>
                <div class="balance-amount" id="balance">
                    <div class="loader" id="balanceLoader"></div>
                    <span id="balanceAmount" style="display: none;">0 ₽</span>
                </div>
            </div>
        </div>

        <div class="promo-card">
            <div class="promo-title">Активировать промокод</div>
            <div class="promo-input-container">
                <input type="text" class="promo-input" id="promoInput" placeholder="Введите промокод">
                <button class="promo-button" id="promoButton">✓</button>
            </div>
        </div>

        <div class="history-container">
            <div class="history-title">История операций</div>
            <table class="history-table">
                <thead>
                    <tr>
                        <th>Тип</th>
                        <th>Сумма</th>
                    </tr>
                </thead>
                <tbody id="historyBody">
                    <tr>
                        <td colspan="2" class="no-history">Загрузка истории...</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-database.js"></script>
    <script>
        // Конфигурация Firebase
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
        let lastBalance = 0;
        let isFirstLoad = true;

        // Получение ID пользователя из localStorage
        function getUserId() {
            let userId = localStorage.getItem('vrot-x_userId');
            if (!userId) {
                userId = 'local_' + Math.random().toString(36).substr(2, 12) + '_' + Date.now().toString(36);
                localStorage.setItem('vrot-x_userId', userId);
            }
            return userId;
        }

        // Показ уведомления
        function showNotification(type, message) {
            const notification = document.createElement('div');
            notification.className = `notification ${type}`;
            notification.innerHTML = `
                <div class="notification-header">
                    <div>${message}</div>
                    <button class="notification-close">&times;</button>
                </div>
                <div class="notification-progress">
                    <div class="notification-progress-bar"></div>
                </div>
            `;
            
            document.body.appendChild(notification);
            
            // Закрытие по кнопке
            notification.querySelector('.notification-close').addEventListener('click', () => {
                notification.remove();
            });
            
            // Автоматическое закрытие через 5 секунд
            setTimeout(() => {
                notification.remove();
            }, 5000);
        }

        // Обновление истории операций
        function updateHistory(history) {
            const historyBody = document.getElementById('historyBody');
            
            if (!history || history.length === 0) {
                historyBody.innerHTML = `
                    <tr>
                        <td colspan="2" class="no-history">Нет операций</td>
                    </tr>
                `;
                return;
            }

            // Берем последние 10 операций и переворачиваем порядок (новые сверху)
            const last10 = history.slice(-10).reverse();
            
            historyBody.innerHTML = last10.map(op => `
                <tr>
                    <td class="history-type">${op.type === 'promo' ? 'Промокод' : 'Система'}</td>
                    <td class="history-amount ${op.amount >= 0 ? 'positive' : 'negative'}">
                        ${op.amount >= 0 ? '+' : ''}${op.amount.toFixed(2)} ₽
                    </td>
                </tr>
            `).join('');
        }

        // Добавление системной операции
        async function addSystemOperation(userId, currentBalance, newBalance) {
            const difference = newBalance - currentBalance;
            if (difference === 0) return;

            try {
                const userSnapshot = await database.ref('users/' + userId).once('value');
                const userData = userSnapshot.val();
                const history = userData?.history || [];
                
                await database.ref('users/' + userId).update({
                    history: [...history, {
                        type: 'system',
                        amount: difference,
                        date: new Date().toISOString()
                    }]
                });
            } catch (error) {
                console.error('Ошибка добавления системной операции:', error);
            }
        }

        // Активация промокода
        async function activatePromo(promoCode) {
            const userId = getUserId();
            const promoButton = document.getElementById('promoButton');
            promoButton.disabled = true;
            
            try {
                // Проверяем, активировал ли уже пользователь промокод
                const userSnapshot = await database.ref('users/' + userId).once('value');
                const userData = userSnapshot.val();
                
                if (userData && userData.promo === true) {
                    showNotification('warning', 'Лимит активаций 1/1');
                    return;
                }
                
                // Проверяем промокод
                if (promoCode.toUpperCase() === 'FREE') {
                    // Обновляем баланс и отмечаем промокод как использованный
                    const newBalance = (userData?.balance || 0) + 50;
                    const history = userData?.history || [];
                    
                    await database.ref('users/' + userId).update({
                        balance: newBalance,
                        promo: true,
                        history: [...history, {
                            type: 'promo',
                            amount: 50,
                            date: new Date().toISOString()
                        }]
                    });
                    
                    showNotification('success', 'Промокод активирован! +50₽');
                } else {
                    showNotification('error', 'Промокод не найден');
                }
            } catch (error) {
                console.error('Ошибка активации промокода:', error);
                showNotification('error', 'Ошибка активации');
            } finally {
                promoButton.disabled = false;
            }
        }

        // Редактирование ника
        function setupUsernameEdit() {
            const usernameElement = document.getElementById('username');
            const editButton = document.getElementById('editUsername');
            
            editButton.addEventListener('click', () => {
                const currentName = usernameElement.textContent;
                const newName = prompt('Введите новый никнейм:', currentName);
                
                if (newName && newName.trim() && newName !== currentName) {
                    const userId = getUserId();
                    
                    database.ref('users/' + userId).update({
                        username: newName.trim(),
                        redact_name: true
                    }).then(() => {
                        usernameElement.textContent = newName.trim();
                        showNotification('success', 'Никнейм успешно изменен!');
                    }).catch(error => {
                        console.error('Ошибка сохранения ника:', error);
                        showNotification('error', 'Ошибка изменения ника');
                    });
                }
            });
        }

        // Загрузка данных пользователя
        function loadUserData() {
            userId = getUserId();
            dbRef = database.ref('users/' + userId);
            document.getElementById('userId').textContent = `ID: ${userId}`;

            // Обновляем данные каждую секунду
            setInterval(() => {
                dbRef.once('value').then((snapshot) => {
                    const userData = snapshot.val();
                    if (userData) {
                        const currentBalance = userData.balance || 0;
                        
                        // Обновляем баланс
                        const balanceLoader = document.getElementById('balanceLoader');
                        const balanceAmount = document.getElementById('balanceAmount');
                        
                        balanceLoader.style.display = 'none';
                        balanceAmount.style.display = 'inline';
                        balanceAmount.textContent = `${currentBalance.toFixed(2)} ₽`;
                        
                        // Проверяем изменение баланса
                        if (!isFirstLoad && lastBalance !== currentBalance) {
                            addSystemOperation(userId, lastBalance, currentBalance);
                        }
                        
                        lastBalance = currentBalance;
                        isFirstLoad = false;
                        
                        // Обновляем имя, если есть
                        if (userData.username) {
                            document.getElementById('username').textContent = userData.username;
                        }

                        // Обновляем историю операций
                        updateHistory(userData.history);
                    }
                });
            }, 1000); // Обновление каждую секунду
        }

        function goBack() {
            window.location.href = "index.html";
        }

        // Инициализация при загрузке страницы
        document.addEventListener('DOMContentLoaded', () => {
            loadUserData();
            setupUsernameEdit();
            
            // Обработчик кнопки активации промокода
            document.getElementById('promoButton').addEventListener('click', () => {
                const promoInput = document.getElementById('promoInput');
                if (promoInput.value.trim()) {
                    activatePromo(promoInput.value.trim());
                    promoInput.value = '';
                }
            });
            
            // Активация по Enter
            document.getElementById('promoInput').addEventListener('keypress', (e) => {
                if (e.key === 'Enter') {
                    document.getElementById('promoButton').click();
                }
            });
        });
    </script>
</body>
</html>
