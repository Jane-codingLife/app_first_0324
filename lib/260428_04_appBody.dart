import 'package:flutter/material.dart';

class AppBody extends StatefulWidget {
  // StatelessWidget 不會變動的
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  static const _hobbies = <String>[
    "游泳",
    "唱歌",
    "聽音樂",
    "騎單車",
    "旅遊",
    "美食",
    "運動",
    "籃球",
    "跳舞",
    "閱讀",
    "寫作",
    "棒球",
  ];

  final ValueNotifier<List<bool>> _hobbiesSelected = ValueNotifier(
    List<bool>.generate(_hobbies.length, (_) => false),
  );

  final ValueNotifier<String> _text = ValueNotifier('');

  @override
  void dispose() {
    _hobbiesSelected.dispose();
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 250,
              child: ValueListenableBuilder<List<bool>>(
                valueListenable: _hobbiesSelected,
                builder: _hobbySelectionBuilder,
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(onPressed: _showHobbies, child: const Text("確定")),

            const SizedBox(height: 10),
            ValueListenableBuilder<String>(
              valueListenable: _text,
              builder: _textWidgetBuilder,
            ),
          ],
        ),
      ),
    );
  }

  Widget _hobbySelectionBuilder(
    BuildContext context,
    List<bool> hobbiesSelected,
    Widget? child,
  ) {
    return Column(
      children: List.generate(_hobbies.length, (i) {
        return Center(
          child: SizedBox(
            width: 250,
            child: CheckboxListTile(
              title: Text(_hobbies[i], style: const TextStyle(fontSize: 20)),
              value: hobbiesSelected[i],
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? newValue) {
                if (newValue != null) {
                  final newList = List<bool>.from(hobbiesSelected);
                  newList[i] = newValue;
                  _hobbiesSelected.value = newList;
                }
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _textWidgetBuilder(BuildContext context, String text, Widget? child) {
    return Text(text, style: const TextStyle(fontSize: 20));
  }

  void _showHobbies() {
    final selected = <String>[];
    for (int i = 0; i < _hobbies.length; i++) {
      if (_hobbiesSelected.value[i]) {
        selected.add(_hobbies[i]);
      }
    }
    _text.value = selected.join("、");
  }
}
