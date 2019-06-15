import 'dart:async';

import 'package:meta/meta.dart';

@immutable
class User {
  const User({
    @required this.uid,
    this.email,
  });

  final String uid;
  final String email;
}

abstract class AuthService {
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<void> signOut();
  Stream<User> get onAuthStateChanged;
  void dispose();
}
