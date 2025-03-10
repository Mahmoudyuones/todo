import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/appthem.dart';
import 'package:todo/taps/tasks/task_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:todo/taps/tasks/task_provider.dart';

class TasksTap extends StatefulWidget {
  const TasksTap({super.key});

  @override
  State<TasksTap> createState() => _TasksTapState();
}

class _TasksTapState extends State<TasksTap> {
  bool shouldGetTasks = true;
  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    if (shouldGetTasks) {
      taskProvider.getTasks();
      shouldGetTasks = false;
    }
    print('object');
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: Appthem.primary,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            PositionedDirectional(
                start: 30,
                top: 60,
                child: Text(
                  'To Do List',
                  style: TextTheme.of(context)
                      .titleMedium!
                      .copyWith(color: Appthem.white, fontSize: 22),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 140),
              child: EasyInfiniteDateTimeLine(
                onDateChange: (selectedDate) {
                  taskProvider.onDateChange(selectedDate);
                  taskProvider.getTasks();
                },
                showTimelineHeader: false,
                activeColor: Appthem.white,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                focusDate: taskProvider.selectedDate,
                lastDate: DateTime.now().add(
                  Duration(days: 365),
                ),
                dayProps: EasyDayProps(
                  height: MediaQuery.sizeOf(context).height * .1,
                  width: MediaQuery.sizeOf(context).width * .15,
                  dayStructure: DayStructure.dayStrDayNum,
                  activeDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: Appthem.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      dayStrStyle: TextTheme.of(context)
                          .titleSmall!
                          .copyWith(color: Appthem.primary),
                      dayNumStyle: TextTheme.of(context)
                          .titleSmall!
                          .copyWith(color: Appthem.primary)),
                  todayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: Appthem.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: Appthem.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    dayStrStyle: TextTheme.of(context).titleSmall,
                    dayNumStyle: TextTheme.of(context).titleSmall,
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) =>
                TaskItem(taskModel: taskProvider.tasks[index]),
            itemCount: taskProvider.tasks.length,
          ),
        ),
      ],
    );
  }
}
