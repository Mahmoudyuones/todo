import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/appthem.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/register_screen.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/home_screen.dart';
import 'package:todo/taps/tasks/edit_task_screen.dart';
import 'package:todo/taps/tasks/task_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => TaskProvider(),
    )
  ], child: TodoApp()));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        //EditTaskScreen.routeName: (_) => EditTaskScreen(),
      },
      initialRoute: LoginScreen.routeName,
      theme: Appthem.lighappthem,
      darkTheme: Appthem.darckappthem,
      themeMode: ThemeMode.light,
    );
  }
}
