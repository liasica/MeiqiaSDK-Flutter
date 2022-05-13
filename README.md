# meiqia_sdk_flutter

## 使用美洽

### 1.初始化
``` dart
MQManager.init('appKey',onError: (error){});
```

### 2.启动对话界面
``` dart
MQManager.instance.show();
```

## 常见使用场景

> 开发者的 App 有自己的账号系统，希望每个账号对应不同的顾客，有不同的聊天记录。那就需要开发者在启动对话的时候，绑定账号：
``` dart
MQManager.instance
    ..setCustomizedId("开发者自己系统的用户 id") // 相同的 id 会被识别为同一个顾客
    ..show();
```

> 开发者希望顾客上线的时候，能够上传（或者更新）一些用户的自定义信息：

``` dart
final clientInfo = {
    'name': '富坚义博',
    'avatar': 'https://s3.cn-north-1.amazonaws.com.cn/pics.meiqia.bucket/1dee88eabfbd7bd4',
    'gender': '男',
    'tel': '13888888888',
    '技能1': '休刊'
};
MQManager.instance
    ..setClientInfo(clientInfo, update: false) // 设置顾客信息 PS: 这个接口只会生效一次,如果需要更新顾客信息,需要设置 update = true
    ..show();
// PS: 如果客服在工作台更改了顾客信息，更新顾客信息覆盖之前的内容
```

> 指定客服分配

``` dart
MQManager.instance
    ..setScheduledAgent(agentId) // agentId 可以从工作台查询
    ..show();
```

> 指定客服分组分配

``` dart
MQManager.instance
    ..setScheduledGroup(groupId) // groupId 可以从工作台查询
    ..show();
```

> 设置预发送消息

``` dart
MQManager.instance
    ..setPreSendTextMessage("我是预发送文字消息")
    ..setPreSendProductCardMessage(productCard)
    ..show();
    
// productCard 构造
final productCard = {
    'pictureUrl': 'https://file.pisen.com.cn/QJW3C1000WEB/Product/201701/16305409655404.jpg', // 商品图片的链接
    'title': '商品的标题',
    'description': '商品描述的内容',
    'productUrl': 'https://meiqia.com', // 商品链接
    'salesCount': 50 // 销量
};
```

> 配置聊天页面 UI 样式

``` dart
final style = {
    'navBarBackgroundColor': '#ffffff', // 设置导航栏的背景色
    'navBarTitleTxtColor': '#ffffff', // 设置导航栏上的 title 的颜色
    'enableShowClientAvatar': false', // 是否支持当前用户头像的显示
    'enableSendVoiceMessage': true, // 是否支持发送语音消息
};
MQManager.instance
    ..setStyle(style)
    ..show();
```