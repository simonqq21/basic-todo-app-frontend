import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotesFormAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const NotesFormAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: IconButton(
      //   onPressed: () {
      //     // context.pop();
      //     context.go('/');
      //   },
      //   icon: Icon(Icons.arrow_back),
      // ),
      title: Center(child: Text(title)),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
