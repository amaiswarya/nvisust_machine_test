import 'package:dartz/dartz.dart';
import 'package:nvisust_test/src/core/utils/shared_utils/preference_utils.dart';
import 'package:nvisust_test/src/features/dashboard/model/dashboard_model.dart';
import 'package:nvisust_test/src/services/base_response/base_reponse.dart';
import 'package:nvisust_test/src/services/firebase_services.dart';

abstract class DashboardRepo {
  Future<Either<Failure, bool>> markAttendance(
      String date, bool isLeave, AttendanceModel data);
  Future<Either<Failure, bool>> markLeave(bool isLeave, LeaveModel data);

  Future<Either<Failure, LeaveResponse>> getLeaveList();

  Future<Either<Failure, bool>> isExist(String date);
  Future<Either<Failure, DashboardModel>> getDocument(String date);
  Future<Either<Failure, bool>> updatePunchout(
      String date, Map<String, dynamic> data);
}

final FirebaseServices _firebaseServices = FirebaseServices();

class DashboardRepoImplements extends DashboardRepo {
  @override
  Future<Either<Failure, bool>> markAttendance(
      String date, bool isLeave, AttendanceModel data) async {
    try {
      final result = await _firebaseServices.setSubDocument(
          "users",
          "attendance",
          SharedUtils.getUUID,
          date,
          {"date": date, "is_leave": isLeave, "login_data": data.toJson()});
      return result.fold((failure) => Left(failure), (docs) => Right(true));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> markLeave(bool isLeave, LeaveModel data) async {
    try {
      final result = await _firebaseServices.setSubDocument(
          "users", "attendance", SharedUtils.getUUID, data.startDate ?? "", {
        "date": data.startDate ?? "",
        "is_leave": isLeave,
        "leave_data": data.toJson()
      });
      return result.fold((failure) => Left(failure), (docs) => Right(true));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LeaveResponse>> getLeaveList() async {
    try {
      final result = await _firebaseServices.getSubCollectionAsList(
        "users",
        "attendance",
        SharedUtils.getUUID,
      );

      return result.fold((failure) => Left(failure), (docs) {
        LeaveResponse data = LeaveResponse.fromJson(docs);
        print(data);
        return Right(data);
      });
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isExist(String date) async {
    try {
      final result = await _firebaseServices.checkIfDocumentExists(
          "users", SharedUtils.getUUID, "attendance", date);

      return result.fold((failure) => Left(failure), (exist) => Right(exist));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DashboardModel>> getDocument(String date) async {
    try {
      final result = await _firebaseServices.getDocument(
          "users", SharedUtils.getUUID, "attendance", date);

      return result.fold((failure) => Left(failure),
          (data) => Right(DashboardModel.fromJson(data)));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updatePunchout(
      String date, Map<String, dynamic> data) async {
    try {
      final result = await _firebaseServices.updateData(
          "users", SharedUtils.getUUID, "attendance", date, data);

      return result.fold((failure) => Left(failure), (exist) => Right(true));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
