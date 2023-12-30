import 'package:cashtrack/screens/Home_screen.dart';
import 'package:cashtrack/screens/calculator_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CashTrack());
}

class CashTrack extends StatefulWidget {
  const CashTrack({super.key});

  @override
  State<CashTrack> createState() => _CashTrackState();
}

class _CashTrackState extends State<CashTrack> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
