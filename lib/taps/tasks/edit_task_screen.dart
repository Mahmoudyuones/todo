import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/appthem.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/taps/tasks/task_provider.dart';
import 'package:todo/widgets/default_elevated_boutton.dart';
import 'package:todo/widgets/default_text_form_field.dart';
import 'package:todo/widgets/firebasefunctions.dart';

class EditTaskScreen extends StatefulWidget {
  static final String routeName = '/edit-task';
  final TaskModel taskModel;
  final String userId;
  const EditTaskScreen(
      {super.key, required this.taskModel, required this.userId});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController titelController = TextEditingController();
  TextEditingController descrptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  var formkey = GlobalKey<FormState>();
  void initState() {
    titelController.text = widget.taskModel.title;
    descrptionController.text = widget.taskModel.description;
    selectedDate = widget.taskModel.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Appthem.primary,
          centerTitle: false,
          title: Text(
            'To Do List',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 22, color: Appthem.white),
          ),
          iconTheme: const IconThemeData(
            color: Appthem.white,
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  color: Appthem.primary,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                  decoration: const BoxDecoration(
                      color: Appthem.white,
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(15),
                          right: Radius.circular(15))),
                  height: MediaQuery.of(context).size.height * .7,
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Text(
                          "Edit Task",
                          style: TextTheme.of(context).titleLarge!.copyWith(
                              color: Appthem.black,
                              fontWeight: FontWeight.bold),
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
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
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
                                text: 'Save Changes',
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    widget.taskModel.title =
                                        titelController.text;
                                    widget.taskModel.description =
                                        descrptionController.text;
                                    widget.taskModel.date = selectedDate;
                                    saveChanges(
                                        widget.taskModel, widget.userId);
                                    Navigator.of(context).pop();
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
            ),
          ],
        ));
  }

  void saveChanges(TaskModel task, String userId) {
    Firebasefunctions.updateTaskInFirestore(task, userId);
    Provider.of<TaskProvider>(context, listen: false).getTasks(userId);
  }
}
