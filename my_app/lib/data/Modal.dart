import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/bmob/type/bmob_date.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';

class AuthState {
  bool isLogin;
  User userInfo;

  AuthState({this.isLogin: false, this.userInfo});
}

class User extends BmobUser {
  String address;
  BmobFile profileHead;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// ignore: camel_case_types
class order extends BmobObject {
  String contactInfo;
  String expressName;
  String expressPhone;
  String expressCode;
  String address;
  String size;
  String remarks;
  String userId;
  String status;
  BmobDate appointedTime;
  bool appointed;

  order();

  factory order.fromJson(Map<String, dynamic> json) => _$orderFromJson(json);

  Map<String, dynamic> toJson() => _$orderToJson(this);

  @override
  Map getParams() {
    Map<String, dynamic> map = toJson();
    Map<String, dynamic> data = Map();
    map.forEach((key, value) {
      if (value != null) {
        data[key] = value;
      }
    });
    return map;
  }
}

// ignore: camel_case_types
class bulletinBoard extends BmobObject {
  String title;
  String announcer;
  String content;

  bulletinBoard();

  factory bulletinBoard.fromJson(Map<String, dynamic> json) =>
      _$bulletinBoardFromJson(json);

  Map<String, dynamic> toJson() => _$bulletinBoardToJson(this);

  @override
  Map getParams() {
    Map<String, dynamic> map = toJson();
    Map<String, dynamic> data = Map();
    map.forEach((key, value) {
      if (value != null) {
        data[key] = value;
      }
    });
    return map;
  }
}

bulletinBoard _$bulletinBoardFromJson(Map<String, dynamic> json) {
  return bulletinBoard()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..title = json['title'] as String
    ..announcer = json['announcer'] as String
    ..content = json['content'] as String;
}

Map<String, dynamic> _$bulletinBoardToJson(bulletinBoard instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'title': instance.title,
      'announcer': instance.announcer,
      'content': instance.content,
    };

order _$orderFromJson(Map<String, dynamic> json) {
  return order()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..contactInfo = json['contactInfo'] as String
    ..expressName = json['expressName'] as String
    ..expressPhone = json['expressPhone'] as String
    ..expressCode = json['expressCode'] as String
    ..address = json['address'] as String
    ..size = json['size'] as String
    ..remarks = json['remarks'] as String
    ..userId = json['userId'] as String
    ..status = json['status'] as String
    ..appointedTime = json['appointedTime'] as BmobDate
    ..appointed = json['appointed'] as bool;
}

Map<String, dynamic> _$orderToJson(order instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'contactInfo': instance.contactInfo,
      'expressName': instance.expressName,
      'expressPhone': instance.expressPhone,
      'expressCode': instance.expressCode,
      'address': instance.address,
      'size': instance.size,
      'remarks': instance.remarks,
      'userId': instance.userId,
      'status': instance.status,
      'appointedTime': instance.appointedTime,
      'appointed': instance.appointed,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..username = json['username'] as String
    ..password = json['password'] as String
    ..email = json['email'] as String
    ..emailVerified = json['emailVerified'] as bool
    ..mobilePhoneNumber = json['mobilePhoneNumber'] as String
    ..mobilePhoneNumberVerified = json['mobilePhoneNumberVerified'] as bool
    ..sessionToken = json['sessionToken'] as String
    ..address = json['address'] as String
    ..profileHead = json['profileHead'] as BmobFile;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'mobilePhoneNumber': instance.mobilePhoneNumber,
      'mobilePhoneNumberVerified': instance.mobilePhoneNumberVerified,
      'sessionToken': instance.sessionToken,
      'address': instance.address,
      'profileHead': instance.profileHead
    };
