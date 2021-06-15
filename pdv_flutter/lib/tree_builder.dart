import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buildTree(Map<String, dynamic> tree) {
  var typ = tree["t"] as String;

  if (typ == "scaffold") {
    return Scaffold(
      appBar: tree.containsKey("app_bar") ? buildTree(tree["app_bar"]) as PreferredSizeWidget : null,
      body: tree.containsKey("body") ? buildTree(tree["body"]) : null,
      floatingActionButton: tree.containsKey("fab") ? buildTree(tree["fab"]) : null,
    );
  }
  if (typ == "app_bar") {
    return AppBar(
      title: tree.containsKey("title") ? buildTree(tree["title"]) : null,
    );
  }
  if (typ == "text") {
    return Text(tree["text"] as String);
  }
  if (typ == "fab") {
    return FloatingActionButton(
      onPressed: () => {},
    );
  }
  if (typ == "list_view") {
    var children = (tree["children"] as List<dynamic>)
        .map((e) => buildTree(e))
        .toList();
    return ListView(
      children: children,
    );
  }
  //if (typ == )

  log(tree.toString());
  throw "unknown tree element";
}