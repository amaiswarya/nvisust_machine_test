import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime? {
  String toFormattedString({String fallback = "Select"}) {
    try {
      if (this == null) return fallback;
      return DateFormat('dd-MM-yyyy').format(this!);
    } catch (e) {
      return fallback;
    }
  }
}
