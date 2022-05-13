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
    String? errorMsg = await MQManager.init(appKey: "a71c257c80dfe883d92a64dca323ec20");
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
                onPressed: _initState == InitState.fail ? _initMeiqia : null,
                child: Text(_initState == InitState.success
                    ? '初始化成功'
                    : (_initState == InitState.initing ? '初始化中...' : '初始化'))),
            ElevatedButton(
              onPressed: _initState == InitState.success ? () => MQManager.instance.show() : null,
              child: const Text('咨询客服'),
            ),
          ],
        ),
      ),
    );
  }
}
