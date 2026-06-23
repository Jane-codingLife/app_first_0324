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
      title: 'ListView Animator Demo',
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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final List<String> _items = ['1', '2', '3'];

  int _itemLastNum = 3;

  // 新增資料
  void _addItem() {
    final newItem = (++_itemLastNum).toString();

    _items.add(newItem);

    _listKey.currentState?.insertItem(
      _items.length - 1,
      // 動畫的時間 0.3s
      duration: const Duration(milliseconds: 300),
    );
  }

  // 刪除資料
  void _removeItem(int index) {
    final removedItem = _items[index];

    _items.removeAt(index);

    _listKey.currentState?.removeItem(index, (context, animation) {
      return SizeTransition(
        // 尺寸變化更動
        sizeFactor: animation,
        child: Card(
          child: ListTile(
            title: Text(removedItem, style: const TextStyle(fontSize: 20)),
          ),
        ),
      );
    });
  }

  // 建立每個項目
  Widget _buildItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          title: Text(_items[index], style: const TextStyle(fontSize: 20)),

          // 點擊新增
          onTap: _addItem,

          // 長按刪除
          onLongPress: () => _removeItem(index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 分別先建立 appBar、body 的內容畫面
    final appBar = AppBar(
      title: const Text('ListView Demo3: Animator'),
      centerTitle: true,
    );

    final animatedList = AnimatedList(
      key: _listKey,
      initialItemCount: _items.length,
      itemBuilder: _buildItem,
    );

    // 組合畫面
    return Scaffold(appBar: appBar, body: animatedList,);
  }
}
