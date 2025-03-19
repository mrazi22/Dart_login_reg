import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/users.dart';








class Services{
  static String HOST = "http://localhost/PHPauth-serve/";



  // Register user
  static String _USERS = HOST + "users.php";
  static  String _REGISTER  = 'REGISTER';
  static  String _LOGIN  = 'LOGIN';


  // Method to create the table Users.
  List<UserModel> userFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<UserModel>.from(data.map((item) => UserModel.fromJson(item)));
  }


  // Register user
static  Future<Object> registerUsers(String username, String email, String password, String token, String uid) async {
  try{
    var request = http.MultipartRequest('POST', Uri.parse(_USERS));
    request.fields['action'] = _REGISTER;
    request.fields['uid'] = uid;
    request.fields['username'] = username;
    request.fields['email'] = email;
    request.fields['token'] = token;
    request.fields['password'] = password;
    var response = await request.send();
    return response;
  } catch(e){
    return 'error';
  }

}


}