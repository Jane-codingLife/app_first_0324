import 'package:app_first_0324/260428_01_appBody.dart';
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
      title: "Hello Flutter(AppName)",
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build 放內容

    var appTitle = Text(
      "Radio List Menu Widget",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
    );

    return Scaffold(
      // backgroundColor 放 Scaffold => body 的底色
      backgroundColor: Color.fromARGB(155, 102, 255, 0),
      appBar: AppBar(
        // backgroundColor 放 appBar 標題列底色
        backgroundColor: Color(0xFF00FF15),
        title: appTitle,
      ),

      body: const AppBody(),
    );
  }
}
