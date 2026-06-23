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
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<int> _imageIndex = ValueNotifier(0);

  static const _images = <String>[
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
  ];

  @override
  void dispose() {
    _imageIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 上一頁圖片按鈕
    final previousBtn = IconButton(
      icon: Image.asset('assets/images/previous.png'),
      iconSize: 40,
      onPressed: _previousImage,
    );

    // 下一頁圖片按鈕
    final nextBtn = IconButton(
      icon: Image.asset('assets/images/next.png'),
      iconSize: 40,
      onPressed: _nextImage,
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Browse Images Views")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: _imageIndex,
              builder: _imageBuilder,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[previousBtn, nextBtn],
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageBuilder(BuildContext context, int imageIndex, Widget? child) {
    return Image.asset(_images[imageIndex]);
  }

  void _previousImage() {
    _imageIndex.value = _imageIndex.value == 0
        ? _images.length - 1
        : _imageIndex.value - 1;
  }

  void _nextImage() {
    _imageIndex.value = (_imageIndex.value + 1) % _images.length;
  }
}
