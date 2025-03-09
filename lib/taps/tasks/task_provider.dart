import 'package:flutter/material.dart';
import 'package:todo/widgets/firebasefunctions.dart';

class TaskProvider with ChangeNotifier {
  List tasks = [];
  Future<void> getTasks() async {
    tasks = await Firebasefunctions.getAllTasksFromFirestore();
    notifyListeners();
  }
}
