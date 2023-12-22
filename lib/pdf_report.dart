import 'dart:io';
import 'package:cashtrack/cah.dart';
import 'package:cashtrack/utils.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class PDFGenerator {
  static Future<File> generateInvoice(List<Cash> transactions) async {
    final pdf = pw.Document();

    final fontRegular =
        await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
    final fontBold = await rootBundle.load("assets/fonts/OpenSans-Bold.ttf");
    final fontItalic =
        await rootBundle.load("assets/fonts/OpenSans-Italic.ttf");
    final fontBoldItalic =
        await rootBundle.load("assets/fonts/OpenSans-BoldItalic.ttf");

    pdf.addPage(pw.MultiPage(
        theme: pw.ThemeData.withFont(
          base: pw.Font.ttf(fontRegular),
          bold: pw.Font.ttf(fontBold),
          italic: pw.Font.ttf(fontItalic),
          boldItalic: pw.Font.ttf(fontBoldItalic),
        ),
        build: (context) => [
              buildTitle(),
              buildInvoice(transactions),
              pw.Divider(),
              buildTotal(transactions)
            ]));

    final appDocDir = await getApplicationDocumentsDirectory();

    final pdfPath =
        "${appDocDir.path}/'cash-${DateFormat('y-M-d').format(DateTime.now())}.pdf";

    final file = File(pdfPath);
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  static pw.Column buildTitle() =>
      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(
          'Report',
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
        pw.Text('Date: ${Utils.formatDate(DateTime.now())}'),
        pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
      ]);

  static pw.Column buildInvoice(List<Cash> transactions) {
    final data = transactions.map((transaction) {
      return [
        transaction.cashtype,
        Utils.formatLongDigitNumber(transaction.amount),
        Utils.formatLongDigitNumber(transaction.total),
      ];
    }).toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Cashes',
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
        pw.Table.fromTextArray(
          headers: ['Nooca', 'Warqadood', 'Wadarta'],
          data: data,
          border: null,
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
          cellHeight: 30,
          cellAlignments: {
            0: pw.Alignment.centerLeft,
            1: pw.Alignment.centerRight,
            2: pw.Alignment.centerRight,
          },
        ),
      ],
    );
  }

  static pw.Container buildTotal(List<Cash> transactions) {
    final total = Utils.calculateTotal(transactions);

    return pw.Container(
      alignment: pw.Alignment.centerRight,
      child: pw.Row(
        children: [
          pw.Spacer(flex: 6),
          pw.Expanded(
            flex: 4,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Wadarta Lacagta',
                  titleStyle: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  value: Utils.formatLongDigitNumber(total),
                  unite: true,
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Container(height: 1, color: PdfColors.grey400),
                pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                pw.Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget buildText({
    required String title,
    required String value,
    double width = double.infinity,
    pw.TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);

    return pw.Container(
      width: width,
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(title, style: style)),
          pw.Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
