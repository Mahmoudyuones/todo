import 'package:flutter/material.dart';
import 'package:todo/appthem.dart';
import 'package:todo/taps/tasks/task_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class TasksTap extends StatelessWidget {
  const TasksTap({super.key});

  @override
  Widget build(BuildContext context) {
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
                showTimelineHeader: false,
                activeColor: Appthem.white,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                focusDate: DateTime.now(),
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
                  inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: Appthem.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      dayStrStyle: TextTheme.of(context).titleSmall,
                      dayNumStyle: TextTheme.of(context).titleSmall),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => const TaskItem(),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
