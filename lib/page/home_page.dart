import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String compliment = '';

  @override
  void initState() {
    super.initState();
    updateCompliment();
  }

  void updateCompliment() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;
    setState(() {
      compliment = getCompliment(hour);
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              Text('$compliment!'),
            ],
          ),
        ),
      ),
    );
  }
}
