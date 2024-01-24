import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String format(String dateTimeFormat) {
    return DateFormat(dateTimeFormat).format(this);
  }
}
