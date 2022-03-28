import 'package:main/service/auth/auth_provider.dart';
import 'package:main/service/auth/auth_user.dart';

import 'firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  AuthService(this.provider);

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(
        email: email,
        password: password,
      );

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<AuthUser> loging({
    required String email,
    required String password,
  }) =>
      provider.loging(email: email, password: password);

  @override
  Future<void> sendEmailVerificatin() => provider.sendEmailVerificatin();

  @override
  Future<void> initialize() => provider.initialize();
}
