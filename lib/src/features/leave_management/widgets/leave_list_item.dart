import 'package:flutter/material.dart';
import 'package:nvisust_test/src/core/utils/styles/app_colors.dart';

class LeaveItem extends StatefulWidget {
  final String leaveType;
  final String startDate;
  final String endDate;
  final String reason;
  final String status;

  const LeaveItem({
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    super.key,
  });

  @override
  _LeaveItemState createState() => _LeaveItemState();
}

class _LeaveItemState extends State<LeaveItem> {
  bool _isExpanded = false; // Track expansion state

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded; // Toggle expand/collapse
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statusBadge(widget.status),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey[600],
                  ),
                ],
              ),

              SizedBox(height: 10),

              // Date Row (Always Visible)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _dateTile(
                      Icons.calendar_today, "Start Date", widget.startDate),
                  _dateTile(Icons.calendar_today, "End Date", widget.endDate),
                ],
              ),

              // Expanded Content (Only visible when expanded)
              if (_isExpanded) ...[
                SizedBox(height: 12),

                // Leave Type
                Text(
                  "Leave type",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.whiteSec,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.leaveType.isEmpty ? ' - ' : widget.leaveType,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Reason
                Text(
                  "Reason",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(widget.reason,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Status Badge Widget
  Widget _statusBadge(String status) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case "approved":
        statusColor = Colors.green;
        break;
      case "rejected":
        statusColor = Colors.red;
        break;
      case "pending":
      default:
        statusColor = Colors.orange;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: statusColor,
        ),
      ),
    );
  }

  // Date Tile Widget
  Widget _dateTile(IconData icon, String label, String date) {
    return Row(
      children: [
        SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            Text(date,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}
