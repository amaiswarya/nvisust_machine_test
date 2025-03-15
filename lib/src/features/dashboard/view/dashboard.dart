import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nvisust_test/src/core/constants/text_constants.dart';
import 'package:nvisust_test/src/core/utils/extensions/spacing_extension.dart';
import 'package:nvisust_test/src/core/utils/styles/text_styles.dart';
import 'package:nvisust_test/src/features/dashboard/widget/circular_progress_indicator.dart';

@RoutePage()
class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            40.height,
            Text(
              TextConstants.welcomeDashboard,
              style: TextStyles.black_24_600,
            ),
            50.height,
            CustomProgressIndicator(),
            100.height,
            Text("Attendance Status:Punchin")
          ],
        ),
      ),
    );
  }
}
