import 'package:flutter/material.dart';
import 'package:app_first_0324/260519_04_page2.dart';

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
      title: '頁面切換 Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _openSecondPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('切換頁面'),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ElevatedButton(
            onPressed: () => _openSecondPage(context), 
            child: const Text('開啟第二頁', style: TextStyle(fontSize: 18),)
          ),
        ),
      ),
    );
  }
}
