import 'package:flutter/material.dart';
import 'package:todo/appthem.dart';
import 'package:todo/taps/settings/settings_tap.dart';
import 'package:todo/taps/tasks/tasks_model_sheet.dart';
import 'package:todo/taps/tasks/tasks_tap.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  final List<Widget> taps = [
    TasksTap(),
    SettingsTap(),
  ];

  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        color: Appthem.white,
        padding: EdgeInsets.all(0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
            elevation: 0,
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => TasksModelSheet(),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: widget.taps[selectedIndex],
    );
  }
}
