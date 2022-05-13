import 'dart:async';

import 'package:flutter/services.dart';

class MQManager {
  static final MQManager instance = MQManager._internal();

  MQManager._internal();

  factory MQManager() {
    return instance;
  }

  static const MethodChannel _channel = MethodChannel('meiqia_sdk_flutter');

  static Future<String?> init({required String appKey}) async {
    final String? errorMsg = await _channel.invokeMethod('init', {'appKey': appKey});
    return errorMsg;
  }

  show() {
    _channel.invokeMethod('show');
  }

  setCustomizedId({required String customizedId}) {
    _channel.invokeMethod('setCustomizedId', {'customizedId': customizedId});
  }

  setClientInfo({required clientInfo, bool update = false}) {
    _channel.invokeMethod('setClientInfo', {'clientInfo': clientInfo, 'update': update});
  }

  setScheduledAgent({required agentId}) {
    _channel.invokeMethod('setScheduledAgent', {'agentId': agentId});
  }

  setScheduledGroup({required groupId}) {
    _channel.invokeMethod('setScheduledGroup', {'groupId': groupId});
  }

  setPreSendTextMessage({required text}) {
    _channel.invokeMethod('setPreSendTextMessage', {'text': text});
  }

  setPreSendProductCardMessage({required productCard}) {
    _channel.invokeMethod('setPreSendProductCardMessage', {'productCard': productCard});
  }

  setStyle({required style}) {
    _channel.invokeMethod('setStyle', {'style': style});
  }

}
