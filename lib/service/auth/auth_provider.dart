import 'package:main/service/auth/auth_usre.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;

  Future<AuthUser> loging({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerificatin();
}
