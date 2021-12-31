class ShareOption {
  Message message;
  int scene;
  String type;

  ShareOption(this.message, this.scene, this.type);

  fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? message.fromJson(json['message']) : null;
    scene = json['scene'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message.toJson();
    }
    data['scene'] = this.scene;
    data['type'] = this.type;
    return data;
  }
}

class Message {
  //标题
  String title = "";
  //描述
  String description = "";
  //缩略图
  String thumbURL = "";
  //分享对象
  late MediaObject mediaObject;

  fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    thumbURL = json['thumbURL'];
    mediaObject =
        json['mediaObject'] != null ? fromJson(json['mediaObject']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (title!="") {
    //   data['title'] = this.title;
    // }
    // if (description!="") {
    //   data['description'] = this.description;
    // }
    // if (description!="") {
    //   data['thumbURL'] = this.thumbURL;
    // }
    data['title'] = this.title;
    data['description'] = this.description;
    data['thumbURL'] = this.thumbURL;

    if (this.mediaObject != null) {
      data['mediaObject'] = this.mediaObject.toJson();
    }
    return data;
  }
}

abstract class MediaObject {
  Map<String, dynamic> toJson();
}

class WXTextMediaObject extends MediaObject {
  String text;

  WXTextMediaObject(this.text);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }

  fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }
}

class WXImageObject extends MediaObject {
  String imagePath;

  WXImageObject(this.imagePath);

  fromJson(Map<String, dynamic> json) {
    imagePath = json['imagePath'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagePath'] = this.imagePath;
    return data;
  }
}

class WXMusicObject extends MediaObject {
  String musicUrl;

  WXMusicObject(this.musicUrl);

  fromJson(Map<String, dynamic> json) {
    musicUrl = json['musicUrl'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['musicUrl'] = this.musicUrl;
    return data;
  }
}

class WXVideoObject extends MediaObject {
  String videoUrl;

  WXVideoObject(this.videoUrl);

  fromJson(Map<String, dynamic> json) {
    videoUrl = json['videoUrl'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoUrl'] = this.videoUrl;
    return data;
  }
}

class WXWebPageObject extends MediaObject{
  String webpageUrl;

  WXWebPageObject(this.webpageUrl);

  fromJson(Map<String, dynamic> json) {
    webpageUrl = json['webpageUrl'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['webpageUrl'] = this.webpageUrl;
    return data;
  }
}


class PaymentRequestOption {
  late String partnerId;
  late String prepayId;
  late String nonceStr;
  late String timestamp;
  late String packageValue;
  late String sign;

  fromJson(Map<String, dynamic> json) {
    partnerId = json['partnerId'];
    prepayId = json['prepayId'];
    nonceStr = json['nonceStr'];
    timestamp = json['timestamp'];
    packageValue = json['packageValue'];
    sign = json['sign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partnerId'] = this.partnerId;
    data['prepayId'] = this.prepayId;
    data['nonceStr'] = this.nonceStr;
    data['timestamp'] = this.timestamp;
    data['packageValue'] = this.packageValue;
    data['sign'] = this.sign;
    return data;
  }
}

class AuthOption {
  String scope;
  String state;

  AuthOption(this.scope, this.state);

  fromJson(Map<String, dynamic> json) {
    scope = json['scope'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scope'] = this.scope;
    data['state'] = this.state;
    return data;
  }
}

class OpenMiniProgramOption {
  String userName;
  String path;
  int miniprogramType;

  OpenMiniProgramOption(this.userName, this.path, this.miniprogramType);

  fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    path = json['path'];
    miniprogramType = json['miniprogramType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['path'] = this.path;
    data['miniprogramType'] = this.miniprogramType;
    return data;
  }
}




