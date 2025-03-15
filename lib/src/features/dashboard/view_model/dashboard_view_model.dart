import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nvisust_test/src/config/dependency_injection/injection_container_imports.dart';
import 'package:nvisust_test/src/core/utils/helpers/toast.dart';
import 'package:nvisust_test/src/features/dashboard/model/dashboard_model.dart';
import 'package:nvisust_test/src/features/dashboard/repo/dashboard_repo.dart';

class DashboardViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  FutureOr<void> attendanceMark(String date, AttendanceModel data) async {
    try {
      final response = await servicelocator<DashboardRepo>()
          .markAttendance(date, false, data);
      response.fold((fail) {
        _isLoading = false;
        showErrorToast(fail.message);
      }, (right) {
        _isLoading = false;
        showSuccessToast("Attendance Marked");
      });
    } catch (e) {
      showErrorToast(e.toString());
    }
  }

  FutureOr<void> markLeave(String date, LeaveModel data) async {
    try {
      final response =
          await servicelocator<DashboardRepo>().markLeave(date, true, data);
      response.fold((fail) {
        _isLoading = false;
        showErrorToast(fail.message);
      }, (right) {
        _isLoading = false;
        showSuccessToast("Attendance Marked");
      });
    } catch (e) {
      showErrorToast(e.toString());
    }
  }

  FutureOr<void> getLeaveList() async {
    try {
      final response = await servicelocator<DashboardRepo>().getLeaveList();
      response.fold((fail) {
        _isLoading = false;
        showErrorToast(fail.message);
      }, (right) {
        _isLoading = false;
        showSuccessToast("Leave list count $right");
      });
    } catch (e) {
      showErrorToast(e.toString());
    }
  }

  FutureOr<void> isExist() async {
    try {
      final response =
          await servicelocator<DashboardRepo>().isExist("14-02-2020");
      response.fold((fail) {
        _isLoading = false;
        showSuccessToast("Item $fail");
      }, (right) {
        _isLoading = false;
        showSuccessToast("Itemt $right");
      });
    } catch (e) {
      showErrorToast(e.toString());
    }
  }

  FutureOr<void> updatePunchout() async {
    try {
      final response = await servicelocator<DashboardRepo>().updatePunchout(
          "12-02-2020",
          {"login_data.duration": "10", "login_data.logoutTime": "10:00"});
      response.fold((fail) {
        _isLoading = false;
        showSuccessToast("Punchout fail");
      }, (right) {
        _isLoading = false;
        showSuccessToast("Punchout success");
      });
    } catch (e) {
      showErrorToast(e.toString());
    }
  }
}
