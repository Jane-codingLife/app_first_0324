import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
      title: '進度列範例：加上數字表現',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
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
  final ValueNotifier<double> _progressValue = ValueNotifier<double>(0.0);

  Timer? _timer;

  @override
  void dispose() {
    super.dispose();
    _progressValue.dispose();
    _timer?.cancel();
  }

  void _startProgress() {
    _progressValue.value = 0.0;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return PopScope(
          // 防止返回鍵 => 關閉
          canPop: false,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              width: 180,
              height: 180,
              child: Center(
                child: ValueListenableBuilder<double>(
                  valueListenable: _progressValue,
                  builder: _progressBuilder,
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
      final nextValue = _progressValue.value + 0.1;

      if (nextValue >= 1.0) {
        _progressValue.value = 1.0;
        timer.cancel();

        if (mounted && Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      } else {
        _progressValue.value = nextValue;
      }
    });
  }

  Widget _progressBuilder(
    BuildContext context,
    double progressValue,
    Widget? child,
  ) {
    final safeProgressValue = progressValue.clamp(0.0, 1.0);

    return CircularPercentIndicator(
      radius: 60,
      lineWidth: 8,
      percent: safeProgressValue,
      center: Text(
        '${(safeProgressValue * 100).toStringAsFixed(0)}%',
        style: const TextStyle(
          fontSize: 24,
          color: Colors.lightBlue,
          fontWeight: FontWeight.bold,
        ),
      ),
      progressColor: Colors.greenAccent,
      backgroundColor: Colors.grey.shade300,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: const Text("進度列範例：加上數值表示"));

    final btnStart = ElevatedButton(
      onPressed: _startProgress,
      child: const Text("開始", style: TextStyle(fontSize: 18)),
    );

    final body = Center(heightFactor: 3, child: btnStart);

    return Scaffold(appBar: appBar, body: body);
  }
}
