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
      heightFactor: 2.0,
      
      child: PopupMenuButton<int>(
        color: Colors.blue[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),

        // 位移的格式(水平, 垂直)
        offset: const Offset(100.0, 30.0),
        // 選取與取消選取的狀態
        onSelected: (value) => _showSnackBar(context, "你選擇了第 $value 項選單"),
        onCanceled: () => _showSnackBar(context, "取消選項"),

        itemBuilder: (context) => const [
          PopupMenuItem<int>(
            value: 1,
            child: Text(
              "選項一",
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
          PopupMenuDivider(), // 分隔線
          PopupMenuItem<int>(
            value: 2,
            child: Text(
              "選項二",
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<int>(
            value: 3,
            child: Text(
              "選項三",
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<int>(
            value: 4,
            child: Text(
              "選項四",
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<int>(
            value: 5,
            child: Text(
              "選項五",
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
          PopupMenuDivider(),
        ]
      ),
    );
  }
}
