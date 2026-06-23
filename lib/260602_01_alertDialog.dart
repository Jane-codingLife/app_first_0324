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
      title: '對話盒範例',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  static const List<String> cities = ['台灣', '倫敦', '美國'];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<String> _dialogResult = ValueNotifier('');
  final ValueNotifier<int?> _selectedCity = ValueNotifier(null);

  @override
  void dispose() {
    _dialogResult.dispose();
    _selectedCity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('對話盒範例')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                final result = await _showCityDialog(context);
                _dialogResult.value = result ?? '';
              },
              child: const Text('顯示對話盒', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<String>(
              valueListenable: _dialogResult,
              builder: _buildDialogResult,
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _showCityDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          content: ValueListenableBuilder<int?>(
            valueListenable: _selectedCity,
            builder: _buildCityOptions,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, '');
              },
              child: const Text(
                '取消',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  _selectedCity.value == null
                      ? ''
                      : MyHomePage.cities[_selectedCity.value!],
                );
              },
              child: const Text(
                '確定',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogResult(
    BuildContext context,
    String result,
    Widget? child,
  ) {
    return Text(result, style: const TextStyle(fontSize: 20));
  }

  Widget _buildCityOptions(
    BuildContext context,
    int? selectedItem,
    Widget? child,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(MyHomePage.cities.length, (index) {
        return RadioListTile(
          value: index,
          groupValue: selectedItem,
          title: Text(
            MyHomePage.cities[index],
            style: const TextStyle(fontSize: 20),
          ),
          onChanged: (value) {
            _selectedCity.value = value;
          },
        );
      }),
    );
  }
}
