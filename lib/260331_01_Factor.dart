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
      "Hello Flutter Here TitleBar2", 
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w900
      )
    );
    var contentSayHi = Text(
      """
Flutter Hello World3 ~~!!
Nice To Meet you.
Best regards,
Flutter.
      """,
      style: TextStyle(
        fontSize: 30,
        color: Color(0xFFFFFFFF), //0xFF + 色票代碼
        decoration: TextDecoration.overline,
        fontWeight: FontWeight.w600, //FontWeight(900)
        // backgroundColor: Color(0xFF00F7FF),
        // backgroundColor 放 TextStyle 字體底色(Mark效果)
      ),
      textAlign: TextAlign.left,

      // maxLines: 4, // 顯示多少行
    );

    return Scaffold(
      // backgroundColor 放 Scaffold => body 的底色
      backgroundColor: Color.fromARGB(155, 102, 255, 0),
      appBar: AppBar(
        // backgroundColor 放 appBar 標題列底色
        backgroundColor: Color(0xFF00FF15),
        title: appTitle,
      ),

      body: Center(
        // heightFactor: 0,
        // widthFactor: 1,
        child: Container(
          alignment: Alignment.bottomLeft,
          color: Colors.amber[800],
          // margin: const EdgeInsets.all(20), // all() 四邊一致
          margin: const EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0), // fromLTRB(left, top, right, bottom)
          padding: const EdgeInsets.all(20),

          child: contentSayHi,
        ),
      ),
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
/*
Image.asset - 載入本地端圖片

Image.network - 載入網路圖片

Image.file - 載入裝置端(手機里)圖片
*/
