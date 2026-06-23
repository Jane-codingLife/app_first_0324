import 'package:flutter/material.dart';

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  final ValueNotifier<String> _inputName = ValueNotifier<String>("");

  final TextEditingController _namecontroller = TextEditingController();

  @override
  void dispose() {
    // 釋放
    _inputName.dispose();
    _namecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 建立
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 300.0,
            // margin: const EdgeInsets.symmetric(horizontal: 200.0),
            margin: const EdgeInsets.symmetric(vertical: 10.0),

            // 內文格式: 輸入值
            child: TextField(
              controller: _namecontroller,
              style: const TextStyle(fontSize: 20.0),
              decoration: const InputDecoration(
                labelText: "請輸入姓名",
                labelStyle: TextStyle(color: Color.fromARGB(255, 15, 56, 77)),
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton(
              child: const Text("送出"),
              onPressed: () {
                setState(() {
                  _inputName.value = _namecontroller.text;
                });
              },
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ValueListenableBuilder<String>(
              valueListenable: _inputName,
              builder: _inputNameWidgetBuilder,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputNameWidgetBuilder(
    BuildContext context,
    String inputname,
    Widget? child,
  ) {
    return Text(inputname, style: const TextStyle(fontSize: 20));
  }
}
