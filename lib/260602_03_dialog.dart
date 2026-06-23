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

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<String> cities = ['台灣', '倫敦', '美國'];

  final ValueNotifier<String> _dialogResult = ValueNotifier('');
  final ValueNotifier<int?> _selectedCity = ValueNotifier(null);

  @override
  void dispose() {
    _dialogResult.dispose();
    _selectedCity.dispose();
    super.dispose();
  }

  Future<void> _openDialog() async {
    final result = await _showCityDialog();

    if (result != null) {
      _dialogResult.value = result;
    }
  }

  Future<String?> _showCityDialog() {
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // 點擊對話框外部不會離開對話框
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('請選擇城市'),
          content: ValueListenableBuilder<int?>(
            valueListenable: _selectedCity,
            builder: _buildCityOptions,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, '');
              },
              child: const Text(
                '取消',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  _selectedCity.value == null
                      ? ''
                      : cities[_selectedCity.value!],
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

  Widget _buildCityOptions(
    BuildContext context,
    int? selectedItem,
    Widget? child,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(cities.length, (index) {
        return RadioListTile<int>(
          value: index,
          groupValue: selectedItem,
          title: Text(cities[index], style: const TextStyle(fontSize: 20)),
          onChanged: (value) {
            _selectedCity.value = value;
          },
        );
      }),
    );
  }

  Widget _dialogResultBuilder(
    BuildContext context,
    String result,
    Widget? child,
  ) {
    return Text(result, style: const TextStyle(fontSize: 20));
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: const Text('對話盒範例'));

    final showDialogButton = ElevatedButton(
      onPressed: _openDialog,
      child: const Text('顯示對話盒', style: TextStyle(fontSize: 20)),
    );

    final body = Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: showDialogButton,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ValueListenableBuilder<String>(
              valueListenable: _dialogResult, 
              builder: _dialogResultBuilder
            ),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
