import 'package:flutter/material.dart';

class AuthData with ChangeNotifier {
  String? name;

  void update(dynamic data) {
    name = data['memberName'];
    notifyListeners();
  }
}
