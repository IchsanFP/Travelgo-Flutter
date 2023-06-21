import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelgo/models/vendor_transaction_model.dart';
import 'package:travelgo/services/detail_transaction_service.dart';
import 'package:travelgo/shared/theme.dart';

import '../../../models/package_model.dart';
import '../../../services/transaction_service.dart';

class DetailPackagePage extends StatefulWidget {
  final Package package;
  const DetailPackagePage({super.key, required this.package});

  @override
  State<DetailPackagePage> createState() => _DetailPackagePageState();
}

class _DetailPackagePageState extends State<DetailPackagePage> {
  @override
  Widget build(BuildContext context) {
    Package package = widget.package;

    return Scaffold(
      backgroundColor: warnaBg,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: warnaHitam,
        ),
        backgroundColor: warnaBg,
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: warnaCoklat,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    package.title,
                    textAlign: TextAlign.center,
                    style: whiteTextStyle.copyWith(
                        fontWeight: semibold, fontSize: 24, letterSpacing: 3),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Location : ",
                            style: titleTextStyle,
                          ),
                          Text(
                            "Departure : ",
                            style: titleTextStyle,
                          ),
                          Text(
                            "Duration : ",
                            style: titleTextStyle,
                          ),
                          Text(
                            "Type : ",
                            style: titleTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            package.location,
                            style: dataTextStyle,
                          ),
                          Text(
                            DateFormat.yMMMMd().format(package.departureDate),
                            style: dataTextStyle,
                          ),
                          Text(
                            package.duration,
                            style: dataTextStyle,
                          ),
                          Text(
                            package.type,
                            style: dataTextStyle,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: FutureBuilder<List<VendorTransaction>>(
                future: getTransactionById(package.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: warnaCoklat,
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Empty"),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "MEMBERS",
                            style: blackTextStyle.copyWith(
                                fontSize: 16, fontWeight: semibold),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          generateDetail(snapshot.data![index].id)
                          // FutureBuilder<List<VendorTransactionDetail>>(
                          //   future: getDetailTransactionById(
                          //       snapshot.data![index].id),
                          //   builder: (context, data) {
                          //     if (data.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return Center(
                          //         child: CircularProgressIndicator(
                          //           color: warnaCoklat,
                          //         ),
                          //       );
                          //     }

                          //     if (!data.hasData) {
                          //       return Center(
                          //         child: Text("Empty"),
                          //       );
                          //     }

                          //     return ListView.builder(
                          //       shrinkWrap: true,
                          //       itemCount: data.data!.length,
                          //       scrollDirection: Axis.vertical,
                          //       itemBuilder: (context, i) {
                          //         return ListTile(
                          //           leading: CircleAvatar(
                          //             backgroundColor: warnaAbu,
                          //             child: Text(
                          //               data.data![i].name[0],
                          //               style: blackTextStyle,
                          //             ),
                          //           ),
                          //           title: Text(
                          //             data.data![i].name,
                          //             style: blackTextStyle.copyWith(
                          //                 fontSize: 16, fontWeight: medium),
                          //           ),
                          //           subtitle: Text(
                          //             "NIK : ${data.data![i].nik_ktp}",
                          //             style: greyTextStyle.copyWith(
                          //               fontSize: 14,
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //     );
                          //   },
                          // ),
                        ],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }

  TextStyle titleTextStyle =
      whiteTextStyle.copyWith(fontSize: 16, fontWeight: semibold);
  TextStyle dataTextStyle = whiteTextStyle.copyWith(fontSize: 16);

  FutureBuilder<List<VendorTransactionDetail>> generateDetail(int id) {
    return FutureBuilder<List<VendorTransactionDetail>>(
      future: getDetailTransactionById(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: warnaCoklat,
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text("Empty"),
          );
        }
        print(snapshot.data!.length);

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, i) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: warnaAbu,
                child: Text(
                  snapshot.data![i].name[0],
                  style: blackTextStyle,
                ),
              ),
              title: Text(
                snapshot.data![i].name,
                style:
                    blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              ),
              subtitle: Text(
                "NIK : ${snapshot.data![i].nik_ktp}",
                style: greyTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
