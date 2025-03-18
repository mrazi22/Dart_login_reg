class UserModel {
  late String uid;
  String? username;
  String? email;
  String? password;
  String? token;

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
  // Convert an UserModel object into a JSON object
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