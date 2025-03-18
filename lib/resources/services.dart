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


}