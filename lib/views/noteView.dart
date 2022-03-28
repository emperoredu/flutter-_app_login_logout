import 'package:flutter/material.dart';
import 'package:main/constants/routes.dart';
import 'package:main/service/auth/auth_service.dart';

import '../enums/menu_action.dart';

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

                  if (shouldLout) {
                    await AuthService.firebase().logOut();

                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (_) => false);
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
      body: ListView.separated(
        itemCount: 20,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            color: Colors.grey,
            child: Column(
              children: [
                Row(
                  children: const [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/5677314/pexels-photo-5677314.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
                    ),
                    Text(
                      ' A Bot',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Text(
                      "  @iamarealhuman",
                    )
                  ],
                ),
                const Padding(
                    child: Text(
                        '"It might not be a human," "but it acts almost like it would if it were a human.",'),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8)),
                Row(
                  children: [
                    FlatButton(
                        onPressed: () => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text('Now you follow @ Emperoradu'))),
                        child: const Text(
                          'Follow',
                          style: TextStyle(color: Colors.lightBlueAccent),
                        )),
                    FlatButton(
                        onPressed: () => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text("you can't send messages"))),
                        child: const Text(
                          'Send Message',
                          style: TextStyle(color: Colors.lightBlueAccent),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
        separatorBuilder: (contect, i) => i % 1 == 0
            ? const Divider()
            : const Padding(
                padding: EdgeInsets.all(10),
              ),
      ),
    );
  }
}

Future<bool> showlogoutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('log out'),
          content: const Text('Are you sure u want to logout?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
              child: const Text('Log out'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      }).then((value) => value ?? false);
}
