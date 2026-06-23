import 'package:flutter/material.dart';
import 'package:app_first_0324/260526_01_orderData.dart';

class SelectMainCourse extends StatelessWidget {
  SelectMainCourse({super.key});

  final List<String> _mainCourses = ['牛肉麵', '排骨麵', '雞排飯'];
  final ValueNotifier<int?> _selectItem = ValueNotifier<int?>(
    Data.mainCourseItem,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _backToHomePage(context),
      child: Scaffold(
        appBar: AppBar(title: const Text('主餐選擇')),
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
                          children: List.generate(_mainCourses.length, (index) {
                            return RadioListTile<int>(
                              value: index,
                              groupValue: selectedItem,
                              title: Text(
                                _mainCourses[index],
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

  Future<bool> _backToHomePage(BuildContext context) async {
    Data.mainCourseItem = _selectItem.value;

    final String? mainCourse = Data.mainCourseItem != null
        ? _mainCourses[Data.mainCourseItem!]
        : null;

    Navigator.pop(context, mainCourse);

    return true;
  }
}
