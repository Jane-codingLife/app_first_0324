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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('動畫範例')),
      body: const Center(child: AnimationWrapper()),
    );
  }
}

class AnimationWrapper extends StatefulWidget {
  const AnimationWrapper({super.key});

  @override
  State<AnimationWrapper> createState() => _AnimationWrapperState();
}

class _AnimationWrapperState extends State<AnimationWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _translateAnimation;

  @override
  void initState() {
    super.initState();

    // 動畫時間
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );

    // 移動位置：
    _translateAnimation =
        Tween<double>(begin: -250, end: 250).animate(curvedAnimation)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          });

    // 啟動動畫
    _animationController.forward();
  }

  // 釋放記憶體
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // 版面布置格式
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _translateAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_translateAnimation.value, 0),
          child: child,
        );
      },
      child: const Text(
        '縮放文字 Flutter 動畫',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}
