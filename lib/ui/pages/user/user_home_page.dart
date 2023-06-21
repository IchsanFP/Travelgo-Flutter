import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travelgo/models/package_model.dart';
import 'package:travelgo/services/home_page_service.dart';
import 'package:travelgo/ui/pages/user/user_detail_page.dart';

import '../../../models/user_model.dart';
import '../../../services/user_service.dart';
import '../../../shared/api_response.dart';
import '../../../shared/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                Text(
                  "PACKAGES",
                  style: blackTextStyle.copyWith(
                      fontWeight: semibold, fontSize: 24, letterSpacing: 3),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(defaultMargin),
                    child: FutureBuilder<List<Package>>(
                        future: HomePageService().getTravelPackage(), //untuk memanggi
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) { //untuk mengecek apakah koneksi dalam keadaan waiting
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (!snapshot.hasData) {
                            return Center(
                              child: Text("Empty"),
                            );
                          }

                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              User vendor = User(id: 999, name: "xxx", email: "xxx", role: "xxx");

                              Future<void> fetchUser() async {
                                ApiResponse res = await fetchUserById(snapshot.data![index].vendorId);
                                if (res.error == null) {
                                  vendor = res.data as User;
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("${res.error}")));
                                }
                              }

                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await fetchUser();
                                      print(vendor.name);

                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: DetailPage(
                                                arguments:
                                                    snapshot.data![index],
                                                vendor: vendor,
                                              ),
                                              type: PageTransitionType
                                                  .rightToLeftWithFade,
                                              duration:
                                                  Duration(milliseconds: 400),
                                              reverseDuration:
                                                  Duration(milliseconds: 400)));
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                            height: 200,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(snapshot
                                                        .data![index]
                                                        .galleries[0]
                                                        .image),
                                                    fit: BoxFit.cover),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        defaultRadius))),
                                        Container(
                                          height: 200,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      defaultRadius),
                                              gradient: LinearGradient(
                                                  end: Alignment.topCenter,
                                                  begin: Alignment.bottomCenter,
                                                  colors: [
                                                    warnaHitam.withOpacity(0.5),
                                                    Colors.transparent
                                                  ])),
                                        ),
                                        SizedBox(
                                          height: 200,
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                snapshot.data![index].title,
                                                style: whiteTextStyle.copyWith(
                                                    fontSize: 24),
                                              ),
                                              Text(
                                                snapshot.data![index].location,
                                                style: whiteTextStyle.copyWith(
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 36,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    snapshot.data![index].type,
                                                    style: whiteTextStyle,
                                                  ),
                                                  Text(
                                                    ("IDR ${snapshot.data![index].price}"),
                                                    style: whiteTextStyle,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  )
                                ],
                              );
                            },
                          );
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
