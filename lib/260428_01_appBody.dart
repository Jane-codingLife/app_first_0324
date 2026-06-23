import 'package:flutter/material.dart';

const List<String> area = ["台北", "台中", "台南", "高雄"];

class AppBody extends StatefulWidget {
  // StatelessWidget 不會變動的
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  final ValueNotifier<String> _cityName = ValueNotifier<String>("");
  final ValueNotifier<int> _selectedCity = ValueNotifier<int>(0); // -1 代表沒有選

  @override
  void dispose() {
    _cityName.dispose();
    _selectedCity.dispose();
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
                  valueListenable: _selectedCity,
                  builder: _radioButtonBuilder,
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
                    _cityName.value = area[_selectedCity.value];
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
                  valueListenable: _cityName,
                  builder: _cityNameWidgetBuilder,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cityNameWidgetBuilder(
    BuildContext context,
    String cityName,
    Widget? child,
  ) {
    if (cityName != "") {
      cityName = "您的居住地: " + cityName + ", 好地方!";
    }
    return Text(cityName, style: const TextStyle(fontSize: 20.5));
  }

  Widget _radioButtonBuilder(
    BuildContext context,
    int selectedItem,
    Widget? child,
  ) {
    // final List<Widget> radioItmes = [];

    // for (var i = 0; i < area.length; i++) {
    //   radioItmes.add(
    //     RadioListTile<int>(
    //       value: i,
    //       groupValue: selectedItem,
    //       title: Text(area[i], style: const TextStyle(fontSize: 20.0)),
    //       onChanged: (int? value) {
    //         if (value != null) {
    //           _selectedCity.value = value;
    //         }
    //       },
    //     ),
    //   );
    // }

    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: radioItmes,
    // );

    // 【修正重點 1】：移除外部的 for 迴圈與 radioItmes 陣列。
    // 選單只需要「一個」RadioGroup 包裹整組選項。
    
    return RadioGroup<int>(
      // 【修正重點 2】：根據新版規範，RadioGroup 的狀態屬性通常為 value (對應原本的 groupValue)
      groupValue: selectedItem, 
      onChanged: (int? value) {
        if (value != null) {
          _selectedCity.value = value;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(area.length, (i) {
          // 【修正重點 3】：RadioListTile 僅需保留自己的 value
          return RadioListTile<int>(
            value: i,
            title: Text(
              area[i],
              style: const TextStyle(fontSize: 20),
            ),
          );
        }),
      ),
    );
  }
}
