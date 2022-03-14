import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/views/register_view.dart';

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

  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login view'),
      ),
      body: Column(
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
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              // ignore: unused_local_variable
              try {
                final userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/NotesView/', (_) => false);
                print(userCredential);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('user not found');
                } else if (e.code == 'invalid-email') {
                  print('invalid email');
                }
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
              // ignore: prefer_const_constructors
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/register/', (route) => false);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const RegisterView()));
              },
              child: const Text('Not registered yet? Register here'))
        ],
      ),
    );
  }
}
