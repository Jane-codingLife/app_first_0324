import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  void showToast() {
    Fluttertoast.showToast(
      msg: "你按了按鈕",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.brown[900],
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text("你按了按鈕2-This is snackBar"),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.blueAccent[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      action: SnackBarAction(
        label: "呼叫 Toast",
        textColor: Colors.white,
        onPressed: showToast,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build 放內容

    var appTitle = Text(
      "Hello Flutter Here TitleBar2",
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

      body: Center(
        child: Container(
          child: ElevatedButton(
            // onPressed: showToast,
            onPressed: () => showSnackBar(context),

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[900],
              foregroundColor: Colors.blue,
              elevation: 10.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 20.0,
              ),
            ),

            child: const Text(
              "我是一個按鈕",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
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
