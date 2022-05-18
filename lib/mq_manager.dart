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

  setCustomizedId(String customizedId) {
    _channel.invokeMethod('setCustomizedId', {'customizedId': customizedId});
  }

  setClientInfo({required Map<String, dynamic> clientInfo, bool update = false}) {
    _channel.invokeMethod('setClientInfo', {'clientInfo': clientInfo, 'update': update});
  }

  setScheduledAgent(String agentId) {
    _channel.invokeMethod('setScheduledAgent', {'agentId': agentId});
  }

  setScheduledGroup(String groupId) {
    _channel.invokeMethod('setScheduledGroup', {'groupId': groupId});
  }

  setPreSendTextMessage(String text) {
    _channel.invokeMethod('setPreSendTextMessage', {'text': text});
  }

  setPreSendProductCardMessage(ProductCard productCard) {
    _channel.invokeMethod('setPreSendProductCardMessage', {
      'pictureUrl': productCard.pictureUrl,
      'title': productCard.title,
      'description': productCard.description,
      'productUrl': productCard.productUrl,
      'salesCount': productCard.salesCount
    });
  }

  setStyle(Map<String, dynamic> style) {
    _channel.invokeMethod('setStyle', style);
  }
}

class ProductCard {
  String pictureUrl;
  String title;
  String description;
  String productUrl;
  int salesCount;

  ProductCard({
    required this.pictureUrl,
    required this.title,
    required this.description,
    required this.productUrl,
    required this.salesCount,
  });
}
