import 'package:flutter/material.dart';

Future<DateTime?> showDatePickerDialog(
    BuildContext context, DateTime? initialDate) async {
  return await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: initialDate ?? DateTime.now(),
    lastDate: DateTime(2026),
  );
}
