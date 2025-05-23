import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/appthem.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/taps/tasks/task_provider.dart';
import 'package:todo/widgets/default_elevated_boutton.dart';
import 'package:todo/widgets/default_text_form_field.dart';
import 'package:todo/widgets/firebasefunctions.dart';

class TasksModelSheet extends StatefulWidget {
  const TasksModelSheet({super.key});

  @override
  State<TasksModelSheet> createState() => _TasksModelSheetState();
}

class _TasksModelSheetState extends State<TasksModelSheet> {
  TextEditingController titelController = TextEditingController();
  TextEditingController descrptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
          decoration: const BoxDecoration(
              color: Appthem.white,
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(15), right: Radius.circular(15))),
          height: MediaQuery.of(context).size.height * .57,
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Text(
                  "Add New Task",
                  style: TextTheme.of(context).titleLarge!.copyWith(
                      color: Appthem.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                DefaultTextFormField(
                  controller: titelController,
                  hintText: "Enter the Task Name",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter the Task Name';
                    } else if (value.length > 15) {
                      return 'Task Name should be less than 15 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                DefaultTextFormField(
                  controller: descrptionController,
                  hintText: "Enter the Task Description",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please Enter the Task Description";
                    } else if (value.length > 15) {
                      return 'Task Description should be less than 15 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () async {
                    DateTime? dateTime = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                    );
                    if (dateTime != null && dateTime != selectedDate) {
                      selectedDate = dateTime;
                      setState(() {});
                    }
                  },
                  child: Column(
                    children: [
                      Text(
                        'Select Date',
                        style: TextTheme.of(context)
                            .titleMedium!
                            .copyWith(color: Appthem.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        dateFormat.format(selectedDate),
                        style: TextTheme.of(context).titleSmall,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      DefaultElevatedBoutton(
                        text: 'Add',
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            addTask();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          )),
    );
  }

  void addTask() {
    String userId =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    TaskModel task = TaskModel(
        title: titelController.text,
        description: descrptionController.text,
        date: selectedDate);

    Firebasefunctions.addTaskToFireStore(task, userId).then((value) {
      Navigator.of(context).pop();
      Provider.of<TaskProvider>(context, listen: false).getTasks(userId);

      Fluttertoast.showToast(
          msg: "Task Added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Appthem.primary,
          textColor: Appthem.white,
          fontSize: 16.0);
    }).catchError((_) {
      Fluttertoast.showToast(
          msg: "Something went Wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Appthem.red,
          textColor: Appthem.white,
          fontSize: 16.0);
    });
  }
}
