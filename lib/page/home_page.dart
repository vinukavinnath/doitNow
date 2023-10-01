import 'package:doitnow/core/constants.dart';
import 'package:doitnow/widget/add_task_widget.dart';
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
    ['Myself', 'Walk my Dog'],
    ['Home', 'Grocery Shopping'],
    //['Work', 'Business Meeting'],
    //['Myself', 'Meet Doctor'],
  ];

  String compliment = '';
  String dayOfWeek = '';
  String currentMonth = '';
  String currentDate = '';

  bool isCompleted = false;

  TextEditingController categoryController = TextEditingController();
  TextEditingController taskController = TextEditingController();

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

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void addTask() {
    setState(() {
      tasks.add([categoryController.text, taskController.text]);
    });
    Navigator.pop(context);
    categoryController.clear();
    taskController.clear();
  }

  @override
  void initState() {
    super.initState();
    updateCompliment();
  }

  @override
  void dispose() {
    categoryController.dispose();
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;

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
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/profile.jpg'),
                          radius: 30.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kScaffoldSecondaryColor,
                          ),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AddTaskWidget(
                                    categoryController: categoryController,
                                    taskController: taskController,
                                    submitData: addTask,
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.add,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text(
                      '$compliment!',
                      style: kComplimentTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color: kCard2Color,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Text(
                                tasks.length.toString(),
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: Text(
                                tasks.length <= 1 ? 'Task' : 'Tasks',
                                style: kComplimentTextStyle.copyWith(
                                  fontSize: 25.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: tasks.length < 1
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Text>[
                            Text(
                              'No Tasks to Display!',
                              style: kSubtitleTextStyle.copyWith(
                                fontSize: 25.0,
                              ),
                            ),
                            Text(
                              'Add Some...',
                              style: kSubtitleTextStyle.copyWith(
                                color: kDarkGreyColor,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    deleteTask(index);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Task was Deleted'),
                                        backgroundColor: kWarningRed,
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  icon: Icons.delete,
                                  backgroundColor: kWarningRed,
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ],
                            ),
                            child: TaskCardWidget(
                              taskCategory: tasks[index][0],
                              taskTitle: tasks[index][1],
                              index: index,
                            ),
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
