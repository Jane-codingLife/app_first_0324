import 'package:flutter/material.dart';

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    // 釋放
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 建立
    return Center(
      child: Column(
        children: [
          Container(
            width: 300.0,
            // margin: const EdgeInsets.symmetric(horizontal: 200.0),
            margin: const EdgeInsets.symmetric(vertical: 20.0),

            // 內文格式: 輸入值
            child: TextField(
              controller: _controller,
              style: const TextStyle(fontSize: 20.0),
              decoration: const InputDecoration(
                labelText: "請輸入姓名",
                labelStyle: TextStyle(color: Color.fromARGB(255, 15, 56, 77)),
              ),
            ),
          ),
          ElevatedButton(
            child: const Text("確定"),
            onPressed: () => _showSnackBar(context, _controller.text),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String msg) {
    final snackBar = SnackBar(content: Text(msg.isEmpty ? "請輸入文字" : msg + "    您好!!"));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
