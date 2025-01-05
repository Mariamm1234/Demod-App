import 'package:demod/models/login.dart';
import 'package:demod/models/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider with ChangeNotifier {
  String? _token;

  bool get isAuthenticated => _token != null;
String? get vip=>_token;
String email="";
int count=0;
  Future<void> token(TokenDto token) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/token');
    final response = await http.post(
      url,
      body: json.encode({
        'email': token.email,
        'password': token.password,
        'businessName':token.businessName
      }),
      headers: {'Content-Type': 'application/json'},
    );

      _token = json.decode(response.body)['token'];
      email=json.decode(response.body)['email'];
      notifyListeners();
    // if (response.statusCode == 200) {
    //   _token = json.decode(response.body)['token'];
    //   notifyListeners();
    // } else {
    //   throw Exception('Failed to log in');
    // }
  }


  Future<void> login(LoginDto user)async{

final url = Uri.parse('http://10.0.2.2:8080/api/login');
    final response = await http.post(
      url,
      body: json.encode({
        'email': user.email,
      'token':user.token
      }),
      // headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['userEmail'];
      notifyListeners();
    } else {
      throw Exception('Failed to log in');
    }
  }
}