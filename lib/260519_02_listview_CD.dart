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
      title: 'ListView Demo',
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
  final ValueNotifier<List<String>> _listItems = ValueNotifier(['1', '2', '3']);

  @override
  void dispose() {
    _listItems.dispose();
    super.dispose();
  }

  // 新增，參數設定
  void _addItem() {
    final newList = List<String>.from(_listItems.value)
      ..add((_listItems.value.length + 1).toString());

    _listItems.value = newList;
  }

  // 刪除
  void _removeItem(int index) {
    final newList = List<String>.from(_listItems.value)..removeAt(index);

    _listItems.value = newList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView Demo2: 新增 & 刪除')),
      body: ValueListenableBuilder<List<String>>(
        valueListenable: _listItems,
        builder: (context, listItems, child) {
          return ListView.separated(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.list),

                title: Text(
                  listItems[index],
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: const Text('點擊新增 / 長按刪除'),
                trailing: const Icon(Icons.arrow_forward_ios),
                
                // 觸發動作
                onTap: _addItem,
                onLongPress: () => _removeItem(index),
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 1,),
          );
        },
      ),
    );
  }
}
