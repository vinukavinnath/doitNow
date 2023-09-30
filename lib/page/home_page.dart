import 'package:doitnow/core/constants.dart';
import 'package:doitnow/widget/task_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List> tasks = [
    ['Myself', 'Walk my Dog', false],
    ['Home', 'Grocery Shopping', false],
    ['Work', 'Business Meeting', false],
  ];

  String compliment = '';
  String dayOfWeek = '';
  String currentMonth = '';
  String currentDate = '';

  bool isCompleted = false;

  void deleteTask(BuildContext context) {}

  void updateCompliment() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;
    final dayFormat = DateFormat('EEEE');
    final dateFormat = DateFormat('MMM dd, yyyy');
    setState(() {
      compliment = getCompliment(hour);
      dayOfWeek = dayFormat.format(currentTime);
      currentDate = dateFormat.format(currentTime);
    });
  }

  String getCompliment(int hour) {
    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  void initState() {
    super.initState();
    updateCompliment();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24.0,
                    ),
                    child: Text(
                      '$compliment!',
                      style: kComplimentTextStyle,
                    ),
                  ),
                  Text(
                    'Today\'s $dayOfWeek',
                    style: kSubtitleTextStyle,
                  ),
                  Text(
                    currentDate,
                    style: kSubtitleTextStyle.copyWith(
                      color: kDarkGreyColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: deleteTask,
                            icon: Icons.delete,
                            backgroundColor: kWarningRed,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ],
                      ),
                      child: TaskCardWidget(
                          taskCategory: tasks[index][0],
                          taskTitle: tasks[index][1],
                          isCompleted: isCompleted,
                          index: index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
