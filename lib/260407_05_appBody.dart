import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const List<String> trans = ["高鐵", "台鐵", "捷運", "火車"];

class AppBody extends StatefulWidget {
  // StatelessWidget 不會變動的
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  final ValueNotifier<String> _itemName = ValueNotifier<String>("");
  final ValueNotifier<int> _selectedItem = ValueNotifier<int>(-1); // -1 代表沒有選

  @override
  void dispose() {
    _itemName.dispose();
    _selectedItem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // 1.選單
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                child: ValueListenableBuilder<int>(
                  valueListenable: _selectedItem,
                  builder: _dorpdownButtonBuilder,
                ),
              ),

              Container(
                // 2.按鈕
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                child: ElevatedButton(
                  child: const Text("確定"),
                  onPressed: () {
                    _itemName.value = _selectedItem.value < 0
                        ? ""
                        : trans[_selectedItem.value];
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // 3.顯示結果
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                child: ValueListenableBuilder<String>(
                  valueListenable: _itemName,
                  builder: _itemNameWidgetBuilder,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _itemNameWidgetBuilder(
    BuildContext context,
    String itemName,
    Widget? child,
  ) {
    if (itemName != "") {
      itemName = "您選擇的交通工具: " + itemName + ", 確定搭乘!";
    }
    return Text(itemName, style: const TextStyle(fontSize: 20.5));
  }

  Widget _dorpdownButtonBuilder(
    BuildContext context,
    int selectedItem,
    Widget? child,
  ) {
    return DropdownButton<int>(
      hint: const Text("請選擇交通工具", style: TextStyle(fontSize: 20.0)),

      value: selectedItem < 0 ? null : selectedItem,

      items: <DropdownMenuItem<int>>[
        DropdownMenuItem<int>(
          value: 0,
          child: Text("高鐵", style: TextStyle(fontSize: 20.0)),
        ),
        DropdownMenuItem<int>(
          value: 1,
          child: Text("台鐵", style: TextStyle(fontSize: 20.0)),
        ),
        DropdownMenuItem<int>(
          value: 2,
          child: Text("捷運", style: TextStyle(fontSize: 20.0)),
        ),
        DropdownMenuItem<int>(
          value: 3,
          child: Text("火車", style: TextStyle(fontSize: 20.0)),
        ),
      ],

      onChanged: (int? value) {
        if (value != null) {
          _selectedItem.value = value;
        }
      },
    );
  }
}
