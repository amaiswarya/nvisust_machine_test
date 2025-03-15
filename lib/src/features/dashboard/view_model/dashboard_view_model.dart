import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nvisust_test/src/config/dependency_injection/injection_container_imports.dart';
import 'package:nvisust_test/src/core/utils/extensions/date_extentions.dart';
import 'package:nvisust_test/src/core/utils/helpers/toast.dart';
import 'package:nvisust_test/src/features/dashboard/model/dashboard_model.dart';
import 'package:nvisust_test/src/features/dashboard/repo/dashboard_repo.dart';

class DashboardViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isPageLoading = false;
  bool get isPageLoading => _isPageLoading;
  bool _isExistToday = false;
  bool get isExistToday => _isExistToday;
  bool _isLeaveToday = false;
  bool get isLeaveToday => _isLeaveToday;

  bool _isPunchedIn = false;
  bool get isPunchedIn => _isPunchedIn;

  Future<void> attendanceMark(String date, AttendanceModel data) async {
    _isLoading = true;
    notifyListeners();
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
      notifyListeners();
    } catch (e) {
      showErrorToast(e.toString());
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> markLeave(LeaveModel data) async {
    try {
      final response =
          await servicelocator<DashboardRepo>().markLeave(true, data);
      response.fold((fail) {
        _isLoading = false;
        showErrorToast(fail.message);
      }, (right) {
        _isLoading = false;
        showSuccessToast("Leave applied successfully");
      });
    } catch (e) {
      showErrorToast(e.toString());
    }
  }

  Future<List<DashboardModel>> getLeaveList() async {
    try {
      _isLoading = true;
      final response = await servicelocator<DashboardRepo>().getLeaveList();
      _isLoading = false;

      return response.fold(
        (fail) {
          showErrorToast(fail.toString());
          return [];
        },
        (right) => right.data ?? [],
      );
    } catch (e) {
      _isLoading = false;
      showErrorToast(e.toString());
      return [];
    }
  }

  FutureOr<void> isExist() async {
    _isPageLoading = true;
    _isLoading = true;
    notifyListeners();
    try {
      final response = await servicelocator<DashboardRepo>()
          .isExist(DateTime.now().toFormattedString());
      response.fold((fail) {
        _isPageLoading = false;
        _isLoading = false;
        _isPunchedIn = false;
        _isExistToday = false;
      }, (right) async {
        _isExistToday = right;
        final doc = await servicelocator<DashboardRepo>()
            .getDocument(DateTime.now().toFormattedString());
        doc.fold((fail) {
          _isPageLoading = false;
          _isLoading = false;
          _isPunchedIn = false;
        }, (right) async {
          DashboardModel data = right;
          if (data.isLeave) {
            _isLeaveToday = true;
          } else {
            _isPunchedIn = data.loginData?.isPunchedIn ?? false;
          }
          _isPageLoading = false;
          _isLoading = false;
        });
      });
      notifyListeners();
    } catch (e) {
      showErrorToast(e.toString());
      _isPageLoading = false;
      _isLoading = false;
    }
    notifyListeners();
  }

  // FutureOr<void> getDocument() async {
  //   _isPageLoading = true;
  //   notifyListeners();
  //   try {
  //     final response = await servicelocator<DashboardRepo>()
  //         .getDocument(DateTime.now().toFormattedString());
  //     response.fold((fail) {
  //       _isPageLoading = false;
  //       _isPunchedIn = false;
  //       _isExistToday = false;
  //     }, (right) {
  //       _isPageLoading = false;
  //       _isExistToday = right;
  //     });
  //     notifyListeners();
  //   } catch (e) {
  //     showErrorToast(e.toString());
  //     _isPageLoading = false;
  //   }
  //   notifyListeners();
  // }

  Future<void> updatePunchout() async {
    try {
      final response = await servicelocator<DashboardRepo>()
          .updatePunchout(DateTime.now().toFormattedString(), {
        "login_data.isPunchedIn": false,
        "login_data.logoutTime": DateTime.now().toString()
      });
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
