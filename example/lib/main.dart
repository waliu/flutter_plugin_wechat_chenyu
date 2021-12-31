import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_plugin_wechat_chenyu/flutter_plugin_wechat_chenyu.dart';
import 'package:flutter_plugin_wechat_chenyu/wechat_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await FlutterPluginWechatChenyu.platformVersion ??
          'Unknown platform version';
      FlutterPluginWechatChenyu.onResp((call) => onResp(call));
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ListView(padding: EdgeInsets.all(8.0), children: <Widget>[
            Text('Running on: $_platformVersion\n'),
            ElevatedButton(
              child: const Text(
                '分享文字',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: shareText,
            ),
            ElevatedButton(
              child: const Text(
                '分享图片',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: shareImg,
            ),
            ElevatedButton(
              child: const Text(
                '分享音乐',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: shareMusic,
            ),
            ElevatedButton(
              child: const Text(
                '分享视频',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: shareVideo,
            ),
            ElevatedButton(
              child: const Text(
                '分享网页',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: shareWebpage,
            ),
            ElevatedButton(
              child: const Text(
                '支付',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: sendPaymentRequest,
            ),
            ElevatedButton(
              child: const Text(
                '登录',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: auth,
            ),
            ElevatedButton(
              child: const Text(
                '打开小程序',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: openMiniProgram,
            ),
          ])),
    );
  }

  Future<dynamic> onResp(dynamic a) async {
    // 再次监听微信返回值
    print(a);
  }

  Future<void> shareText() async {
    MediaObject wxTextObject = WXTextMediaObject("测试文字");
    Message message = Message();
    message.mediaObject = wxTextObject;
    ShareOption shareOption = ShareOption(message, 0, "text");
    try {
      bool success = await FlutterPluginWechatChenyu.share(shareOption);
      print(success);
    } on PlatformException catch (e) {
      throw '错误: ${e.message}';
    }
  }

  void error(Object error, StackTrace stackTrace) {}

  Future<void> shareImg() async {
    MediaObject wxTextObject = WXImageObject(
        "https://img0.baidu.com/it/u=3436810468,4123553368&fm=26&fmt=auto");
    Message message = Message();
    message.thumbURL =
        "https://img0.baidu.com/it/u=3436810468,4123553368&fm=26&fmt=auto";
    message.mediaObject = wxTextObject;
    ShareOption shareOption = ShareOption(message, 0, "img");
    try {
      bool success = await FlutterPluginWechatChenyu.share(shareOption);
      print(success);
    } on PlatformException catch (e) {
      throw '错误: ${e.message}';
    }
  }

  Future<void> shareMusic() async {
    MediaObject wxTextObject = WXMusicObject(
        "https://el-sycdn.kuwo.cn/3999d8ffb2687b7819e4bd138036bba3/619f300e/resource/n2/40/71/3964435247.mp3");
    Message message = Message();
    message.title = "处处吻";
    message.description = "description";
    message.thumbURL =
        "https://img0.baidu.com/it/u=3436810468,4123553368&fm=26&fmt=auto";
    message.mediaObject = wxTextObject;
    ShareOption shareOption = ShareOption(message, 0, "music");
    try {
      bool success = await FlutterPluginWechatChenyu.share(shareOption);
      print(success);
    } on PlatformException catch (e) {
      throw '错误: ${e.message}';
    }
  }

  Future<void> shareVideo() async {
    MediaObject wxTextObject = WXVideoObject(
        "https://vd4.bdstatic.com/mda-kbic5h12n3ivuuhk/hd/mda-kbic5h12n3ivuuhk.mp4?v_from_s=hkapp-haokan-suzhou&auth_key=1637054891-0-0-86bc1255af6737160702a2846b0c26a8&bcevod_channel=searchbox_feed&pd=1&pt=3&abtest=3000187_1&klogid=3491684487");
    Message message = Message();
    message.title = "处处吻";
    message.description = "description";
    message.thumbURL =
        "https://img0.baidu.com/it/u=3436810468,4123553368&fm=26&fmt=auto";
    message.mediaObject = wxTextObject;
    ShareOption shareOption = ShareOption(message, 0, "video");
    try {
      bool success = await FlutterPluginWechatChenyu.share(shareOption);
      print(success);
    } on PlatformException catch (e) {
      throw '错误: ${e.message}';
    }
  }

  Future<void> shareWebpage() async {
    MediaObject wxTextObject = WXWebPageObject("https://www.baidu.com/");
    Message message = Message();
    message.title = "百度";
    message.description =
        "百度是拥有强大互联网基础的领先AI公司。百度愿景是：成为最懂用户，并能帮助人们成长的全球顶级高科技公司。";
    message.thumbURL =
        "https://www.baidu.com/img/flexible/logo/pc/peak-result.png";
    message.mediaObject = wxTextObject;
    ShareOption shareOption = ShareOption(message, 0, "webpage");
    try {
      bool success = await FlutterPluginWechatChenyu.share(shareOption);
      print(success);
    } on PlatformException catch (e) {
      throw '错误: ${e.message}';
    }
  }

  Future<void> sendPaymentRequest() async {
    PaymentRequestOption paymentRequestOption = PaymentRequestOption();
    paymentRequestOption.partnerId = "1601185215";
    paymentRequestOption.prepayId = "up_wx17170930904580a8e12533ee7eeda90000";
    paymentRequestOption.nonceStr = "SzcHvmcdY8NLA7bWVNxNzgcH745WV83B";
    paymentRequestOption.timestamp = "1637140170";
    paymentRequestOption.packageValue = "Sign=WXPay";
    paymentRequestOption.sign =
        "E/nz0ldrpXdvDq8RrAH7gyHNT/4vrZnKn+td1j8lzke7gVxOcE8cSRo5y8akoQoT4wmvAoab2tljDnkFrobLGSLrXd6ftqn+mNb26FRxlEicFvyM9lZaUxXzaqPoyd7q6g1Hl4fFQy/Nkg7TZxT6UUwp4z2OokcGYaU5tsI/3PzliIcQJyd0xgPp9OZhRc+/LSVeT5o0pdaYGBbCmQTG06EH7gOAabpaIkEDzhOwlJ3wrP1j84iiHWJ6AVzQzxAFOlxGA4OwqHkrVdRogfUY48qAWsR7T8zWtdXCZ48sDMlK5soZTirpu8ftrGGdI0hmbXHOb2OkGPQX0fLHqFzJig==";
    try {
      bool success = await FlutterPluginWechatChenyu.sendPaymentRequest(
          paymentRequestOption);
      print(success);
    } on PlatformException catch (e) {
      throw '错误: ${e.message}';
    }
  }

  Future<void> auth() async {
    AuthOption authOption = AuthOption("snsapi_userinfo", "1640828481267");
    try {
      bool success = await FlutterPluginWechatChenyu.auth(authOption);
      print(success);
    } on PlatformException catch (e) {
      throw '错误: ${e.message}';
    }
  }

  Future<void> openMiniProgram() async {
    OpenMiniProgramOption openMiniProgramOption = OpenMiniProgramOption("gh_f01f85672b87", "",0);
    try {
      bool success = await FlutterPluginWechatChenyu.openMiniProgram(openMiniProgramOption);
      print(success);
    } on PlatformException catch (e) {
      throw '错误: ${e.message}';
    }
  }
}
