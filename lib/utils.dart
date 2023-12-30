import 'package:cashtrack/cah.dart';
import 'package:intl/intl.dart';

class Utils {
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
  static formatLongDigitNumber(dynamic number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  static int calculateTotal(List<Cash> cashList) {
    int total = 0;
    for (Cash cash in cashList) {
      total += cash.total;
    }
    return total;
  }
}
