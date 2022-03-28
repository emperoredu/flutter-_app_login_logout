// ignore: file_names

import 'package:flutter/material.dart';
import 'package:main/constants/routes.dart';
import 'package:main/service/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(
        children: [
          const Text(
              'Email verification sent,please login to your email to vrify your account '),
          const Text(
              "if you haven't received a verication yet, press the button below"),
          TextButton(
              onPressed: () async {
                //  ignore: non_constant_identifier_names
                await AuthService.firebase().sendEmailVerificatin();
              },
              child: const Text('send email Verification')),
          ElevatedButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text(
              'Restart',
            ),
          ),
        ],
      ),
    );
  }
}
