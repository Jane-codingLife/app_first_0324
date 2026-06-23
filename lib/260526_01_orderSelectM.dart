import 'package:flutter/material.dart';
import 'package:app_first_0324/260526_01_orderData.dart';

class SelectDrink extends StatelessWidget {
  SelectDrink({super.key});

  final List<String> _drinkList = ['紅茶', '綠茶', '奶茶'];
  final ValueNotifier<int?> _selectItem = ValueNotifier<int?>(Data.drinkItem);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _backToHomePage(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('飲料選擇')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ValueListenableBuilder<int?>(
                  valueListenable: _selectItem,
                  builder:
                      (BuildContext context, int? selectedItem, Widget? child) {
                        return Column(
                          children: List.generate(_drinkList.length, (index) {
                            return RadioListTile<int>(
                              value: index,
                              groupValue: selectedItem,
                              title: Text(
                                _drinkList[index],
                                style: const TextStyle(fontSize: 20),
                              ),
                              onChanged: (value) {
                                _selectItem.value = value;
                              },
                            );
                          }),
                        );
                      },
                ),
              ),

              ElevatedButton(
                onPressed: () => _backToHomePage(context),
                child: const Text('確定'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _backToHomePage(BuildContext context) {
    Data.drinkItem = _selectItem.value;

    final String? drink = Data.drinkItem != null
        ? _drinkList[Data.drinkItem!]
        : null;

    Navigator.pop(context, drink);
  }
}
