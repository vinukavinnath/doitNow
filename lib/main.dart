import 'package:flutter/material.dart';
import 'package:doitnow/core/constants.dart';
import 'package:doitnow/page/home_page.dart';

void main() {
  runApp(
    const DoItNow(),
  );
}

class DoItNow extends StatelessWidget {
  const DoItNow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DoitNow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        //primarySwatch: kScaffoldPrimaryColor,
        fontFamily: 'Sequel Sans',
        scaffoldBackgroundColor: kScaffoldPrimaryColor,
      ),
      home: const HomePage(),
    );
  }
}
