import 'package:flutter/material.dart';
import 'package:app_first_0324/260609_02_saveReadData.dart';

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
      title: 'Save(暫存 Temp) And Read Data',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final ValueNotifier<String> _name = ValueNotifier<String>('');
  final SharePreferencesHelper _helper = SharePreferencesHelper();

  @override
  void dispose() {
    _nameController.dispose();
    _name.dispose();
    super.dispose();
  }

  // 定義儲存、讀取
  Future<void> _saveName() async {
    await _helper.saveName(_nameController.text);
  }

  Future<void> _readName() async {
    final name = await _helper.readName();
    _name.value = name;
  }

  // 畫面配置
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('儲存資料')),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 200,
              // vertical => 垂直
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: _nameController,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '請輸入姓名',
                  labelStyle: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: _buildButton(text: '儲存至暫存區', onPressed: _saveName),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: _buildButton(text: '讀取姓名', onPressed: _readName),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ValueListenableBuilder<String>(
                valueListenable: _name,
                builder: _nameWidgetBuilder,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurpleAccent,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        elevation: 5,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _nameWidgetBuilder(BuildContext context, String name, Widget? child) {
    return Text(name, style: const TextStyle(fontSize: 20),);
  }
}
