###  [微信SDK flutter 插件 v1.0.0](https://github.com/waliu/flutter_plugin_wechat_chenyu)

#### 1.申请密钥

    请到微信开放平台 开发者应用登记页面 进行登记，登记并选择移动应用进行设置后，将该应用提交审核，只有审核通过的应用才能进行开发。

#### 2.安装插件(非常重要)

```

flutter pub add flutter_plugin_wechat_chenyu
    
替换 WeChat_APP_ID  
         
在 android\src\main\java\com\jxm\flutter_plugin_wechat_chenyu\Constants.java
         
public static String WeChat_APP_ID = [你得微信ID];
    
```   
#### 3. 基础功能

- [x] 分享
- [x] 支付
- [x] 登录
- [x] 打开小程序

#### 4.dart 使用方法

    //例如：
    FlutterPluginWechatChenyu.share(option);

- FlutterPluginWechatChenyu.share(option);
- FlutterPluginWechatChenyu.sendPaymentRequest(option);
- FlutterPluginWechatChenyu.auth(option);
- FlutterPluginWechatChenyu.openMiniProgram(option);
- FlutterPluginWechatChenyu.onResp(successCallback);

#### 5.参数说明及调用示例
<font color=red>完整的示例代码===></font>
[示例代码](example)

任何方法都会返回一个正确的结果（success）或者一个错误的反馈（PlatformException）
例如:
```dart
try {
   bool success = await FlutterPluginWechatChenyu.share(shareOption);
   print(success);
} on PlatformException catch (e) {
    //破获插件错误信息。
    throw '错误: ${e.message}';
}
```

* 分享方法<br>
  FlutterPluginWechatChenyu.sendPaymentRequest(option)

option

| 参数 | 类型 | 说明 |
| :----:| :----: | :----: |
|message|mediaObject|分享的对象 , 具体请参考 wechat_model.dart 模型类|
|scene|number|分享的场景|
|type|string|分享的类型|

* 支付方法<br>
  FlutterPluginWechatChenyu.share(option)

option

| 参数 | 类型 | 说明 |
| :----:| :----: | :----: |
|partnerId|string|微信支付分配的商户号|
|prepayId|string|微信返回的支付交易会话ID|
|nonceStr|string|随机字符串，不长于32位。推荐随机数生成算法|
|timestamp|string|时间戳，请见接口规则-参数规定|
|packageValue|string|暂填写固定值Sign=WXPay|
|sign|string|签名，详见签名生成算法注意：签名方式一定要与统一下单接口使用的一致|

* 微信登录<br>
  FlutterPluginWechatChenyu.auth(option)

| 参数 | 类型 | 说明 |
| :----:| :----: | :----: |
|scope|string|应用授权作用域，如获取用户个人信息则填写 snsapi_userinfo|
|state|string|用于保持请求和回调的状态，授权请求后原样带回给第三方。该参数可用于防止 csrf 攻击（跨站请求伪造攻击），建议第三方带上该参数，可设置为简单的随机数加 session 进行校验|

* 打开小程序<br>
  FlutterPluginWechatChenyu.openMiniProgram(option);

| 参数 | 类型 | 说明 |
| :----:| :----: | :----: |
|userName|string|填小程序原始id|
|path|string|拉起小程序页面的可带参路径，不填默认拉起小程序首页，对于小游戏，可以只传入 query 部分，来实现传参效果，如：传入 "?foo=bar"。|
|miniprogramType|number|可选打开 开发版，体验版和正式版|

* <font color=red>订阅返回值</font><br>
  FlutterPluginWechatChenyu.onResp((e) => {});<br>
  当你 登录、支付、分享、打开小程序、他都会返回一个值，标记你是否成功操作 FlutterPluginWechatChenyu.onResp(successCallback);

| 参数 | 类型 | 说明 |
| :----:| :----: | :----: |
|successCallback|Function|当调用某个方式时，返回app时就会触发该方法|


#### 6.联系我:

     QQ群 390736068

#### 7.可定制功能

- [x] 图片识别
- [x] 语音识别
- [x] 语音合成
- [x] 微信内网页跳转APP功能（可跳转到指定app界面）


#### 8.常见问题：

* 打开微信会闪一下 并且code提示为-6（分享）或者为-1(支付)，代表签名或者包名有问题。
  - 检查包名是否和微信开放平台一致
  - 检查签名是否和微信开放平台一致






