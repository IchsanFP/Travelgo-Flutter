import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travelgo/shared/theme.dart';
import 'package:travelgo/ui/pages/user/booking_page.dart';
import 'package:travelgo/ui/widgets/custom_back_button.dart';
import 'package:travelgo/ui/widgets/custom_button.dart';
import 'package:travelgo/ui/widgets/detail_book.dart';
import 'package:travelgo/ui/widgets/detail_item.dart';
import 'package:intl/intl.dart';

import '../../../models/package_model.dart';
import '../../../models/user_model.dart';
import '../../../services/user_service.dart';
import '../../../shared/api_response.dart';

class DetailPage extends StatefulWidget {
  final User vendor;
  // final int vendorId;
  final Package arguments;
  const DetailPage({super.key, required this.arguments, required this.vendor
      // required this.vendorId
      });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  User user = User(id: 999, name: "xxx", email: "email", role: "role");

  Future<void> fetchUser() async {
    ApiResponse res = await getDetailUser();
    if (res.error == null) {
      user = res.data as User;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${res.error}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    Package package = widget.arguments;
    User vendor = widget.vendor;

    return Scaffold(
        body: ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  items: package.galleries
                      .map((item) => Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(item.image),
                                    fit: BoxFit.cover)),
                          ))
                      .toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    scrollPhysics: BouncingScrollPhysics(),
                    height: 500,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
                SafeArea(
                  child: CustomBackButton(),
                ),
                SizedBox(
                    height: 470,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(child: buildIndicator(package.galleries.length)),
                      ],
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: defaultMargin,
                  right: defaultMargin,
                  bottom: 32,
                  top: defaultMargin),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.title,
                      style: blackTextStyle.copyWith(
                          fontWeight: bold, fontSize: 32),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      package.location,
                      style: greyTextStyle.copyWith(
                          fontSize: 16, fontWeight: semibold),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DetailItem(
                          title: "Featured Ticket",
                          detail: package.featuredEvent,
                          iconUrl: Icon(Iconsax.ticket),
                        ),
                        DetailItem(
                          title: "Language",
                          detail: package.language,
                          iconUrl: Icon(Iconsax.messages),
                        ),
                        DetailItem(
                          title: "Foods",
                          detail: package.foods,
                          iconUrl: Icon(Iconsax.shop),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "About",
                      style: blackTextStyle.copyWith(
                          fontSize: 16, fontWeight: semibold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      package.about,
                      style: blackTextStyle,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: warnaCoklat),
                          borderRadius: BorderRadius.circular(defaultRadius)),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Text(
                              "Travel Vendor",
                              style: blackTextStyle.copyWith(
                                  fontSize: 16, fontWeight: semibold),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              vendor.name,
                              // "halo",
                              style:
                                  greyTextStyle.copyWith(fontWeight: semibold),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            DetailBook(
                                title: "Departure",
                                detail: DateFormat.yMMMMd()
                                    .format(package.departureDate)),
                            DetailBook(
                                title: "Duration", detail: package.duration),
                            DetailBook(title: "Type", detail: package.type),
                            DetailBook(
                                title: "Price",
                                detail: package.price.toString()),
                            SizedBox(
                              height: 24,
                            ),
                            CustomButton(
                                text: "Join Now",
                                textSize: 16,
                                onPressed: () async {
                                  await fetchUser();

                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: BookingPage(user: user, package: package, vendor: vendor,),
                                          type: PageTransitionType.fade,
                                          duration:
                                              Duration(milliseconds: 500)));
                                })
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
          ],
        )
      ],
    ));
  }

  Widget buildIndicator(int count) => AnimatedSmoothIndicator(
        activeIndex: currentIndex,
        count: count,
        effect: ScrollingDotsEffect(
            dotColor: warnaBg.withOpacity(0.5),
            activeDotColor: warnaBg,
            dotWidth: 15,
            dotHeight: 5),
      );
}

void convertToInt() {}
