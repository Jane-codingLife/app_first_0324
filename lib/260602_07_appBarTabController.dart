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
      theme: ThemeData(primaryColor: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final ValueNotifier<String> _msg = ValueNotifier<String>("");

  static const List<String> _menuItems = ['選項1', '選項2', '選項3'];

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: const Text('Tap Controller 範例'));

    final drawer = Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Drawer 的標題',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ...List.generate(
            _menuItems.length,
            (index) => ListTile(
              title: Text(
                _menuItems[index],
                style: const TextStyle(fontSize: 20),
              ),
              onTap: () {
                _msg.value = _menuItems[index];
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );

    final body = Center(
      child: ValueListenableBuilder<String>(
        valueListenable: _msg,
        builder: _showMsg,
      ),
    );

    return Scaffold(appBar: appBar, drawer: drawer, body: body);
  }

  Widget _showMsg(BuildContext context, String msg, Widget? child) {
    return Text(msg, style: const TextStyle(fontSize: 20),);
  }
}
