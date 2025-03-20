import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/appthem.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/taps/tasks/task_provider.dart';
import 'package:todo/widgets/firebasefunctions.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TaskItem extends StatelessWidget {
  final TaskModel taskModel;
  const TaskItem({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<UserProvider>(context).currentUser!.id;
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            deletTask(context, userId);
          }),
          children: [
            SlidableAction(
              onPressed: (_) {
                deletTask(context, userId);
              },
              backgroundColor: Appthem.red,
              foregroundColor: Appthem.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Appthem.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Appthem.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 62,
                width: 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.title,
                    style: const TextStyle(
                      color: Appthem.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(taskModel.description),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appthem.primary,
                    iconColor: Appthem.white,
                    iconSize: 30,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Icon(Icons.done),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deletTask(BuildContext context, String userId) {
    Firebasefunctions.deleteTaskFromFirestore(taskModel.id, userId).timeout(
      const Duration(microseconds: 100),
      onTimeout: () {
        Fluttertoast.showToast(
          msg: 'Task Deleted',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Appthem.green,
        );
        return Provider.of<TaskProvider>(context, listen: false)
            .getTasks(userId);
      },
    ).catchError(
      (_) {
        Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Appthem.red,
        );
      },
    );
  }
}
