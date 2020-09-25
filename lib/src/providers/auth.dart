import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/helpers/user.dart';
import 'package:food_order/src/models/user.dart';

enum Status {
  Uninitialized,
  Unauthenticated,
  Authenticating,
  Authenticated,
}

class AuthProvider extends ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  UserModel _userModel;

  Status get status => _status;
  UserModel get userModel => _userModel;
  User get user => _user;

  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  AuthProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<void> _onStateChanged(User user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById(user.uid);
    }
    notifyListeners();
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      _status = Status.Authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      return _onError(e.toString());
    }
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) {
        Map<String, dynamic> values = {
          "name": name.text,
          "email": email.text,
          "id": value.user.uid,
          "likedFood": [],
          "likedRestaurants": [],
        };
        _userServices.createUser(values);
      });
      _status = Status.Authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      return _onError(e.toString());
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      _status = Status.Unauthenticated;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // general methods
  bool _onError(String error) {
    _status = Status.Unauthenticated;
    notifyListeners();
    print(error);
    return false;
  }

  void clearController() {
    email.clear();
    name.clear();
    password.clear();
  }
}
