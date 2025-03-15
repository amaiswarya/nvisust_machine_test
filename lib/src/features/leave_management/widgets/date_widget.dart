import 'package:flutter/material.dart';
import 'package:nvisust_test/src/core/utils/extensions/spacing_extension.dart';
import 'package:nvisust_test/src/core/utils/styles/app_colors.dart';

class DateWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String date;
  const DateWidget({
    super.key,
    required this.onTap,
    required this.text,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      8.height,
      GestureDetector(
        onTap: () => onTap(),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.blackSecondary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date),
              Icon(Icons.calendar_today, size: 20, color: AppColors.primary),
            ],
          ),
        ),
      ),
    ]);
  }
}
