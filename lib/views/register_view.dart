import 'package:flutter/material.dart';
import 'package:main/constants/routes.dart';
import 'package:main/service/auth/auth_exceptions.dart';
import 'package:main/service/auth/auth_service.dart';

import '../utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _email,
              decoration:
                  const InputDecoration(hintText: 'Enyter your Email here'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: 'Enter your pass word here'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  // ignore: unused_local_variable
                  try {
                    await AuthService.firebase().createUser(
                      email: email,
                      password: password,
                    );

                    // AuthService.firebase().currentUser;

                    AuthService.firebase().sendEmailVerificatin();

                    Navigator.of(context).pushNamed(verifyemailRoute);
                  } on InvalidEmailAuthException {
                    await showErrorDialog(context, 'Invalid email');
                  } on NetworkReuestFailAuthException {
                    await showErrorDialog(
                      context,
                      'network request failed',
                    );
                  } on EmailAlreadyInUseAuthException {
                    await showErrorDialog(
                      context,
                      'Email already in use',
                    );
                  } on WeakPasswordAuthException {
                    await showErrorDialog(
                      context,
                      'Weak password',
                    );
                  } on GenericAuthException {
                    await showErrorDialog(context, 'Authentication Error');
                  }

                  //catches any other exception which not firebase authexception
                },
                child: const Text('Register'),
              ),
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  },
                  child: const Text('Already registered? Log ine here!')),
            )
          ],
        ),
      ),
    );
  }
}
