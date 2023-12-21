import 'package:cashtrack/cah.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  RxList<Cash> transactions = <Cash>[].obs;

  // Function to add a new transaction
  void addTransaction(Cash transaction) {
    transactions.add(transaction);
  }

  // Function to remove a specific transaction by index
  void removeTransaction(int index) {
    if (index >= 0 && index < transactions.length) {
      transactions.removeAt(index);
    }
  }

  // Function to remove all transactions
  void removeAllTransactions() {
    transactions.clear();
  }
}
