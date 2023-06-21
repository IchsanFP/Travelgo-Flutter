import 'package:flutter/material.dart';
import 'package:travelgo/services/detail_transaction_service.dart';
import 'package:travelgo/services/transaction_service.dart';
import 'package:travelgo/shared/theme.dart';
import 'package:travelgo/ui/widgets/custom_button.dart';
import 'package:travelgo/ui/widgets/custom_payment_dialog.dart';

import '../../../models/transaction_model.dart';
import '../../../shared/api_response.dart';

class PaymentPage extends StatefulWidget {
  final List listGoing;
  final Transaction transaction;
  const PaymentPage(
      {super.key, required this.transaction, required this.listGoing});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Future _update(int id, String status, String message) async {
    ApiResponse res = await updateStatus(id, status);

    if (res.error == null) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return CustomPaymentDialog(
              title: message,
            );
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${res.error}")));
    }
  }

  Future makeDetailTransaction(String transactionId, List listGoing) async {
    for (int i = 0; i < listGoing.length; i++) {
      ApiResponse res = await detailTransaction(
          transactionId, listGoing[i]['name'], listGoing[i]['nik']);

      if (res.error == null) {
        print(res.data);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${res.error}")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Transaction transaction = widget.transaction;
    List listGoing = widget.listGoing;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Payment",
                style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 24),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Please upload your transfer proof to complete your payment.",
                style: blackTextStyle.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 32,
              ),
              CustomButton(
                  text: "Upload",
                  textSize: 16,
                  onPressed: () {
                    makeDetailTransaction(transaction.id.toString(), listGoing);
                    _update(transaction.id, "SUCCESS", "Payment Success.");
                  }),
              SizedBox(
                height: 16,
              ),
              TextButton(
                  onPressed: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(defaultRadius)),
                            title: Text("Are you sure you want to cancel?"),
                            content: SingleChildScrollView(
                                child: Column(
                              children: [
                                CustomButton(
                                    text: "Continue Booking",
                                    textSize: 16,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                                SizedBox(height: 16),
                                Container(
                                  width: double.infinity,
                                  height: 56,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: warnaMerah),
                                      borderRadius:
                                          BorderRadius.circular(defaultRadius)),
                                  child: TextButton(
                                      onPressed: () {
                                        _update(transaction.id, "CANCELLED",
                                            "Booking Cancelled.");
                                        Navigator.pushNamed(context, '/main');
                                      },
                                      child: Text(
                                        "Cancel Booking",
                                        style: redTextStyle.copyWith(
                                            fontWeight: medium, fontSize: 16),
                                      )),
                                )
                              ],
                            )),
                          );
                        });
                  },
                  child: Text(
                    "Cancel Booking",
                    style: brownTextStyle.copyWith(
                        fontWeight: medium,
                        fontSize: 16,
                        decoration: TextDecoration.underline),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
