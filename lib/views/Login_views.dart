// ignore: file_names
import 'package:flutter/material.dart';
import 'package:main/constants/routes.dart';
import 'package:main/service/auth/auth_exceptions.dart';
import 'package:main/service/auth/auth_service.dart';

import '../utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login view'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(hintText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  // ignore: unused_local_variable
                  try {
                    await AuthService.firebase()
                        .loging(email: email, password: password);

                    final user = AuthService.firebase().currentUser;
                    if (user?.isEmailVerified ?? false) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        noteRoute,
                        (_) => false,
                      );
                    } else {
                      await showErrorDialog(
                        context,
                        'Please login to ur email to verify  you account,thank you',
                      );
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        verifyemailRoute,
                        (route) => false,
                      );
                    }

                    //firebaseauthentication exception decleared
                  } on UserNotFoundAuthException {
                    await showErrorDialog(
                      context,
                      'User not found',
                    );
                  } on WrongPasswordAuthException {
                    await showErrorDialog(
                      context,
                      'Wrong password',
                    );
                  } on GenericAuthException {
                    await showErrorDialog(
                      context,
                      'Authentication error',
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ),
            TextButton(
                // ignore: prefer_const_constructors
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(registerRoute, (route) => false);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const RegisterView()));
                },
                child: const Text(
                  'Not registered yet? Register here',
                ))
          ],
        ),
      ),
    );
  }
}
