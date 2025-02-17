import 'package:flutter/material.dart';
import 'package:todo/appthem.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Appthem.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(15),
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
                'Task Title',
                style: TextStyle(
                  color: Appthem.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Task Description'),
            ],
          ),
          Spacer(),
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
              child: Icon(Icons.done),
            ),
          ),
        ],
      ),
    );
  }
}
