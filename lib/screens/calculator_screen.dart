import 'dart:math';
import 'package:cashtrack/invoice.dart';
import 'package:cashtrack/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final List<Invoice> invoices = <Invoice>[];
  final List<TextEditingController> _quantityControllers = [];
  final List<TextEditingController> _priceControllers = [];
  final TextEditingController _reminderController = TextEditingController();
  double total = 0;
  double payedAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cash",
            style: TextStyle(
                color: Color(0xFF4C6FFF),
                fontSize: 24,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // showAboutDialog(context: context, applicationName: 'Fududeeye');
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("My Cash",
                              style: TextStyle(
                                  color: Color(0xFF4C6FFF),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // You can adjust the radius as needed
                          ),
                          content: SizedBox(
                            height: 175,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Fududeeye waa application ka caawinayo ganacsiyada yar-yar hab xisaabinta",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Kala xiriir waxii macluumad ah',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.mail,
                                        size: 16,
                                        color: Color(0xFF4C6FFF),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'attacktorr@gmail.com',
                                        style: TextStyle(
                                          color: Color(0xFF4C6FFF),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.call,
                                        size: 16,
                                        color: Color(0xFF4C6FFF),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          UrlLauncher.launch(
                                              "tel://252616578667");
                                        },
                                        child: Text('+252616578667',
                                            style: TextStyle(
                                                color: Color(0xFF4C6FFF))),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        ));
              },
              icon: Icon(
                Icons.info,
                color: Color(0xFF4C6FFF),
              ))
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF7F8FB),
        ),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 300,
              decoration: BoxDecoration(
                color: const Color(0xFF4C6FFF),
                borderRadius: BorderRadius.circular(8),
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
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Wadarta ",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            Text(
                              '${Utils.formatLongDigitNumber(total)}',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ]),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 8, left: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        // borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Reesto",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '${Utils.formatLongDigitNumber(payedAmount - total)}',
                            style: TextStyle(
                                // color: (payedAmount - total) < 0
                                //     ? Colors.red
                                //     : Colors.green,
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w900),
                          ),
                          // SizedBox(height: 2),
                          // Container(height: 1, color: Colors.grey[400]),
                          // SizedBox(height: 1),
                          // Container(height: 1.5, color: Colors.grey[400]),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: invoices.length,
                itemBuilder: (context, index) {
                  final _invoice = invoices[index];
                  return Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 64,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _getQuantityController(index),
                            onChanged: (val) {
                              if (val.isNotEmpty) {
                                setState(() {
                                  invoices[index].quantity = int.parse(val);
                                  total = CalculatteTotal(invoices);
                                });

                                _getQuantityController(index).text = val;
                              }
                            },
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'cadadka',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Text('X',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(width: 14),
                        SizedBox(
                          width: 64,
                          child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            controller: _getPriceController(index),
                            onChanged: (val) {
                              if (val.isNotEmpty) {
                                setState(() {
                                  invoices[index].price = double.parse(val);
                                  total = CalculatteTotal(invoices);
                                });
                                _getPriceController(index).text = val;
                              }
                            },
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Qiimaha',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const Center(
                          child: Text('=',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        Center(
                          child: Text(
                            '${Utils.formatLongDigitNumber(_invoice.quantity * _invoice.price)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              invoices.removeAt(index);
                              _quantityControllers.removeAt(index);
                              _priceControllers.removeAt(index);
                              total =
                                  total - (_invoice.quantity * _invoice.price);
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      width: 150,
                      child: TextField(
                        cursorColor: Color(0xFF4C6FFF),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        controller: _reminderController,
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            setState(() {
                              payedAmount = double.parse(val);
                            });
                            _reminderController.text = val;
                          }
                        },
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: const InputDecoration(
                          // border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFE0E0E0), width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF4C6FFF), width: 2),
                          ),
                          contentPadding: EdgeInsets.only(left: 8),
                          hintText: 'Lacagta la bxixiyey',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            // fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final invoice = Invoice(quantity: 0, price: 0);
          setState(() {
            invoices.add(invoice);
          });
        },
        backgroundColor: const Color(0xFF4C6FFF),
        elevation: 0.5,
        child: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );
  }

  // Helper method to get a unique quantity controller for each index
  TextEditingController _getQuantityController(int index) {
    while (_quantityControllers.length <= index) {
      _quantityControllers.add(TextEditingController());
    }
    return _quantityControllers[index];
  }

  // Helper method to get a unique price controller for each index
  TextEditingController _getPriceController(int index) {
    while (_priceControllers.length <= index) {
      _priceControllers.add(TextEditingController());
    }
    return _priceControllers[index];
  }

  double CalculatteTotal(List<Invoice> invoices) {
    double total = 0;
    for (Invoice invoice in invoices) {
      total += invoice.price * invoice.quantity;
    }
    return total;
  }
}
