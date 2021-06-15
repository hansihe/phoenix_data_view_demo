import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pdv_flutter/data_view.dart';
import 'package:pdv_flutter/tree_builder.dart';

void main() {
  var service = DataViewSocketService("ws://localhost:4000/data/websocket");
  runApp(DataViewSocket(
      service: service,
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState2 createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage> {
  int _counter = 0;

  DataView? _view;
  Map<String, dynamic>? _data;

  @override
  void didChangeDependencies() {
    _view = DataViewSocketService.of(context).open("/flutter_view_demo", {});

    _view!.data.listen((data) {
      setState(() {
        _data = data as Map<String, dynamic>;
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    log(_data.toString());

    if (_data == null) {
      return Center(child: Text("Loading..."));
    } else {
      return buildTree(_data!);
    }
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  DataView? _view;
  Map<String, dynamic>? _data;

  @override
  void didChangeDependencies() {
    log("yay didChangeDependencies");

    _view = DataViewSocketService.of(context).open("/hello_world", {});

    _view!.data.listen((data) {
      setState(() {
        _data = data as Map<String, dynamic>;
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    log(_data.toString());

    var posts = (_data?["categories"] as List<dynamic>? ?? [])
        .expand((e) => e["posts"]!)
        .map((e) => ListTile(title: Text(e["title"]!),))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
          children: posts,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          _view!.event({"e": "add_post"})
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
