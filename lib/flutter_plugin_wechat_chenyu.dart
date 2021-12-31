import 'dart:async';
import "dart:convert";
import 'package:flutter/services.dart';
import 'package:flutter_plugin_wechat_chenyu/wechat_model.dart';

class FlutterPluginWechatChenyu {
  static const MethodChannel _channel =
      MethodChannel('flutter_plugin_wechat_chenyu');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 分享
  /// @param ShareOption
  /// @version 1.0.0
  static Future<dynamic> share(ShareOption shareOption) async {
    return await _channel.invokeMethod(
        'share', jsonEncode(shareOption.toJson()));
  }

  /// 登录
  /// @param ShareOption
  /// @version 1.0.0
  static Future<dynamic> auth(AuthOption authOption) async {
    return await _channel.invokeMethod('auth', jsonEncode(authOption.toJson()));
  }

  /// 支付
  /// @param ShareOption
  /// @version 1.0.0
  static Future<dynamic> sendPaymentRequest(
      PaymentRequestOption paymentRequestOption) async {
    return await _channel.invokeMethod(
        'sendPaymentRequest', jsonEncode(paymentRequestOption.toJson()));
  }

  ///
  /// 打开小程序
  /// @param OpenMiniProgramOption
  /// @version 1.0.0
  static Future<dynamic> openMiniProgram(OpenMiniProgramOption openMiniProgramOption) async {
    return await _channel.invokeMethod(
        'openMiniProgram', jsonEncode(openMiniProgramOption.toJson()));
  }

  ///
  /// 订阅 微信返回值
  /// @param Function
  /// @version 1.0.0
  static Future<void> onResp(
      Future<dynamic> Function(dynamic call) handler) async {
    _channel.setMethodCallHandler((call) => platformCallHandler(call, handler));
  }

  static Future<dynamic> platformCallHandler(
      MethodCall call, Future<dynamic> Function(dynamic call) handler) async {
    switch (call.method) {
      case "onResp":
        handler(call.arguments);
        return "flutter success";
      case "getWeChatAPPID":
        return "wxbca52269ba0f270b";
    }
  }
}
