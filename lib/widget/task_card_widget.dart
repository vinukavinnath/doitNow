import 'package:flutter/material.dart';
import 'package:doitnow/core/constants.dart';

class TaskCardWidget extends StatefulWidget {
  TaskCardWidget({
    super.key,
    required this.taskCategory,
    required this.taskTitle,
    required this.isCompleted,
    required this.index,
  });

  final String taskCategory;
  final String taskTitle;
  bool isCompleted;
  final int index;

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  Color selectCardColor(int index) {
    if (index % 3 == 0) {
      return kCard0Color;
    } else if (index % 3 == 1) {
      return kCard1Color;
    } else {
      return kCard2Color;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      padding: const EdgeInsets.all(
        16.0,
      ),
      width: screenWidth,
      decoration: BoxDecoration(
        color: selectCardColor(widget.index),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.taskCategory,
                style: kCardCategoryTextStyle,
              ),
              Text(
                widget.taskTitle,
                style: kCardTitleTextStyle,
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: kJetBlack.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.done_outline,
                color: kScaffoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
