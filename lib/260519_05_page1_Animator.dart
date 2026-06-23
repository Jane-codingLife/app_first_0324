import 'package:flutter/material.dart';
import 'package:app_first_0324/260519_05_page2_Animator.dart';

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
      title: '頁面切換 Demo2: Animator',
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
      appBar: AppBar(title: const Text('切換頁面2: Animator')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const SecondPage();
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        // 動畫移動
                        final offsetAnimation = Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(animation);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                ),
              );
            },
            child: const Text('開啟第二頁', style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
