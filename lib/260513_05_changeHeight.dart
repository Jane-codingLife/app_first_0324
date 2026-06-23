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
  final ValueNotifier<double> _barHeight = ValueNotifier(100);

  @override
  void dispose() {
    _barHeight.dispose();
    super.dispose();
  }

  void _changeBarHeight() {
    _barHeight.value = _barHeight.value == 100 ? 800 : 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('改變高度的動畫互動範例')),
      body: Center(
        child: SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 變動的主體
              ValueListenableBuilder<double>(
                valueListenable: _barHeight,
                builder: _animatedContainerBuilder,
              ),

              const SizedBox(height: 20),

              // 按鈕
              ElevatedButton(
                onPressed: _changeBarHeight,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  '左右改變寬度',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _animatedContainerBuilder(
    BuildContext context,
    double barHeight,
    Widget? child,
  ) {
    return AnimatedContainer(
      width: barHeight,
      height: 60,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      color: Colors.deepOrangeAccent,
    );
  }
}
