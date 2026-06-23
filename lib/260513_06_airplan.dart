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
  final ValueNotifier<Alignment> _alignment = ValueNotifier(
    Alignment.topLeft,
  );

  @override
  void dispose() {
    _alignment.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _alignment.value = Alignment.bottomRight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check Ticket Alignment 範例')),
      body: Center(
        child: SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child:
                    // 變動的主體
                    ValueListenableBuilder<Alignment>(
                      valueListenable: _alignment,
                      builder: (context, alignment, child) {
                        return AnimatedContainer(
                          duration: const Duration(seconds: 3),
                          curve: Curves.fastOutSlowIn,
                          alignment: alignment,
                          onEnd: () {
                            _alignment.value = Alignment.topLeft;
                          },
                          child: child,
                        );
                      },
                      child: const Icon(
                        Icons.airplane_ticket_outlined,
                        color: Colors.lightBlue,
                        size: 50,
                      ),
                    ),
              ),

              // 按鈕
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton.icon(
                  onPressed: _startAnimation,
                  icon: const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      top: 10,
                      bottom: 10
                    ),
                    child: Icon(Icons.airplanemode_active),
                  ),
                  label: const Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      top: 10,
                      bottom: 10
                    ),
                    child: Text(
                      'Go!! And Back.',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
