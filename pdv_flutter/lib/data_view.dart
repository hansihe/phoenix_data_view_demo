import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:pdv_flutter/diff_render.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:async/async.dart';

class DataViewSocket extends InheritedWidget {
  final DataViewSocketService service;

  DataViewSocket({Key? key, required this.service, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant DataViewSocket old) {
    if (service != old.service) {
      throw Exception("Services must be constant!");
    }

    return false;
  }
}

class DataViewSocketService {
  bool connected = false;
  late Stream connectedStream;

  late PhoenixSocket socket;

  int channelCounter = 0;

  DataViewSocketService(String endpoint) {
    socket = PhoenixSocket(endpoint);

    connectedStream = StreamGroup.merge([
      socket.closeStream.map((_) => false),
      socket.openStream.map((_) => true)
    ]).asBroadcastStream();

    connectedStream.listen((state) {
      connected = state;
    });

    socket.connect();
  }

  DataView open(String route, dynamic params) {
    String topic = "dv:c:$channelCounter";
    channelCounter += 1;

    return DataView(this, topic, route, params);
  }

  static DataViewSocketService of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataViewSocket>()!.service;
  }
}

class DataView {
  final DataViewSocketService service;

  final String _topic;
  final String _route;
  final dynamic _params;

  late final PhoenixChannel _channel;

  late final Stream data;

  DiffRender diffRender = DiffRender();

  DataView(this.service, this._topic, this._route, this._params) {
    _channel = service.socket.addChannel(topic: _topic, parameters: {
      "r": [_route, _params]
    });

    var controller = StreamController();
    data = controller.stream;

    _channel.messages.listen((event) {
      log("$event");
      if (event.event.value == "f") {
        // controller.add(event.payload);
      } else if (event.event.value == "o") {
        diffRender.apply(event.payload!);
        controller.add(diffRender.out);
      }
    });

    _channel.join();
  }

  event(dynamic data) {
    _channel.push("e", {
      "d": data,
    });
  }
}
