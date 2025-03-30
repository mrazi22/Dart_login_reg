import 'package:hive/hive.dart';

part 'users.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  late String uid;
  @HiveField(1)
  String? username;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? password;
  @HiveField(4)
  String? token;


  // UserModel constructor
  UserModel({
    required this.uid,
     this.username,
     this.email,
     this.password,
     this.token,
});
 // Convert a JSON object into an UserModel object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }
  // Convert an UserModel object into a JSON object for posting data to the server
  Map<String, dynamic> toJsonAdd() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'password': password,
      'token': token,
    };

  }
  // Convert an UserModel object into a JSON object
  Map<String, dynamic> toJsonUpdate() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'password': password,
    };
  }


}
//specify hive id for user model 0
//specify hive field for every attribute
// part to create an adapter for the user model
//part "user.g.dart"


//build user model adapter flutter pub run build_runner build
//