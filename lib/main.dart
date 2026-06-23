import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// DATA_MODEL
/// Manages the counter's state and notifies listeners of changes.
class CounterData extends ChangeNotifier {
  int _count;

  /// Initializes the counter to 0.
  CounterData() : _count = 0;

  /// Returns the current count.
  int get count => _count;

  /// Increments the counter by 1 and notifies all listeners.
  void increment() {
    _count++;
    notifyListeners();
  }

  /// Decrements the counter by 1 and notifies all listeners.
  void decrement() {
    _count--;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CounterData>(
      create: (BuildContext context) => CounterData(),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Counter App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const CounterScreen(),
        );
      },
    );
  }
}

/// The main screen for the counter application.
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use context.watch to listen for changes in CounterData and rebuild when necessary.
    final CounterData counter = context.watch<CounterData>();

    return Scaffold(
      appBar: AppBar(
        // Added backgroundColor to distinguish the title bar from the rest of the panel.
        backgroundColor: Colors.deepPurple,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centers the content of the Row
          mainAxisSize: MainAxisSize.min, // Makes the Row only as wide as its children
          children: <Widget>[
            Text('計', style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold)),
            Text('數', style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold)),
            Text('器', style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: true, // Centers the AppBar's title widget
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '目前數值:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
            ),
            Text(
              '${counter.count}',
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    // Use context.read to access CounterData methods without rebuilding this widget.
                    context.read<CounterData>().decrement();
                  },
                  icon: const Icon(Icons.remove),
                  label: const Text('減少'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 18),
                    minimumSize: const Size(150, 50),
                  ),
                ),
                const SizedBox(width: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    // Use context.read to access CounterData methods without rebuilding this widget.
                    context.read<CounterData>().increment();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('增加'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 18),
                    minimumSize: const Size(150, 50),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}