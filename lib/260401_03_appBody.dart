import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    void _showToast() {
      Fluttertoast.showToast(
        msg: "你按了SnackBar的showToast",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.brown[900],
        textColor: Colors.white,
        fontSize: 20.0,
      );
    }

    void _showSnackBar(BuildContext context, String message) {
      final snackBar = SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.blueAccent[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        action: SnackBarAction(
          label: "呼叫 showToast",
          textColor: Colors.white,
          onPressed: _showToast,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar() // 重複呼叫的時候，前次的消失
        ..showSnackBar(snackBar);
    }

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton(
              // onPressed: showToast,
              onPressed: () =>
                  _showSnackBar(context, "這是你按了 ElevatedButton 傳入的 message."),

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
                "ElevatedButton",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextButton(
              onPressed: () =>
                  _showSnackBar(context, "這是你按了 TextButton 傳入的 message."),

              style: TextButton.styleFrom(foregroundColor: Colors.deepPurple),

              child: const Text(
                "TextButton",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: OutlinedButton(
              onPressed: () =>
                  _showSnackBar(context, "這是你按了 OutlinedButton 傳入的 message."),

              style: OutlinedButton.styleFrom(
                // backgroundColor: Colors.amber[900],
                foregroundColor: Colors.deepPurple,
                // elevation: 10.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0, //左右
                  vertical: 20.0, //上下
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                side: const BorderSide(
                  color: Colors.green,
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
              ),

              child: const Text(
                "OutlinedButton",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: IconButton(
              onPressed: () =>
                  _showSnackBar(context, "這是你按了 IconButton 傳入的 message."),
              icon: const Icon(Icons.line_weight),
              iconSize: 50.0,
              color: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: FloatingActionButton(
              onPressed: () => _showSnackBar(
                context,
                "這是你按了 FloatingActionButton 傳入的 message.",
              ),
              // LinearBorder 正方形 StarBorder 星形
              shape: const CircleBorder(),
              elevation: 2.0,
              child: const Icon(Icons.home, size: 40.0),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton.icon(
              onPressed: () => _showSnackBar(
                context,
                "這是你按了 ElevatedButton.icon 傳入的 message.",
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[900],
                foregroundColor: Colors.blue,
                elevation: 10.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 20.0,
                ),
              ),
              icon: const Icon(Icons.accessibility_rounded, size: 35.0),
              label: const Text("ElevatedButton.icon"),
            ),
          ),
        ],
      ),
    );
  }
}
