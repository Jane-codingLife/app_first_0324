import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class AppBody extends StatefulWidget {
  // StatelessWidget 不會變動的
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  static const _male = "男";
  static const _female = "女";

  final ValueNotifier<int> _selectedGender = ValueNotifier(0);
  final ValueNotifier<int> _age = ValueNotifier(20);
  final ValueNotifier<String> _text = ValueNotifier('');

  static const int _maxAge = 100;
  static const int _minAge = 0;

  @override
  void dispose() {
    _selectedGender.dispose();
    _age.dispose();
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  // 選擇性別
                  const Text("性別：", style: TextStyle(fontSize: 20)),
                  ValueListenableBuilder<int>(
                    valueListenable: _selectedGender,
                    builder: _radioButtonBuilder,
                  ),
                ],
              ),
              Column(
                children: [
                  // 選擇年齡
                  const Text("年齡：", style: TextStyle(fontSize: 20)),
                  ValueListenableBuilder<int>(
                    valueListenable: _age,
                    builder: _agePickerBuilder,
                  ),
                ],
              ),
            ],
          ),

          // 按鈕
          const SizedBox(height: 10),
          ElevatedButton(child: const Text("確定"), onPressed: _showSuggestion),

          // 文字呈現
          const SizedBox(height: 10),
          ValueListenableBuilder(
            valueListenable: _text,
            builder: _textWidgetBuilder,
          ),
        ],
      ),
    );
  }

  // 實作：性別選單
  Widget _radioButtonBuilder(
    BuildContext context,
    int selectedItem,
    Widget? child,
  ) {
    const genders = [_male, _female];

    return Column(
      children: List.generate(genders.length, (i) {
        return Center(
          child: SizedBox(
            width: 200,
            child: RadioListTile<int>(
              value: i,
              groupValue: selectedItem,
              title: Text(genders[i], style: const TextStyle(fontSize: 20)),
              onChanged: (int? value) {
                if (value != null) {
                  _selectedGender.value = value;
                }
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _agePickerBuilder(
    BuildContext context,
    int selectedAge,
    Widget? child,
  ) {
    return NumberPicker(
      minValue: _minAge,
      maxValue: _maxAge,
      value: selectedAge,
      onChanged: (newValue) => _age.value = newValue,
    );
  }

  Widget _textWidgetBuilder(BuildContext context, String text, Widget? child) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight(900),
        color: Colors.white,
      ),
    );
  }

  void _showSuggestion() {
    final gender = _selectedGender.value == 0 ? _male : _female;

    if (gender == _male) {
      if (_age.value <= 18) {
        _text.value = "你太小啦!";
      } else if (_age.value <= 40) {
        _text.value = "適婚年齡!";
      } else {
        _text.value = "快結婚吧!";
      }
    } else {
      if (_age.value <= 18) {
        _text.value = "你太小啦!  小心婚姻!";
      } else if (_age.value <= 40) {
        _text.value = "適婚年齡!  多看看~~";
      } else {
        _text.value = "快結婚吧!  寧缺勿濫!";
      }
    }
  }
}
