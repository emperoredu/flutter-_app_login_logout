import 'package:firebase_auth/firebase_auth.dart ' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;

  const AuthUser(this.isEmailVerified);
  //copyng firebase user to this class AuthUser
  factory AuthUser.fromFirebase(User user) => AuthUser(user.emailVerified);
}
