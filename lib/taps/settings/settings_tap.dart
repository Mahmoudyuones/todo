import 'package:flutter/material.dart';
import 'package:todo/appthem.dart';

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
                    onPressed: () {},
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
