import 'package:intl/intl.dart';

final _dateFormat = DateFormat('yyyy-MM-dd');

/// Extension on [DateTime] to convert to a string in the format yyyy-MM-dd.
extension DateTimeFormat on DateTime {
  /// Converts the [DateTime] to a string in the format yyyy-MM-dd.
  String formatDate() => _dateFormat.format(this);
}
