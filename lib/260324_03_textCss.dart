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

    var appTitle = Text("Hello Flutter Here TitleBar2");
    var contentSayHi = Text(
      """
Flutter Hello World3 ~~!!
Nice To Meet you.
Happy you are.
      """,
      style: TextStyle(
        fontSize: 30,
        color: Color(0xFFFFFFFF), //0xFF + 色票代碼
        decoration: TextDecoration.overline,
        fontWeight: FontWeight.w600, //FontWeight(900)
        // backgroundColor: Color(0xFF00F7FF), 
        // backgroundColor 放 TextStyle 字體底色(Mark效果)
      ),
      textAlign: TextAlign.right,
      // maxLines: 4, // 顯示多少行
      
    );

    return Scaffold(
      // backgroundColor 放 Scaffold => body 的底色
      backgroundColor: Color(0xFFFF0000), 
      appBar: AppBar(
        // backgroundColor 放 appBar 標題列底色
        backgroundColor: Color(0xFF00FF15),
        title: appTitle
        ),
      body: Center(child: contentSayHi),
    );
  }
}

/*
myApp [v]
  |__MaterialApp
    |__myHomePage [v]
      |__Scaffold
        |__AppBar
          |__title
            |__Text
        |__Body
          |__Center
            |__child
              |__Text
*/
