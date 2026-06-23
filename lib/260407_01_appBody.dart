import 'package:flutter/material.dart';

class AppBody extends StatelessWidget {
  // StatelessWidget 不會變動的
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(heightFactor: 2.0, child: _DropdownWidget());
  }
}

class _DropdownWidget extends StatefulWidget {
  // StatefulWidget 可變動的
  const _DropdownWidget();

  @override
  State<_DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<_DropdownWidget> {
  int? selectedValue; // 加入?代表可以放 None(空值)

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      hint: const Text("請選擇", style: TextStyle(fontSize: 20)),

      value: selectedValue,

      items: const <DropdownMenuItem<int>>[
        DropdownMenuItem<int>(
          value: 1,
          child: Text("水果種類", style: TextStyle(fontSize: 20)),
        ),
        DropdownMenuItem<int>(
          value: 2,
          child: Text("蔬菜種類", style: TextStyle(fontSize: 20)),
        ),
        DropdownMenuItem<int>(
          value: 3,
          child: Text("3C種類", style: TextStyle(fontSize: 20)),
        ),
        DropdownMenuItem<int>(
          value: 4,
          child: Text("五金種類", style: TextStyle(fontSize: 20)),
        ),
        DropdownMenuItem<int>(
          value: 6,
          child: Text("花草種類", style: TextStyle(fontSize: 20)),
        ),
        DropdownMenuItem<int>(
          value: 7,
          child: Text("大型家電家具種類", style: TextStyle(fontSize: 20)),
        ),
      ],

      onChanged: (int? value) {
        setState(() {
          selectedValue = value;
        });
      },
    );
  }
}
