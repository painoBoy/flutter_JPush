import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'dart:async';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String debugLable = 'UnKnown';
  final JPush jpush = new JPush();

  @override
  void initState() {
    super.initState();
  }


  Future<void> initPlateformState() async {
    String plateformVersion;
    try {
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print("Flutter 接受到推送${message}");
        setState(() {
          debugLable = "接受到推送${message}";
        });
      });
    } on PlatformException {
      plateformVersion = '平台版本获取失败,请检查';
    }

    if(!mounted) return ;
    setState(() {
     debugLable = plateformVersion; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('结果${debugLable}'),
              FlatButton(
                child: Text("发送推送信息"),
                onPressed: (){
                  print("object");
                  var fireDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch+3000);
                  var localNotification = LocalNotification(
                    id:104,
                    title: 'Flutter 今晚九点半更新6',
                    buildId: 1,
                    content: '入手Flutter 让你跨平台开发Android和IOS两不误呀',
                    fireTime: fireDate,
                    subtitle: '测试'
                  );
                  jpush.sendLocalNotification(localNotification).then((res){
                     setState(() {
                      debugLable = res; 
                     });
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
