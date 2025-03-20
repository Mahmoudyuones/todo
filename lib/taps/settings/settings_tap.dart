import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/appthem.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/taps/tasks/task_provider.dart';

class SettingsTap extends StatelessWidget {
  const SettingsTap({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Logout',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Appthem.backgroundDark,
                        )),
                IconButton(
                    onPressed: () {
                      Provider.of<UserProvider>(context, listen: false)
                          .updateUser(null);
                      Provider.of<TaskProvider>(context, listen: false)
                          .tasks
                          .clear();
                      Provider.of<TaskProvider>(context, listen: false)
                          .selectedDate = DateTime.now();
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Appthem.backgroundDark,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
