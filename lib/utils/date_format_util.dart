import 'package:intl/intl.dart';

class DateFormatUtil{

  static String getTimeAtDateTime(String date) {
    DateTime convertDate = DateFormat('YYYY-MM-DDThh:mm:ss').parse(date);
    return DateFormat('hh:mm').format(convertDate);
  }

  static String convertDateFormat({required String date, String format='YYYY-MM-DD'}) {
    DateTime convertDate = DateFormat('YYYY-MM-DDThh:mm:ss').parse(date);
    return DateFormat(format).format(convertDate);
  }

  static String convertDateTimeForat({required String date}) {
    DateTime convertDate = DateFormat('YYYY-MM-DDThh:mm:ss').parse(date);
    return DateFormat('YYYY-MM-DD hh:mm').format(convertDate);
  }

}