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
      title: 'AppBar 的 Tab Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
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
  final ValueNotifier<String> _msg = ValueNotifier<String>('請從左側選單選擇項目');

  final List<String> _menuItems = const ['選項1', '選項2', '選項3'];

  @override
  void dispose() {
    _msg.dispose();
    super.dispose();
  }

  void _selectMenuItem(String item) {
    _msg.value = item;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: const Text('Tap Page 範例'));

    final drawer = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Drawer 的標題',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          for (final item in _menuItems)
            ListTile(
              title: Text(item, style: const TextStyle(fontSize: 20),),
              onTap: () => _selectMenuItem(item),
            )
        ],
      ),
    );

    final body = Center(
      child: ValueListenableBuilder<String>(
        valueListenable: _msg,
        builder: (context, value, child) {
          return Text(value, style: const TextStyle(fontSize: 24));
        },
      ),
    );

    return Scaffold(appBar: appBar, drawer: drawer, body: body);
  }
}
