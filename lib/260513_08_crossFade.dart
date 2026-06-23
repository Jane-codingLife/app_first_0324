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
      title: 'Flutter Animation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<bool> _showText = ValueNotifier(true);

  @override
  void dispose() {
    _showText.dispose();
    super.dispose();
  }

  void _toggleView() {
    _showText.value = !_showText.value; // 反值
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change crossFad 互換範例')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: _showText,
              builder: (context, showText, child) {
                return AnimatedCrossFade(
                  duration: const Duration(seconds: 1),
                  crossFadeState: showText ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  // 第一個畫面：字
                  firstChild: Container(
                    width: 400,
                    height: 120,
                    alignment: Alignment.center,
                    child: const Text(
                      'Flutter 動畫文字：微笑！',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // 第二個畫面：圖片 icon
                  secondChild: SizedBox(
                    width: 400,
                    height: 120,
                    child: const Icon(
                      Icons.mood,
                      size: 100,
                      color: Colors.orange,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30,),

            ElevatedButton(
              onPressed: _toggleView, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 30,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
              child: const Text(
                '變身！',
                style: TextStyle(fontSize: 18, color: Colors.white),
              )
            )

          ],
        ),
      ),
    );
  }
}
