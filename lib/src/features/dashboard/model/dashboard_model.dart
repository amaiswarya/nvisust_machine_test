import 'package:json_annotation/json_annotation.dart';

part 'dashboard_model.g.dart';

@JsonSerializable()
class DashboardModel {
  String? date;
  bool isLeave;
  @JsonKey(name: 'login_data')
  AttendanceModel? loginData;
  @JsonKey(name: 'leave_data')
  LeaveModel? leaveData;

  DashboardModel(
      {this.date, required this.isLeave, this.loginData, this.leaveData});

  // Factory method for JSON serialization
  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardModelToJson(this);
}

@JsonSerializable()
class AttendanceModel {
  String? duration;
  String? loginTime;
  String? logoutTime;
  AttendanceModel({
    this.loginTime,
    this.duration,
    this.logoutTime,
  });

  // Factory method for JSON serialization
  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);
}

@JsonSerializable()
class LeaveModel {
  String? startDate;
  String? endDate;
  String? reason;
  String? leaveType;
  bool? isApproved;
  LeaveModel(
      {this.startDate,
      this.endDate,
      this.reason,
      this.leaveType,
      this.isApproved});

  // Factory method for JSON serialization
  factory LeaveModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveModelToJson(this);
}
