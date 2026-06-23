import 'package:flutter/material.dart';

void main() {
  var appTitle = Text("Hello Flutter Here TitleBar");
  var contentSayHi = Text(
    """
Flutter Hello World ~~!!
Nice To Meet you.
Happy you are.
    """,
    style: TextStyle(fontSize: 30),
  );

  var appBar = AppBar(title: appTitle);
  var appBody = Center(child: contentSayHi);

  var app = MaterialApp(
    home: Scaffold(appBar: appBar, body: appBody),
  );

  runApp(app);
}

/*
MaterialApp
  |__Scaffold
    |__AppBar
      |__title
        |__Text
    |__Body
      |__Center
        |__child
          |__Text
*/
