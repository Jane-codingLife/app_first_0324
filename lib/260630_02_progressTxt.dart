import 'dart:async';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

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
      title: '進度列範例：加上文字表現',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
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
  double _progressValue = 0.0;
  Timer? _timer;

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void _startProgress() {
    _progressValue = 0.0;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return PopScope(
          // 防止返回鍵 => 關閉
          canPop: false,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              width: 200,
              height: 100,
              child: Center(
                child: ScalingText(
                  '頁面讀取中，請稍後......',
                  style: TextStyle(fontSize: 20, color: Colors.teal),
                ),
              ),
            ),
          ),
        );
      },
    );

    _timer?.cancel();

    // 模擬進度
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_progressValue >= 1.0) {
        timer.cancel();

        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        _progressValue += 0.1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: const Text("進度列範例：加上文字表示"));

    final btnStart = ElevatedButton(
      onPressed: _startProgress,
      child: const Text("開始", style: TextStyle(fontSize: 18)),
    );

    final body = Center(heightFactor: 3, child: btnStart);

    return Scaffold(appBar: appBar, body: body);
  }
}
