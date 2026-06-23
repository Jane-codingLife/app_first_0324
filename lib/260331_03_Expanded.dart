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
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
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

      body: Container(
        margin: const EdgeInsets.all(20.0),
        color: Colors.blue[300],
        height: 200,

        transform:Matrix4
          //.rotationZ(0.01), // 角度*3.1415926/180
          .translationValues(-10, 50, 0), //移動

        child: Row(
          // 主要(row-列/column-欄)
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // 交錯(row-欄/column-列)
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            Expanded(
              flex: 2,
              child: Container(
                // margin: const EdgeInsets.all(10.0),
                child: const Text(
                  "Flutter123456789",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.amberAccent,
                    backgroundColor: Colors.pinkAccent,
                  ),
                ),
              ),
            ),

            // expanded 分配率
            Expanded(
              flex: 3,
              child: Container(
                // margin: const EdgeInsets.all(10.0),
                child: const Text(
                  "Flutter12345678910",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.amberAccent,
                    backgroundColor: Colors.indigoAccent,
                  ),
                ),
              ),
            ),

            Container(
              // margin: const EdgeInsets.all(10.0),
              child: const Text(
                "Flutter345",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.amberAccent,
                  backgroundColor: Colors.teal,
                ),
              ),
            ),
          ],
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
