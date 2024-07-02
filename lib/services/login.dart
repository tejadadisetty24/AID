// ignore_for_file: empty_catches, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/export.dart';
import 'package:http/http.dart' as http;

class CustomerLogin {
  login(String email, String password, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      var res = await http.post(Uri.parse('${baseUrl}login'),
          body: jsonEncode({
            "identifier": email,
            "password": password,
          }),
          headers: {
            "content-type": "application/json",
          });

      var body = jsonDecode(res.body);
      print(res.body);
      if (res.statusCode == 200) {
        prefs.setString('firstName', body['user']['firstName']);
        prefs.setString('lastName', body['user']['lastName']);
        prefs.setString('mobile', body['user']['mobileNumber']);
        prefs.setString('altNumber', body['user']['alternateNumber']);
        prefs.setString('email', body['user']['email']);
        prefs.setString('address', body['user']['address']);
        prefs.setString('pin', body['user']['pincode']);
        prefs.setString('DOB', body['user']['dateOfBirth']);
        prefs.setString('age', body['user']['age']);
        prefs.setString('gender', body['user']['gender']);
        prefs.setString('bloodGroup', body['user']['bloodGroup']);
        prefs.setString('latitude', body['user']['coordinatesLatitude']);
        prefs.setString('longitude', body['user']['coordinatesLongitude']);
        prefs.setString('userId', body['user']['userId']);
        prefs.setString('photo', body['user']['photo']);
        prefs.setBool('certified', body['user']['certified']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => const MainSreen(),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (ctx) => const MainSreen(),
    //   ),
    // );
  }
}
