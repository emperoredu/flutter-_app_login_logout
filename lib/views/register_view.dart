import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/views/Login_views.dart';

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
                    .createUserWithEmailAndPassword(
                        email: email, password: password);
                print(userCredential);
              } on FirebaseException catch (e) {
                if (e.code == 'network-request-failed') {
                  print('network request failed');
                } else if (e.code == 'weak-password') {
                  print('weak password ');
                } else if (e.code == 'email-alreday-in-use') {
                  print('Email already in use');
                  print(UserCredential);
                } else if (e.code == 'invalid-email') {
                  print('invalid email');
                }
              }
            },
            child: const Text('Register'),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login/', (route) => false);
                },
                child: const Text('Already registered? Logine here!')),
          )
        ],
      ),
    );
  }
}
