import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nvisust_test/routes_manager/route_imports.gr.dart';
import 'package:nvisust_test/src/core/common_widgets/primary_button.dart';
import 'package:nvisust_test/src/core/utils/extensions/date_extentions.dart';
import 'package:nvisust_test/src/core/utils/extensions/spacing_extension.dart';
import 'package:nvisust_test/src/core/utils/helpers/toast.dart';
import 'package:nvisust_test/src/core/utils/styles/app_colors.dart';
import 'package:nvisust_test/src/features/dashboard/model/dashboard_model.dart';
import 'package:nvisust_test/src/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:provider/provider.dart';

@RoutePage()
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Timer _timer;
  String _currentTime = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkInitialStatus();
    });

    _updateTime();

    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
    });
  }

  Future<void> _checkInitialStatus() async {
    final dashboardViewModel =
        Provider.of<DashboardViewModel>(context, listen: false);
    await dashboardViewModel.isExist();
  }

  Future<void> _togglePunchStatus(bool isExist, bool isPunchedIn) async {
    final dashboardViewModel =
        Provider.of<DashboardViewModel>(context, listen: false);
    if (isExist && !isPunchedIn) {
      showSuccessToast("Already marked attendance");
    } else {
      if (isExist && isPunchedIn) {
        await dashboardViewModel
            .updatePunchout()
            .whenComplete(() => dashboardViewModel.isExist());
      } else {
        await dashboardViewModel
            .attendanceMark(
                DateTime.now().toFormattedString(),
                AttendanceModel(
                    isPunchedIn: true, loginTime: DateTime.now().toString()))
            .whenComplete(() => dashboardViewModel.isExist());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DashboardViewModel>(
        builder: (context, viewModel, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: (viewModel.isPageLoading && viewModel.isLoading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Current Time Display
                              Text(
                                _currentTime,
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 20),

                              // Status Indicator
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: viewModel.isPunchedIn
                                      ? Colors.green[300]
                                      : Colors.red[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  (viewModel.isLeaveToday &&
                                          viewModel.isExistToday)
                                      ? "You are on leave today"
                                      : (viewModel.isExistToday &&
                                              !viewModel.isPunchedIn)
                                          ? "Already marked attendance"
                                          : viewModel.isPunchedIn
                                              ? "You are currently working"
                                              : "You are off duty",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              30.height,

                              GestureDetector(
                                onTap: () {
                                  if (!viewModel.isLeaveToday ||
                                      !viewModel.isExistToday) {
                                    _togglePunchStatus(viewModel.isExistToday,
                                        viewModel.isPunchedIn);
                                  }
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: viewModel.isPunchedIn ||
                                            viewModel.isLeaveToday
                                        ? Colors.red
                                        : Colors.green,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: (viewModel.isLoading ||
                                            viewModel.isPageLoading)
                                        ? CircularProgressIndicator()
                                        : Text(
                                            (viewModel.isLeaveToday &&
                                                    viewModel.isExistToday)
                                                ? "Leave"
                                                : (viewModel.isExistToday &&
                                                        !viewModel.isPunchedIn)
                                                    ? "Done"
                                                    : viewModel.isPunchedIn
                                                        ? "Punch Out"
                                                        : "Punch In",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ButtonWidget.primary(
                            onTap: () async {
                              await context
                                  .pushRoute(LeaveDashboardRoute())
                                  .whenComplete(() => viewModel.isExist());
                            },
                            text: 'Leave management')
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
