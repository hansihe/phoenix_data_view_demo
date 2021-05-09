import 'dart:async';

class DiffRender {
  int? rootFragment;
  Map<int, dynamic> fragments = Map();

  dynamic out;

  apply(Map<String, dynamic> patch) {
    var ops = patch["o"] as List<dynamic>;
    for (var dynOp in ops) {
      var op = dynOp as List<dynamic>;
      var type = op[0] as String;
      switch(type) {
        case "s":
          var fragId = op[1] as int;
          fragments[fragId] = op[2];
          break;
        case "f":
          rootFragment = op[1] as int;
          break;
        case "r":
          render();
          break;
      }
    }
  }

  render() {
    out = renderFragment(rootFragment!);
  }

  dynamic renderFragment(int fragId) {
    return renderRec(fragments[fragId]);
  }

  dynamic renderRec(dynamic val) {
    if (val is List<dynamic>) {
      if (val.length > 0) {
        if (val[0] == "\$r") {
          return renderFragment(val[1] as int);
        }
        if (val[0] == "\$e") {
          return val[1];
        }
      }
      return val.map((e) => renderRec(e)).toList();
    }
    if (val is Map<String, dynamic>) {
      return val.map((key, value) => MapEntry(key, renderRec(value)));
    }
    if (val is num) {
      return val;
    }
    if (val is String) {
      return val;
    }
  }

}