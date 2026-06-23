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
      title: 'AppBar 的 Button Menu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final ValueNotifier<String> _msg = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    final phoneButton = IconButton(
      icon: const Icon(Icons.phone_android, color: Colors.pinkAccent),
      onPressed: () {
        _msg.value = '你按下了手機按鈕';
      },
    );

    final popupMenu = PopupMenuButton<int>(
      itemBuilder: (context) => const [
        PopupMenuItem<int>(
          value: 1,
          child: Text('第一項', style: TextStyle(fontSize: 20)),
        ),
        PopupMenuDivider(),
        PopupMenuItem<int>(
          value: 2,
          child: Text('第二項', style: TextStyle(fontSize: 20)),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            _msg.value = '第一項訊息資訊: Hello';
            break;
          case 2:
            _msg.value = '第二項訊息資料: Hi';
            break;
        }
      },
    );

    final appBar = AppBar(
      title: const Text('AppBar with Button Menu'),
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () {
          _msg.value = "你按下返回首頁按鈕";
        },
        child: const Icon(Icons.home, color: Colors.blue,),
      ),
      actions: [phoneButton, popupMenu],
    );

    return Scaffold(
      appBar: appBar,
      body: ValueListenableBuilder<String>(
        valueListenable: _msg,
        builder: _showMsg,
      ),
    );
  }

  Widget _showMsg(BuildContext context, String msg, Widget? child) {
    return Center(
      child: Text(msg, style: const TextStyle(fontSize: 20),),
    );
  }
}
