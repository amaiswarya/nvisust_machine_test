// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nvisust_test/src/core/common_widgets/custom_textform_field.dart';
import 'package:nvisust_test/src/core/common_widgets/primary_button.dart';
import 'package:nvisust_test/src/core/utils/extensions/date_extentions.dart';
import 'package:nvisust_test/src/core/utils/extensions/spacing_extension.dart';
import 'package:nvisust_test/src/core/utils/helpers/toast.dart';
import 'package:nvisust_test/src/core/utils/styles/app_colors.dart';
import 'package:nvisust_test/src/features/dashboard/model/dashboard_model.dart';
import 'package:nvisust_test/src/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:nvisust_test/src/features/leave_management/widgets/date_widget.dart';
import 'package:nvisust_test/src/features/leave_management/widgets/dialogues/date_picker.dart';
import 'package:nvisust_test/src/features/leave_management/widgets/dialogues/leave_type_sheet.dart';

@RoutePage()
class ApplyLeave extends StatefulWidget {
  const ApplyLeave({super.key});

  @override
  State<ApplyLeave> createState() => _ApplyLeaveState();
}

class _ApplyLeaveState extends State<ApplyLeave> {
  final TextEditingController reasonController = TextEditingController();
  final dashboardViewModel = DashboardViewModel();
  String? leaveTYpe;
  DateTime? startDate;
  DateTime? endDate;
  void _openLeaveSheet(BuildContext context) async {
    String? selectedType = await showLeaveTypeSheet(context);
    if (selectedType != null) {
      leaveTYpe = selectedType;
      setState(() {});
    }
  }

  _selectStartDate() async {
    DateTime? selectedType = await showDatePickerDialog(context, null);
    if (selectedType != null) {
      startDate = selectedType;
      setState(() {});
    }
  }

  _selectEndDate() async {
    if (startDate != null) {
      DateTime? selectedType = await showDatePickerDialog(context, startDate);
      if (selectedType != null) {
        endDate = selectedType;
        setState(() {});
      }
    } else {
      showErrorToast("Choose start date");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply Leave"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select leave type",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            8.height,
            GestureDetector(
              onTap: () {
                _openLeaveSheet(context);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.blackSecondary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(leaveTYpe ?? "Select type"),
                    Icon(Icons.arrow_drop_down, color: AppColors.primary),
                  ],
                ),
              ),
            ),
            16.height,
            Row(
              children: [
                Expanded(
                  child: DateWidget(
                      onTap: () {
                        _selectStartDate();
                      },
                      text: "Start Date",
                      date: startDate.toFormattedString()),
                ),
                12.width,
                Expanded(
                  child: DateWidget(
                      onTap: () {
                        _selectEndDate();
                      },
                      text: "End Date",
                      date: endDate.toFormattedString()),
                )
              ],
            ),
            16.height,
            Text("Reason",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            CustomTextformField(
              hintText: 'Reason',
              type: InputTypes.long,
              controller: reasonController,
            ),
            16.height,
            ButtonWidget.primary(
                onTap: () async {
                  if (leaveTYpe == null) {
                    showErrorToast("Leave type is manadatory");
                  } else if (startDate == null) {
                    showErrorToast("Start date is manadatory");
                  } else if (endDate == null) {
                    showErrorToast("End date is manadatory");
                  } else if (reasonController.text.isEmpty) {
                    showErrorToast("Reason is manadatory");
                  } else {
                    await dashboardViewModel
                        .markLeave(LeaveModel(
                          startDate: startDate.toFormattedString(),
                          endDate: endDate.toFormattedString(),
                          reason: reasonController.text.trim(),
                          status: "Pending",
                          leaveType: leaveTYpe,
                        ))
                        .whenComplete(() => context.maybePop());
                  }
                },
                text: "Apply Leave")
          ],
        ),
      ),
    );
  }
}
