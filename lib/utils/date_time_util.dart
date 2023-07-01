import 'package:intl/intl.dart';

/// Get the date in MMM dd, yyyy format.
String getDateInyMMMdFormat(DateTime dateTime) {
  String formattedDate = DateFormat.yMMMd().format(dateTime);

  return formattedDate;
}

/// Get the time in hh:mm a format.
String getTimeInhhmmaFormat(DateTime dateTime) {
  String formattedTime = DateFormat('hh:mm a').format(dateTime);

  return formattedTime;
}

/// Get the date in dd MMM yyyy format.
String getDateInddMMMyyyyFormat(DateTime dateTime) {
  String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);

  return formattedDate;
}

/// Get the next Monday from the current date.
DateTime getNextMonday(DateTime currentDate) {
  int daysUntilNextMonday = DateTime.monday - currentDate.weekday;
  if (daysUntilNextMonday <= 0) {
    // If the current date is already Monday or after Monday,
    // move to the next week.
    daysUntilNextMonday += 7;
  }
  return currentDate.add(Duration(days: daysUntilNextMonday));
}
