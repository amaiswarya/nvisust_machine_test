import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String toFormattedString() {
    return DateFormat('dd-MM-yyyy').format(this);
  }
}
