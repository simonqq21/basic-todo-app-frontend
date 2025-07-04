// import 'dart:collection';
import 'package:basic_note_app_frontend/viewmodels/createnoteviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:basic_note_app_frontend/viewmodels/homeviewmodel.dart';
import 'package:basic_note_app_frontend/views/homeview.dart';

import 'package:basic_note_app_frontend/views/viewnoteview.dart';
import 'package:basic_note_app_frontend/viewmodels/viewnoteviewmodel.dart';
import 'utils/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:basic_note_app_frontend/views/createnoteview.dart';

Future main() async {
  // runApp(MyApp());
  await dotenv.load(fileName: ".env");
  logger.d("base backend URL = ${dotenv.env['BASE_URL']}");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => CreateNoteViewModel()),
        ChangeNotifierProvider(create: (context) => ViewNoteViewModel()),
      ],
      child: const MyApp(),
    ),
    // ChangeNotifierProvider(
    //   create: (context) => HomeViewModel(),
    //   child: const MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(path: '/', builder: (context, state) => HomePage()),
      GoRoute(
        path: '/notes/create',
        builder: (context, state) => CreateNotePage(),
      ),
      GoRoute(
        path: '/notes/:id',
        builder:
            (context, state) =>
                ViewNotePage(id: int.parse(state.pathParameters['id'] ?? "")),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: "Simonqq21's todo app",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
    );
  }
}
