import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:travelgo/services/history_service.dart';
import 'package:travelgo/services/user_service.dart';
import 'package:travelgo/shared/theme.dart';

import '../../../models/history_model.dart';

class HistoryPage extends StatefulWidget {
  // final String userId;
  const HistoryPage({super.key, 
  // required this.
  });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  Future<List<History>> _getHistory() async {
    int userid = await getUserId();
    return getHistory(userid);
  }

  @override
  Widget build(BuildContext context) {
    // String userId = widget.userId;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: defaultMargin),
        child: Column(
          children: [
            Text(
              "HISTORY",
              style: blackTextStyle.copyWith(
                  fontWeight: semibold, fontSize: 24, letterSpacing: 3),
            ),
            SizedBox(
              height: 32,
            ),
            Expanded(
              child: FutureBuilder<List<History>>(
                future: _getHistory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: warnaCoklat,),
                    );
                  }

                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Empty"),
                    );
                  }

                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: warnaCoklat),
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius)),
                              child: ListTile(
                                title: Text(
                                  snapshot.data![index].transactionStatus,
                                  style: blackTextStyle.copyWith(
                                      fontWeight: semibold, fontSize: 16),
                                ),
                                subtitle: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       "Paket Travel", style: greyTextStyle.copyWith(
                                    //         fontWeight: medium),
                                    //     ),
                                    //     Text(
                                    //       snapshot.data![index].travelPackagesId.toString(),
                                    //         style: greyTextStyle.copyWith(
                                    //           fontWeight: medium),
                                    //     ),
                                    //   ],
                                    // ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Transaksi", style: greyTextStyle.copyWith(
                                            fontWeight: medium),
                                        ),
                                        Text(
                                          ("IDR ${snapshot.data![index].transactionTotal.toString()}"),
                                          // snapshot.data![index].transactionTotal.toString(),
                                            style: greyTextStyle.copyWith(
                                              fontWeight: medium),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tanggal Transaksi", style: greyTextStyle.copyWith(
                                            fontWeight: medium),
                                        ),
                                        Text(
                                          DateFormat.yMMMMd().add_jm()
                                            .format(snapshot.data![index].updatedAt),
                                          style: greyTextStyle.copyWith(
                                            fontWeight: medium),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: snapshot
                                            .data![index].transactionStatus ==
                                        "SUCCESS"
                                    ? Icon(
                                        Iconsax.tick_circle,
                                        color: Colors.green,
                                      )
                                    : snapshot.data![index].transactionStatus ==
                                            "PENDING"
                                        ? Icon(
                                            Iconsax.clock,
                                            color: Colors.orange,
                                          )
                                        : Icon(
                                            Iconsax.close_circle,
                                            color: Colors.red,
                                          ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            )
                          ],
                        );
                      });
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
