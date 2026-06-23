import 'package:flutter/material.dart';
import 'package:app_first_0324/260526_01_orderSelectD.dart';
import 'package:app_first_0324/260526_01_orderSelectM.dart';

void main() {
  runApp(const MyApp());
}

// StatelessWidget 不會變更的 UI
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build 外框
    return MaterialApp(
      title: '點餐系統',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),

      // 首頁
      initialRoute: '/',

      // 路由設定
      routes: {
        '/': (context) => const MyHomePage(),
        '/select-main-course': (context) => SelectMainCourse(),
        '/select-drink': (context) => SelectDrink(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<String> _selectMainCourse = ValueNotifier<String>(
    '尚未選擇主餐',
  );
  final ValueNotifier<String> _selectDrink = ValueNotifier<String>('尚未選擇飲料');

  @override
  void dispose() {
    _selectMainCourse.dispose();
    _selectDrink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('點餐系統 v1.0')),

      // 安排版面的配置
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
        child: Column(
          children: [
            _buildSelectRow(
              valueNotifier: _selectMainCourse,
              buttonText: '選擇主餐',
              onPressed: () => _showMainCourseScreen(context),
            ),

            const SizedBox(height: 20),

            _buildSelectRow(
              valueNotifier: _selectDrink,
              buttonText: '選擇飲料',
              onPressed: () => _selectDrinkScreen(context),
            ),
          ],
        ),
      ),
    );
  }

  // 共用選單區塊
  Widget _buildSelectRow({
    required ValueNotifier<String> valueNotifier,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Row(
      children: [
        // 顯示選擇結果
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: valueNotifier,
            builder: (context, value, child) {
              return Text(value, style: const TextStyle(fontSize: 20));
            },
          ),
        ),

        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellowAccent,
            foregroundColor: Colors.redAccent,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            elevation: 8,
          ),
          child: Text(buttonText, style: const TextStyle(fontSize: 20)),
        ),
      ],
    );
  }

  // 顯示主餐頁面
  Future<void> _showMainCourseScreen(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/select-main-course');

    _selectMainCourse.value = result?.toString() ?? '沒有選擇主餐';
  }

  // 顯示飲料頁面
  Future<void> _selectDrinkScreen(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/select-drink');

    _selectDrink.value = result?.toString() ?? '沒有選擇飲料';
  }
}
