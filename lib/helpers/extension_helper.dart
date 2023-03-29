import 'package:intl/intl.dart';

extension ParseDateTime on DateTime {
  String get formatToDate {
    final formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(this);
    return formatted;
  }
}
