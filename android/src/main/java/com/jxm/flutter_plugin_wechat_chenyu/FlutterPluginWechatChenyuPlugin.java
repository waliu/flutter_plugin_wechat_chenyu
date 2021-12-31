package com.jxm.flutter_plugin_wechat_chenyu;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Objects;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import static com.jxm.flutter_plugin_wechat_chenyu.Constants.WeChat_APP_ID;

/**
 * FlutterPluginWechatChenyuPlugin
 */
public class FlutterPluginWechatChenyuPlugin implements FlutterPlugin, ActivityAware, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    //Flutter Activity
    private Activity activity;
    //标识符
    private static final String TAG = "Plugin.WeChat";
    // IWXAPI 是第三方app和微信通信的openApi接口
    public static IWXAPI api;
    // 分享对象
    private Share share;
    //支付
    private Pay pay;
    //小程序类
    private MiniProgram miniProgram;
    // 认证类
    public AuthRequest authRequest;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_plugin_wechat_chenyu");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        isWXAppInstalled(result);
        try {
            if (call.method.equals("getPlatformVersion")) {
                result.success("Android " + android.os.Build.VERSION.RELEASE);
                return;
            }
            if (call.method.equals("share")) {
                this.threadShare(call, result);
                return;
            }
            if (call.method.equals("auth")) {
                this.auth(call.arguments);
                result.success(Constants.success);
                return;
            }

            if (call.method.equals("sendPaymentRequest")) {
                this.sendPaymentRequest(call.arguments);
                result.success(Constants.success);
                return;
            }

            if (call.method.equals("openMiniProgram")) {
                this.openMiniProgram(call.arguments);
                result.success(Constants.success);
                return;
            }
            result.notImplemented();
        } catch (JSONException e) {
            result.error("500", Constants.Error501, e.getMessage());
        } catch (RuntimeException e) {
            result.error("500", e.getMessage(), e.getMessage());
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }


    private void isWXAppInstalled(@NonNull Result result)  {
        if (!api.isWXAppInstalled()) {
            result.error("500", Constants.Error500, Constants.Error500);
            throw new RuntimeException(Constants.Error500);
        }
    }
    private void threadShare(@NonNull MethodCall call, @NonNull Result result) {
        new Thread() {
            public void run() {
                try {
                    FlutterPluginWechatChenyuPlugin.this.share(call.arguments);
                    result.success(Constants.success);
                } catch (JSONException e) {
                    result.error("500", Constants.Error501, e.getMessage());
                } catch (RuntimeException e) {
                    result.error("500", e.getMessage(), e.getMessage());
                }
            }
        }.start();
    }

    private void share(Object arguments) throws JSONException, RuntimeException {
        JSONObject options = new JSONObject(arguments.toString());
        //获取参数
        JSONObject message = options.getJSONObject("message");
        JSONObject mediaObject = message.getJSONObject("mediaObject");

        switch (options.getString("type")) {
            case "text":
                share.shareText(options, message, mediaObject);
                break;
            case "img":
                share.shareImg(options, message, mediaObject);
                break;
            case "music":
                share.shareMusic(options, message, mediaObject);
                break;
            case "video":
                share.shareVideo(options, message, mediaObject);
                break;
            case "webpage":
                share.shareWebpage(options, message, mediaObject);
                break;
            default:
                throw new RuntimeException(Constants.Error501);
        }
    }

    private void auth(Object arguments) throws JSONException {
        JSONObject options = new JSONObject(arguments.toString());
        //获取参数
        // send oauth request
        authRequest.auth(options);
    }

    private void sendPaymentRequest(Object arguments) throws JSONException {
        JSONObject options = new JSONObject(arguments.toString());
        //支付
        pay.sendPaymentRequest(options, WeChat_APP_ID);
    }

    private void openMiniProgram(Object arguments) throws JSONException, RuntimeException {
        JSONObject options = new JSONObject(arguments.toString());
        miniProgram.openMiniProgram(options);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activity = binding.getActivity();

        api = WXAPIFactory.createWXAPI(activity, WeChat_APP_ID, false);
        // 将应用的appId注册到微信
        api.registerApp(WeChat_APP_ID);
        //创建分享对象
        share = new Share(api);
        //支付对象
        pay = new Pay(api);
        //小程序类
        miniProgram = new MiniProgram(api);
        //认证类
        authRequest = new AuthRequest(api);

        //初始化监听类
        IntentFilter intentFilter = new IntentFilter();
        //这个ACTION和后面activity的ACTION一样就行，要不然收不到的
        intentFilter.addAction(TAG);
        //创建监听类
        activity.registerReceiver(myBroadcastReceive, intentFilter);

    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        this.onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        this.onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        activity = null;
    }


    BroadcastReceiver myBroadcastReceive = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            JSONObject jsonObject = new JSONObject();

            try {
                jsonObject.put("type", intent.getIntExtra("type", 500));
                jsonObject.put("errCode", intent.getIntExtra("errCode", 500));
                jsonObject.put("errStr", intent.getStringExtra("errStr"));
                jsonObject.put("transaction", intent.getStringExtra("transaction"));
                jsonObject.put("openId", intent.getStringExtra("openId"));
                jsonObject.put("pluginType", intent.getStringExtra("pluginType"));

                switch (Objects.requireNonNull(intent.getStringExtra("pluginType"))) {
                    case "Auth":
                        jsonObject.put("code", intent.getStringExtra("code"));
                        jsonObject.put("state", intent.getStringExtra("state"));
                        jsonObject.put("authResult", intent.getBooleanExtra("authResult", false));
                        jsonObject.put("url", intent.getStringExtra("url"));
                        jsonObject.put("lang", intent.getStringExtra("lang"));
                        jsonObject.put("country", intent.getStringExtra("country"));
                        break;
                    case "WXLaunchMiniProgram":
                        jsonObject.put("extraData", intent.getStringExtra("extraData"));
                        break;
                    case "Pay":
                        break;
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }

            channel.invokeMethod("onResp", jsonObject.toString(), new Result() {
                @Override
                public void success(@Nullable Object result) {
                    Log.i("debug", result.toString());
                }

                @Override
                public void error(String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) {

                }

                @Override
                public void notImplemented() {

                }
            });
        }
    };


}
