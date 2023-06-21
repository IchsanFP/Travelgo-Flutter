import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelgo/ui/pages/vendor/package_detail.dart';

import '../../../models/package_model.dart';
import '../../../services/user_service.dart';
import '../../../services/vendor_service.dart';
import '../../../shared/theme.dart';

class PaketTravelPage extends StatefulWidget {
  const PaketTravelPage({super.key});

  @override
  State<PaketTravelPage> createState() => _PaketTravelPageState();
}

class _PaketTravelPageState extends State<PaketTravelPage> {
  Future<List<Package>> _getPackages() async {
    int userid = await getUserId();
    return getVendorPackages(userid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            Text(
              "TRAVEL PACKAGES",
              style: blackTextStyle.copyWith(
                  fontWeight: semibold, fontSize: 24, letterSpacing: 3),
            ),
            SizedBox(
              height: 16,
            ),
            FutureBuilder(
              future: _getPackages(),
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
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPackagePage(package: snapshot.data![index],)));
                        },
                        child: Card(
                          margin: EdgeInsets.only(bottom: 16),
                          shadowColor: warnaCoklat,
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.all(defaultMargin),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].title,
                                          style: blackTextStyle.copyWith(
                                              fontWeight: semibold, fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          snapshot.data![index].location,
                                          style: blackTextStyle.copyWith(
                                              fontWeight: medium, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  height: 2,
                                  width: double.infinity,
                                  decoration: BoxDecoration(color: warnaAbu),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Duration",
                                          style: titleFontStyle,
                                        ),
                                        Text(
                                          snapshot.data![index].duration,
                                          style: blackTextStyle,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Departure",
                                          style: titleFontStyle,
                                        ),
                                        Text(
                                          DateFormat.yMMMMd().format(snapshot
                                              .data![index].departureDate),
                                          style: blackTextStyle,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Type",
                                          style: titleFontStyle,
                                        ),
                                        Text(
                                          snapshot.data![index].type,
                                          style: blackTextStyle,
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      )),
    );
  }

  TextStyle titleFontStyle = blackTextStyle.copyWith(fontWeight: semibold);
}
