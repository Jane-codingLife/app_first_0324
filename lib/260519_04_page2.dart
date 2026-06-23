import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('第二頁'), backgroundColor: Colors.amber,),
      backgroundColor: const Color(0xFFDCDCDC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('返回上頁')
          ),
        ),
      ),
    );
  }
}
