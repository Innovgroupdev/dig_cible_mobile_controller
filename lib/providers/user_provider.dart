import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _nom = '';
  String _prenoms = '';
  String _email = '';
  String _password = '';
  String _token = '';

  String get nom => _nom;
  String get prenoms => _prenoms;
  String get email => _email;
  String get password => _password;
  String get token => _token;

  void setNom(String nom){
    _nom = nom;
    notifyListeners();
  }
  void setPrenoms(String prenoms){
    _prenoms = prenoms;
    notifyListeners();
  }
  void setEmail(String email){
    _email = email;
    notifyListeners();
  }
  void setPassword(String password){
    _password = password;
    notifyListeners();
  }
  void setToken(String token){
    _token = token;
    notifyListeners();
  }

}
