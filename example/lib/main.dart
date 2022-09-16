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
    MQManager.instance.show(customizedId: '开发者自己系统的用户 id');
  }

  /// 配置顾客信息
  _setClientInfo() {
    Map<String, String> info = {
      'name': '富坚义博',
      'avatar': 'https://s3.cn-north-1.amazonaws.com.cn/pics.meiqia.bucket/1dee88eabfbd7bd4',
      'gender': '男',
      'tel': '13888888888',
      '技能1': '休刊'
    };
    // 设置顾客信息 PS: 这个接口只会生效一次,如果需要更新顾客信息,需要设置 update = true
    // PS: 如果客服在工作台更改了顾客信息，更新顾客信息覆盖之前的内容
    ClientInfo clientInfo = ClientInfo(info: info, update: false);
    MQManager.instance.show(clientInfo: clientInfo);
  }

  /// 指定客服分配
  _setScheduledAgent() {
    // agentId 可以从工作台查询
    MQManager.instance.show(scheduledAgent: 'agentId');
  }

  /// 指定客服分组分配
  _setScheduledGroup() {
    MQManager.instance.show(scheduledGroup: '客服组的id');
  }

  /// 设置预发送文本消息
  _setPreSendTextMessage() {
    MQManager.instance.show(preSendTextMessage: '预发送的消息内容');
  }

  /// 设置预发送商品卡片消息
  _setPreSendProductCardMessage() {
    // productCard 构造
    ProductCard productCard = ProductCard(
        title: '商品的标题',
        pictureUrl: 'https://file.pisen.com.cn/QJW3C1000WEB/Product/201701/16305409655404.jpg',
        // 商品图片的链接
        description: '商品描述的内容',
        productUrl: 'https://meiqia.com',
        // 商品链接
        salesCount: 50); // 销量
    // 预发送文字消息
    MQManager.instance.show(preSendProductCard: productCard);
  }

  /// 配置聊天页面 UI 样式
  _setStyle() {
    Style style = Style(
      navBarBackgroundColor: '#ffffff', // 设置导航栏的背景色
      navBarTitleTxtColor: '#ffffff', // 设置导航栏上的 title 的颜色
      enableShowClientAvatar: false, // 是否支持当前用户头像的显示
      enableSendVoiceMessage: true, // 是否支持发送语音消息
    );
    MQManager.instance.show(style: style);
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
                onPressed:() => _initState == InitState.fail ? _initMeiqia() : null,
                child: Text(_initState == InitState.success
                    ? '初始化成功'
                    : (_initState == InitState.initing ? '初始化中...' : '初始化'))),
            ElevatedButton(
              onPressed: () => _initState == InitState.success ? _defaultChat() : null,
              child: const Text('咨询客服'),
            ),
          ],
        ),
      ),
    );
  }
}
