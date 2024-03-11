import 'dart:convert';

import 'package:flutter/material.dart';

final formkey = GlobalKey<FormState>();

class AppConstants {
  static final baseUrl = 'https://meshutechsolution.test.makeplans.net/api/v1/';
  static final APIKEY = '060d2f4bffe074f2479aedc500c63edb50813cbf';
}

class Utils{

Utils();
static validator({required String value, required String type}){
     switch(type){
      case 'email':
       return _isEmailValid(value);
      case 'password':
        return _isPasswordValid(value);
     }
}


static _isEmailValid(String email) {
  
  final RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );
  
  if(!emailRegex.hasMatch(email))
  {
    return 'Email is not valid';
  }
  return;
}
static _isPasswordValid(String password) {
  final RegExp lengthAtLeast4Regex = RegExp(r'^.{4,}$');
  if(!lengthAtLeast4Regex.hasMatch(password))
  {
    return 'Password length must be greater than 4';
  }
  return;
}
}