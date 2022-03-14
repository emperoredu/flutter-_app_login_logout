import 'dart:html';
import 'dart:js';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:main/views/Login_views.dart';
import 'package:main/views/Verify_email.dart';
import 'package:main/views/register_view.dart';

import 'firebase_options.dart';
import 'dart:developer' as devtools show log;

void main() async {
  // await Firebase.initializeApp(
  //   options: FirebaseOptions.fromMap(
  //       // ignore: prefer_const_literals_to_create_immutables
  //       {
  //         "apiKey": "AIzaSyBpxWjmwnK6-D9fOBp9iqanH77PqSih9Hs",
  //         "authDomain": "user-login-92c12.firebaseapp.com",
  //         "projectId": "user-login-92c12",
  //         "storageBucket": "user-login-92c12.appspot.com",
  //         "messagingSenderId": "906355971972",
  //         "appId": "1:906355971972:web:202edb45d2de9a529c6fd1",
  //         "measurementId": "G-RQ6T673M12"
  //       }),
//  );
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    home: const Homepage(),
    routes: {
      '/login/': (context) => const LoginView(),
      '/register/': (context) => const RegisterView(),
      '/NotesView/': (context) => const NotesView(),
    },
  ));
}

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            // // ignore: non_constant_identifier_names
            final User = FirebaseAuth.instance.currentUser;
            if (User != null) {
              if (User.emailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLout = await showlogoutDialog(context);
                  devtools.log(shouldLout.toString());
                  if (shouldLout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login/', (_) => false);
                  }

                  break;
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
        centerTitle: false,
      ),
      body: const Center(child: Text('DONE')),
    );
  }
}

Future<bool> showlogoutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Sing out'),
          content: const Text('Are you sure u want to sing out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
              child: const Text('Log out'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      }).then((value) => value ?? false);
}