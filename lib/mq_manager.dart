import 'dart:async';
import 'dart:convert';

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

  show({
    String? customizedId,
    ClientInfo? clientInfo,
    String? scheduledAgent,
    String? scheduledGroup,
    String? preSendTextMessage,
    ProductCard? preSendProductCard,
    Style? style,
  }) {
    if (customizedId != null) {
      _channel.invokeMethod('setCustomizedId', json.encode({'customizedId': customizedId}));
    }
    if (clientInfo != null) {
      _channel.invokeMethod('setClientInfo',
          json.encode({'clientInfo': clientInfo.info, 'update': clientInfo.update}));
    }
    if (scheduledAgent != null) {
      _channel.invokeMethod('setScheduledAgent', json.encode({'agentId': scheduledAgent}));
    }
    if (scheduledGroup != null) {
      _channel.invokeMethod('setScheduledGroup', json.encode({'groupId': scheduledGroup}));
    }
    if (preSendTextMessage != null) {
      _channel.invokeMethod('setPreSendTextMessage', json.encode({'text': preSendTextMessage}));
    }
    if (preSendProductCard != null) {
      _channel.invokeMethod(
          'setPreSendProductCardMessage', json.encode({'productCard': preSendProductCard}));
    }
    if (style != null) {
      _channel.invokeMethod('setStyle', json.encode({'style': style}));
    }
    _channel.invokeMethod('show');
  }
}

class ClientInfo {
  Map<String, String> info;
  bool update = false;

  ClientInfo({required this.info, this.update = false});
}

class ProductCard {
  String title;
  String pictureUrl;
  String description;
  String productUrl;
  String salesCount;

  ProductCard(
      {required this.title,
      required this.pictureUrl,
      required this.description,
      required this.productUrl,
      required this.salesCount});
}

class Style {
  String? navBarBackgroundColor;
  String? navBarTitleTxtColor;
  bool enableShowClientAvatar;
  bool enableSendVoiceMessage;

  Style(
      {this.navBarBackgroundColor,
      this.navBarTitleTxtColor,
      this.enableShowClientAvatar = false,
      this.enableSendVoiceMessage = true});
}
