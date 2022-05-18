import 'package:flutter/material.dart';
import 'package:meiqia_sdk_flutter/mq_manager.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

enum InitState {
  initing,
  success,
  fail,
}

class _MyAppState extends State<MyApp> {
  late InitState _initState;

  @override
  void initState() {
    super.initState();
    _initMeiqia();
  }

  _initMeiqia() async {
    _initState = InitState.initing;
    String? errorMsg = await MQManager.init(appKey: "开发者的appkey");
    setState(() {
      if (errorMsg == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('初始化成功'),
        ));
        _initState = InitState.success;
      } else {
        _initState = InitState.fail;
      }
    });
  }

  /// 默认界面
  _defaultChat() {
    MQManager.instance.show();
  }

  /// 配置定义用户id
  _setCustomizedId() {
    MQManager.instance
      ..setCustomizedId("开发者自己系统的用户 id")
      ..show();
  }

  /// 配置顾客信息
  _setClientInfo() {
    MQManager.instance
      ..setClientInfo(clientInfo: {
        'name': '富坚义博',
        'avatar': 'https://s3.cn-north-1.amazonaws.com.cn/pics.meiqia.bucket/1dee88eabfbd7bd4',
        'gender': '男',
        'tel': '13888888888',
        '技能1': '休刊'
      }, update: true)
      ..show();
  }

  /// 指定客服分配
  _setScheduledAgent() {
    MQManager.instance
      ..setScheduledAgent("客服的id")
      ..show();
  }

  /// 指定客服分组分配
  _setScheduledGroup() {
    MQManager.instance
      ..setScheduledGroup("客服组的id")
      ..show();
  }

  /// 设置预发送文本消息
  _setPreSendTextMessage() {
    MQManager.instance
      ..setPreSendTextMessage("123")
      ..show();
  }

  /// 设置预发送商品卡片消息
  _setPreSendProductCardMessage() {
    ProductCard productCard = ProductCard(
        pictureUrl: "https://file.pisen.com.cn/QJW3C1000WEB/Product/201701/16305409655404.jpg",
        title: '商品的标题',
        description: '商品描述的内容',
        productUrl: 'https://meiqia.com',
        salesCount: 50);
    MQManager.instance
      ..setPreSendProductCardMessage(productCard)
      ..show();
  }

  /// 指定客服分组分配
  _setStyle() {
    MQManager.instance
      ..setStyle({
        'navBarBackgroundColor': '#ffffff', // 设置导航栏的背景色
        'navBarTitleTxtColor': '#ffffff', // 设置导航栏上的 title 的颜色
        'enableShowClientAvatar': false, // 是否支持当前用户头像的显示
        'enableSendVoiceMessage': true, // 是否支持发送语音消息
      })
      ..show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 80, height: 80, child: Image.asset('assets/images/logo.png')),
            const SizedBox(height: 80),
            ElevatedButton(
                onPressed: _initState == InitState.fail ? _initMeiqia() : null,
                child: Text(
                    _initState == InitState.success ? '初始化成功' : (_initState == InitState.initing ? '初始化中...' : '初始化'))),
            ElevatedButton(
              onPressed: _initState == InitState.success ? () => _defaultChat() : null,
              child: const Text('咨询客服'),
            ),
          ],
        ),
      ),
    );
  }
}
