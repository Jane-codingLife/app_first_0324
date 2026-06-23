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
  final ValueNotifier<double> _opacity = ValueNotifier(1.0);

  @override
  void dispose() {
    _opacity.dispose();
    super.dispose();
  }

  void _changeOpacity() {
    _opacity.value = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Opacity 透明度 淡化範例')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<double>(
              valueListenable: _opacity,
              builder: (context, opacity, child) {
                return AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(seconds: 1),
                  onEnd: () {
                    if (_opacity.value == 0.0) {
                      _opacity.value = 1.0;
                    }
                  },
                  child: const Text(
                    'Flutter Opacity 透明動畫',
                    style: TextStyle(fontSize: 30),
                  ),
                );
              },
            ),

            const SizedBox(height: 20,),

            ElevatedButton(
              onPressed: _changeOpacity, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
              child: const Text(
                '消失吧!',
                style: TextStyle(fontSize: 18, color: Colors.white),
              )
            )

          ],
        ),
      ),
    );
  }
}
