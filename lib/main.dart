import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const MablDemoApp());
}

// 商品データモデル
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageAsset;
  final Color cardColor;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageAsset,
    required this.cardColor,
  });
}

// サンプル商品データ
final List<Product> sampleProducts = [
  Product(
    id: 'product_1',
    name: 'ワイヤレスヘッドホン',
    description: '高音質で快適な装着感のワイヤレスヘッドホン',
    price: 15800.0,
    imageAsset: 'assets/images/headphone.png',
    cardColor: Colors.blue.shade50,
  ),
  Product(
    id: 'product_2',
    name: 'スマートウォッチ',
    description: '健康管理とフィットネス追跡機能搭載',
    price: 28900.0,
    imageAsset: 'assets/images/smartwatch.png',
    cardColor: Colors.green.shade50,
  ),
  Product(
    id: 'product_3',
    name: 'ワイヤレスマウス',
    description: '人間工学に基づいた快適なデザイン',
    price: 4980.0,
    imageAsset: 'assets/images/mouse.png',
    cardColor: Colors.orange.shade50,
  ),
];

// プロフィール画像を管理するクラス
class ProfileImageProvider extends ChangeNotifier {
  File? _profileImage;

  File? get profileImage => _profileImage;

  void setProfileImage(File? image) {
    _profileImage = image;
    notifyListeners();
  }

  void clearProfileImage() {
    _profileImage = null;
    notifyListeners();
  }
}

class MablDemoApp extends StatelessWidget {
  const MablDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mablデモアプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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

// 2. メインアプリ画面(ホームと設定のタブを持つ)
class MainAppScreen extends StatefulWidget {
  const MainAppScreen({Key? key}) : super(key: key);

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;
  final ProfileImageProvider _profileImageProvider = ProfileImageProvider();

  // タブに対応する画面のリスト
  List<Widget> get _widgetOptions => <Widget>[
        HomeScreen(profileImageProvider: _profileImageProvider),
        SettingsScreen(profileImageProvider: _profileImageProvider),
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
  final ProfileImageProvider profileImageProvider;

  const HomeScreen({Key? key, required this.profileImageProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // ★ プロフィール画像を左上に表示
            ListenableBuilder(
              listenable: profileImageProvider,
              builder: (context, child) {
                return CircleAvatar(
                  key: const ValueKey('profile_image'),
                  radius: 20,
                  backgroundImage: profileImageProvider.profileImage != null
                      ? FileImage(profileImageProvider.profileImage!)
                      : null,
                  child: profileImageProvider.profileImage == null
                      ? const Icon(Icons.person, size: 24)
                      : null,
                );
              },
            ),
            const SizedBox(width: 12),
            const Text('ホーム'),
          ],
        ),
        actions: [
          IconButton(
            key: const ValueKey('cart_icon'),
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'ようこそ、Demo Userさん',
                key: ValueKey('welcome_message'),
                style: TextStyle(fontSize: 24),
              ),
            ),
            // ★ 商品一覧
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'おすすめ商品',
                    key: ValueKey('product_list_title'),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...sampleProducts.map((product) => ProductCard(product: product)),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// 商品カードウィジェット
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey('product_card_${product.id}'), // ★ mablテスト用キー
      color: product.cardColor,
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ★ 製品写真
            Container(
              key: ValueKey('product_image_${product.id}'), // ★ mablテスト用キー
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.image,
                size: 50,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(width: 16),
            // 製品情報
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ★ 製品名
                  Text(
                    product.name,
                    key: ValueKey('product_name_${product.id}'), // ★ mablテスト用キー
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // ★ 説明
                  Text(
                    product.description,
                    key: ValueKey('product_description_${product.id}'), // ★ mablテスト用キー
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // ★ 価格
                  Text(
                    '¥${product.price.toStringAsFixed(0)}',
                    key: ValueKey('product_price_${product.id}'), // ★ mablテスト用キー
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. 設定画面 (プレースホルダー)
class SettingsScreen extends StatelessWidget {
  final ProfileImageProvider profileImageProvider;

  const SettingsScreen({Key? key, required this.profileImageProvider}) : super(key: key);

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    // ★ ギャラリーから画像を選択
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
    );

    if (image != null) {
      profileImageProvider.setProfileImage(File(image.path));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('プロフィール画像を更新しました'),
            key: ValueKey('upload_success_message'), // ★ mablテスト用キー
          ),
        );
      }
    }
  }

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
            // ★ プロフィール画像プレビュー
            ListenableBuilder(
              listenable: profileImageProvider,
              builder: (context, child) {
                return CircleAvatar(
                  key: const ValueKey('profile_image_preview'), // ★ mablテスト用キー
                  radius: 60,
                  backgroundImage: profileImageProvider.profileImage != null
                      ? FileImage(profileImageProvider.profileImage!)
                      : null,
                  child: profileImageProvider.profileImage == null
                      ? const Icon(Icons.person, size: 60)
                      : null,
                );
              },
            ),
            const SizedBox(height: 20),
            // ★ 画像アップロードボタン
            ElevatedButton.icon(
              key: const ValueKey('upload_image_button'), // ★ mablテスト用キー
              onPressed: () => _pickImage(context),
              icon: const Icon(Icons.upload_file),
              label: const Text('プロフィール画像をアップロード'),
            ),
            const SizedBox(height: 10),
            // ★ 画像削除ボタン
            ListenableBuilder(
              listenable: profileImageProvider,
              builder: (context, child) {
                if (profileImageProvider.profileImage == null) {
                  return const SizedBox.shrink();
                }
                return TextButton.icon(
                  key: const ValueKey('remove_image_button'), // ★ mablテスト用キー
                  onPressed: () {
                    profileImageProvider.clearProfileImage();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('プロフィール画像を削除しました'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('画像を削除'),
                );
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              key: const ValueKey('change_id_button'),
              onPressed: () {
                // TODO: 自動修復デモのロジック(キーの変更)をここに実装
              },
              child: const Text('自動修復(Auto-heal)デモ'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const ValueKey('logout_button'),
              onPressed: () {
                // ログアウト処理(ログイン画面に戻る)
                profileImageProvider.clearProfileImage();
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