import 'dart:io';
import 'package:cashtrack/cah.dart';
import 'package:cashtrack/cashcontroller.dart';
import 'package:cashtrack/pdf_report.dart';
import 'package:cashtrack/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TransactionController controller = Get.put(TransactionController());

  TextEditingController amountController = TextEditingController();
  String? dropdownValue;
  int amount = 0;

  bool showdata = true;
  List<String> cashtype = <String>['50', '100', '200', '500', '1000'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FB),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("My Cash"),
        actions: <Widget>[
          ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  elevation: MaterialStateProperty.all(0)),
              icon: const Icon(
                Icons.share,
                color: Color(0xFF4C6FFF),
                semanticLabel: "Share",
              ),
              onPressed: () async {
                File pdfFile =
                    await PDFGenerator.generateInvoice(controller.transactions);

                controller.transactions.isEmpty
                    ? null
                    : await Share.shareFiles([pdfFile.path],
                        text: 'Sharing PDF file');
              },
              label: const Text(
                'Share',
                style: TextStyle(
                  color: Color(0xFF4C6FFF),
                ),
              ))
        ],
      ),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.all(8),
          height: 100,
          width: 300,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                offset: const Offset(0, 0),
                color: const Color(0xFF323247).withOpacity(0.25),
              ),
              BoxShadow(
                blurRadius: 1,
                offset: const Offset(0, 1),
                color: const Color(0xFF323247).withOpacity(0.05),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Dhaqdhaqaaqa Lacagta",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7A7A9D)),
                        ),
                        Obx(
                          () => Text(
                            '${controller.transactions.isEmpty ? 0 : Utils.formatLongDigitNumber(Utils.calculateTotal(controller.transactions))}',
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF27272E),
                                fontFamily: 'inter'),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                                width: 55,
                                height: 24,
                                decoration: const BoxDecoration(
                                    color: Color(0xFFDEFFEE)),
                                child: const Center(
                                  child: Text(
                                    "Wadarta",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF66CB9F)),
                                  ),
                                )),
                            const SizedBox(
                              width: 8,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ]),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 24),
                child: Icon(
                  Icons.account_balance_wallet,
                  size: 48,
                  color: Color(0xFF4C6FFF),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Cahs histroy",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7A7A9D)),
              ),
              TextButton(
                onPressed: () {
                  controller.removeAllTransactions();
                },
                child: const Text(
                  "Clear All",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Obx(
            () => ListView.builder(
              itemCount: controller.transactions.length,
              itemBuilder: (context, index) {
                Cash transaction = controller.transactions[index];
                return Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        offset: const Offset(0, 0),
                        color: const Color(0xFF323247).withOpacity(0.25),
                      ),
                      BoxShadow(
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                        color: const Color(0xFF323247).withOpacity(0.05),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Nooca",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF27272E),
                            ),
                          ),
                          Text(
                            '${transaction.cashtype}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7A7A9D),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Warqadood",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF27272E),
                            ),
                          ),
                          Text(
                            '${transaction.amount}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7A7A9D),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Wadarta",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF27272E),
                            ),
                          ),
                          Container(
                            height: 24,
                            padding: const EdgeInsets.all(4),
                            decoration:
                                const BoxDecoration(color: Color(0xFFDEFFEE)),
                            child: Center(
                              child: Text(
                                '${Utils.formatLongDigitNumber(transaction.total)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF66CB9F),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          controller.removeTransaction(index);
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.redAccent,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            offset: const Offset(0, 0),
                            color: const Color(0xFF323247).withOpacity(0.25),
                          ),
                          BoxShadow(
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                            color: const Color(0xFF323247).withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 14),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFE0E0E0)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF4C6FFF)),
                                    ),
                                    fillColor: Color(0xFFF1F1F1),
                                    hintText: 'Nooca Lacagta',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFAEAEAE),
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  items: cashtype.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropdownValue = value;
                                      updateAmount();
                                    });
                                  }),
                              const SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                controller: amountController,
                                autofocus: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'geli tirada';
                                  }
                                  return null;
                                },
                                onChanged: (String value) {
                                  setState(() {
                                    amount = dropdownValue != null
                                        ? int.parse(dropdownValue!) *
                                            (int.parse(
                                                amountController.text.isEmpty
                                                    ? '0'
                                                    : amountController.text))
                                        : 0;
                                  });
                                },
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                cursorColor: const Color(0xFF303030),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 14),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFE0E0E0)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF4C6FFF)),
                                  ),
                                  fillColor: Color(0xFFF1F1F1),
                                  hintText: 'Tirada',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFAEAEAE),
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Wadarta lacagta"),
                                  Text(
                                    '$amount',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF66CB9F),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (dropdownValue != null &&
                                          amountController.text.isNotEmpty) {
                                        int amount =
                                            int.parse(amountController.text);
                                        Cash newTransaction = Cash(
                                          cashtype: int.parse(dropdownValue!),
                                          amount: amount,
                                          total: amount *
                                              int.parse(dropdownValue!),
                                        );

                                        controller
                                            .addTransaction(newTransaction);

                                        _formKey.currentState!.reset();
                                        amountController.clear();
                                        dropdownValue = null;
                                        updateAmount();
                                      }
                                    }
                                  },
                                  child: const Text("Ku dar"),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    backgroundColor: const Color(
                                      0xFF4C6FFF,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )));
        },
        backgroundColor: const Color(0xFF4C6FFF),
        elevation: 0.5,
        child: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );
  }

  void updateAmount() {
    if (dropdownValue != null && amountController.text.isNotEmpty) {
      setState(() {
        amount = int.parse(dropdownValue!) * int.parse(amountController.text);
      });
    }
  }
}
