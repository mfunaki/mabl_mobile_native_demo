import 'package:flutter/material.dart';

void main() {
  runApp(const MablDemoApp());
}

class MablDemoApp extends StatelessWidget {
  const MablDemoApp({Key? key}) : super(key: key);

  @override // O を o に修正
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mablデモアプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // アプリの初期画面として「ログイン画面」を指定
      home: const LoginScreen(),
    );
  }
}

// --- 画面の定義 ---

// 1. ログイン画面 (初期画面)
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override // O を o に修正
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // mablの「自動修復(Auto-heal)」デモ用のキー
  // このキーを動的に変更することで、HTML版の「ID変更」をシミュレートします
  ValueKey _loginButtonKey = const ValueKey('login_button_v1');

  // ★ mablテストの鍵 ★
  // Flutterでは、テスト対象のウィジェットに 'key' を設定します。
  // これがWebの 'id' や 'data-testid' の役割を果たします。
  final Key _emailFieldKey = const ValueKey('login_email_field');
  final Key _passwordFieldKey = const ValueKey('login_password_field');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // TODO: ここにロゴ画像を追加
            const SizedBox(height: 48.0),
            Text(
              'デモアプリへようこそ',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            TextFormField(
              key: _emailFieldKey, // ★ mablテスト用キー
              decoration: const InputDecoration(
                labelText: 'メールアドレス',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              key: _passwordFieldKey, // ★ mablテスト用キー
              decoration: const InputDecoration(
                labelText: 'パスワード',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              key: _loginButtonKey, // ★ mablテスト用キー (動的)
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                // ログイン成功とみなし、ホーム画面に遷移
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MainAppScreen()),
                );
              },
              child: const Text('ログイン'),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. メインアプリ画面（ホームと設定のタブを持つ）
class MainAppScreen extends StatefulWidget {
  const MainAppScreen({Key? key}) : super(key: key);

  @override // O を o に修正
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0; // 現在選択中のタブ

  // タブに対応する画面のリスト
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(), // ホーム画面
    SettingsScreen(), // 設定画面
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// 3. ホーム画面 (プレースホルダー)
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
        actions: [
          IconButton(
            key: const ValueKey('cart_icon'), // ★ mabl (Visual Find) テスト用
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // カートアイコンのタップ（現在は何も起こらない）
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'ようこそ、Demo Userさん',
          key: ValueKey('welcome_message'), // ★ mablアサーション用キー
          style: TextStyle(fontSize: 24),
        ),
      ),
      // TODO: AIアサーション用の商品リストをここに追加
    );
  }
}

// 4. 設定画面 (プレースホルダー)
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              key: const ValueKey('change_id_button'), // ★ mablテスト用キー
              onPressed: () {
                // TODO: 自動修復デモのロジック（キーの変更）をここに実装
              },
              child: const Text('自動修復(Auto-heal)デモ'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const ValueKey('logout_button'), // ★ mablテスト用キー
              onPressed: () {
                // ログアウト処理（ログイン画面に戻る）
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('ログアウト'),
            ),
          ],
        ),
      ),
    );
  }
}