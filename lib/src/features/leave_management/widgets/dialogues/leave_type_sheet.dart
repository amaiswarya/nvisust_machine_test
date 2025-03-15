import 'package:flutter/material.dart';

Future<String?> showLeaveTypeSheet(BuildContext context) async {
  return await showModalBottomSheet<String>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      List<String> leaveTypes = ["Sick", "Casual", "Unpaid"];
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: leaveTypes
              .map((type) => ListTile(
                    title: Text(type),
                    onTap: () {
                      Navigator.pop(context, type);
                    },
                  ))
              .toList(),
        ),
      );
    },
  );
}
