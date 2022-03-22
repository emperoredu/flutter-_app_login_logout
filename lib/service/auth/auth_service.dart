import 'package:main/service/auth/auth_provider.dart';
import 'package:main/service/auth/auth_usre.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  const AuthService(this.provider);

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
}
