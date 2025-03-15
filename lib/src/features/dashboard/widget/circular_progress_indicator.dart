import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nvisust_test/src/features/dashboard/model/dashboard_model.dart';
import 'package:nvisust_test/src/features/dashboard/view_model/dashboard_view_model.dart'; // For formatting time

class CustomProgressIndicator extends StatefulWidget {
  const CustomProgressIndicator({super.key});

  @override
  _CustomProgressIndicatorState createState() =>
      _CustomProgressIndicatorState();
}

final DashboardViewModel dashboardViewModel = DashboardViewModel();

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  DateTime? startTime;
  DateTime? endTime;
  Timer? _timer;
  double progress = 0.2;
  String currentTime = "";
  String remainingTime = "9:00:00"; // Initial remaining time (9 hours)

  @override
  void initState() {
    dashboardViewModel.getLeaveList();
    super.initState();
    _updateCurrentTime();
    Timer.periodic(Duration(seconds: 1), (timer) => _updateCurrentTime());
  }

  void _updateCurrentTime() {
    setState(() {
      currentTime = DateFormat.Hms().format(DateTime.now()); // HH:mm:ss format

      if (startTime != null && endTime != null) {
        final now = DateTime.now();
        final remaining = endTime!.difference(now);
        remainingTime = remaining.isNegative
            ? "0:00:00"
            : DateFormat.Hms().format(DateTime(0).add(remaining));
      }
    });
  }

  void startStopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    } else {
      setState(() {
        startTime = DateTime.now();
        endTime = startTime!.add(Duration(hours: 9)); // Limit to 9 hours
      });

      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          final now = DateTime.now();
          final elapsed = now.difference(startTime!).inSeconds;
          final totalDuration = 9 * 60 * 60; // 9 hours in seconds
          progress = elapsed / totalDuration;

          if (progress >= 1.0) {
            progress = 1.0; // Clamp progress at 100%
            _timer!.cancel();
          }

          _updateCurrentTime();
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: progress, // Progress from 0 to 1
                strokeWidth: 40,
                backgroundColor: Colors.grey, // Grey for remaining time
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.green), // Green for completed time
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentTime, // Show current time in center
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Remaining: $remainingTime",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: startStopTimer,
          child: Text(_timer?.isActive ?? false ? "Stop" : "Start"),
        ),
        ElevatedButton(
            onPressed: () {
              dashboardViewModel.attendanceMark(
                  '12-02-2020',
                  AttendanceModel(
                      duration: "5", loginTime: "12:00", logoutTime: "5:00"));
            },
            child: Text("Attendance")),
        ElevatedButton(
            onPressed: () {
              dashboardViewModel.markLeave(
                  '14-02-2020',
                  LeaveModel(
                      leaveType: "sick",
                      startDate: "6-09-2024",
                      endDate: "7-10-2024",
                      reason: "Sick leave",
                      isApproved: true));
            },
            child: Text("Leave")),
        ElevatedButton(
            onPressed: () {
              dashboardViewModel.isExist();
            },
            child: Text("Exist")),
        ElevatedButton(
            onPressed: () {
              dashboardViewModel.updatePunchout();
            },
            child: Text("Punchout")),
      ],
    );
  }
}
