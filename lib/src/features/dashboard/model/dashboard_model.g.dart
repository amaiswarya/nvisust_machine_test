// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardModel _$DashboardModelFromJson(Map<String, dynamic> json) =>
    DashboardModel(
      date: json['date'] as String?,
      isLeave: json['isLeave'] as bool,
      loginData: json['login_data'] == null
          ? null
          : AttendanceModel.fromJson(
              json['login_data'] as Map<String, dynamic>),
      leaveData: json['leave_data'] == null
          ? null
          : LeaveModel.fromJson(json['leave_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardModelToJson(DashboardModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'isLeave': instance.isLeave,
      'login_data': instance.loginData,
      'leave_data': instance.leaveData,
    };

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) =>
    AttendanceModel(
      loginTime: json['loginTime'] as String?,
      duration: json['duration'] as String?,
      logoutTime: json['logoutTime'] as String?,
    );

Map<String, dynamic> _$AttendanceModelToJson(AttendanceModel instance) =>
    <String, dynamic>{
      'duration': instance.duration,
      'loginTime': instance.loginTime,
      'logoutTime': instance.logoutTime,
    };

LeaveModel _$LeaveModelFromJson(Map<String, dynamic> json) => LeaveModel(
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      reason: json['reason'] as String?,
      leaveType: json['leaveType'] as String?,
      isApproved: json['isApproved'] as bool?,
    );

Map<String, dynamic> _$LeaveModelToJson(LeaveModel instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'reason': instance.reason,
      'leaveType': instance.leaveType,
      'isApproved': instance.isApproved,
    };
