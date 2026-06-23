import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        action: SnackBarAction(
          label: "呼叫 Toast",
          textColor: Colors.white,
          onPressed: showToast,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Container(
      margin: EdgeInsets.all(20.0),
      child: ElevatedButton(
        // onPressed: showToast,
        onPressed: () => showSnackBar(context),

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber[900],
          foregroundColor: Colors.blue,
          elevation: 10.0,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        ),

        child: const Text(
          "我是一個按鈕",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
