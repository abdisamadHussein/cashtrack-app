import 'package:cashtrack/cah.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  RxList<Cash> transactions = <Cash>[].obs;

  void addTransaction(Cash transaction) {
    transactions.add(transaction);
  }

  void removeTransaction(int index) {
    if (index >= 0 && index < transactions.length) {
      transactions.removeAt(index);
    }
  }

  void removeAllTransactions() {
    transactions.clear();
  }
}
