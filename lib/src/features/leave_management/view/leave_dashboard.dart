import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nvisust_test/routes_manager/route_imports.gr.dart';
import 'package:nvisust_test/src/core/common_widgets/primary_button.dart';
import 'package:nvisust_test/src/core/utils/extensions/spacing_extension.dart';
import 'package:nvisust_test/src/features/dashboard/model/dashboard_model.dart';
import 'package:nvisust_test/src/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:nvisust_test/src/features/leave_management/widgets/leave_list_item.dart';

@RoutePage()
class LeaveDashboard extends StatefulWidget {
  const LeaveDashboard({super.key});

  @override
  State<LeaveDashboard> createState() => _LeaveDashboardState();
}

class _LeaveDashboardState extends State<LeaveDashboard> {
  final dashboardViewModel = DashboardViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leave management"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Applied leaves",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            12.height,
            Expanded(
              child: FutureBuilder<List<DashboardModel>>(
                  future: dashboardViewModel.getLeaveList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error fetching data"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("No leaves found"));
                    }

                    List<DashboardModel> leaves = snapshot.data ?? [];
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: leaves.length,
                        itemBuilder: (context, index) {
                          LeaveModel leave = leaves[index].leaveData!;
                          return LeaveItem(
                              leaveType: leave.leaveType ?? "-",
                              startDate: leave.startDate ?? "-",
                              endDate: leave.endDate ?? "-",
                              reason: leave.reason ?? "-",
                              status: leave.status ?? "-");
                        });
                  }),
            ),
            ButtonWidget.primary(
                onTap: () {
                  context
                      .pushRoute(ApplyLeaveRoute())
                      .whenComplete(() => setState(() {}));
                },
                text: "Apply Leave")
          ],
        ),
      ),
    );
  }
}
