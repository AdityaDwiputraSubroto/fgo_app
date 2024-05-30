import 'package:intl/intl.dart';

class TimeConversionService {
  static DateTime convertTime(
      DateTime time, String fromTimeZone, String toTimeZone) {
    Map<String, int> timeZoneOffsets = {
      'WIB': 7,
      'WITA': 8,
      'WIT': 9,
      'London (GMT)': 0,
      'London (BST)': 1,
      'JST': 9,
    };

    int fromOffset = timeZoneOffsets[fromTimeZone] ?? 0;
    int toOffset = timeZoneOffsets[toTimeZone] ?? 0;

    Duration offsetDifference = Duration(hours: toOffset - fromOffset);
    return time.add(offsetDifference);
  }

  static String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }
}
