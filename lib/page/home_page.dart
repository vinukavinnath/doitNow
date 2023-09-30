import 'package:doitnow/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String compliment = '';
  String dayOfWeek = '';
  String currentMonth = '';
  String currentDate = '';

  @override
  void initState() {
    super.initState();
    updateCompliment();
  }

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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
        ),
      ),
    );
  }
}
