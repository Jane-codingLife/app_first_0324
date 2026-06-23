import 'package:flutter/material.dart';

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
      title: 'AppBar 的 Drawer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<String> _messageNotifier = ValueNotifier<String>(
    '請選擇 Draver 選單',
  );

  @override
  void dispose() {
    _messageNotifier.dispose();
    super.dispose();
  }

  void _selectMenu(String menu) {
    _messageNotifier.value = menu;
    Navigator.pop(context);
  }

  Widget _buildDrawerItem(String title) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 20)),
      onTap: () => _selectMenu(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: const Text('AppBar 的 Drawer 形式'));

    final drawer = Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Drawer 的標題',
              style: TextStyle(fontSize: 20, color: Colors.amber),
            ),
          ),
          _buildDrawerItem('選項1'),
          _buildDrawerItem('選項2'),
          _buildDrawerItem('選項3'),
          _buildDrawerItem('選項4'),
          _buildDrawerItem('選項5'),
          _buildDrawerItem('選項6'),
        ],
      ),
    );

    final body = Center(
      child: ValueListenableBuilder<String>(
        valueListenable: _messageNotifier,
        builder: (context, value, child) {
          return Text(value, style: const TextStyle(fontSize: 24));
        },
      ),
    );

    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: body,
    );
  }
}
