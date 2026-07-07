import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'locale/app_localizations_delegate.dart';
import 'locale/language.dart';

void main() {
  runApp(const MyApp());
}

// StatelessWidget 不會變更的 UI
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [
        Locale('en'),
        // 中文語系不能簡寫，要用設定檔方式填入語系、地區
        Locale.fromSubtags(
          languageCode: 'zh',
          scriptCode: 'Hant',
          countryCode: 'TW',
        ),
      ],

      onGenerateTitle: (context) => Language.of(context)!.appTitle,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),

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
  final ValueNotifier<String> _selectedItem = ValueNotifier<String>('');

  static const List<String> _icons = [
    'assets/4.png',
    'assets/5.png',
    'assets/6.png',
  ];

  @override
  void dispose() {
    super.dispose();
    _selectedItem.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final language = Language.of(context)!;

    final items = <String>[language.item1, language.item2, language.item3];

    final appBar = AppBar(title: Text(language.appTitle));

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            ValueListenableBuilder<String>(
              valueListenable: _selectedItem,
              builder: (context, selectedItem, child) {
                return Text(selectedItem, style: const TextStyle(fontSize: 20));
              },
            ),
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 5,
                      ),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(_icons[index]),
                      ),
                    ),
                    title: Text(
                      items[index],
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      language.itemDescription,
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      _selectedItem.value = '${language.select}${items[index]}';
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
