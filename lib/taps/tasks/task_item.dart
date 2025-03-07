import 'package:flutter/material.dart';
import 'package:todo/appthem.dart';
import 'package:todo/taps/tasks/task_model.dart';

class TaskItem extends StatelessWidget {
  final TaskModel taskModel;
  const TaskItem({super.key, required this.taskModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
    );
  }
}
