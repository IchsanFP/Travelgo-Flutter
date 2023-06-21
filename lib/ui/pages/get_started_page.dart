import 'package:flutter/material.dart';
import 'package:travelgo/shared/theme.dart';
import 'package:travelgo/ui/pages/select_role_page.dart';
import 'package:travelgo/ui/widgets/custom_button.dart';
import 'package:page_transition/page_transition.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img_bg.png'), fit: BoxFit.fill)),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Adventure Awaits",
                  style: whiteTextStyle.copyWith(
                      fontSize: 24, fontWeight: semibold, letterSpacing: 5),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Experience the world,\none voyage at a time;\nEnhancing your travel expectations.",
                  style:
                      whiteTextStyle.copyWith(letterSpacing: 2, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 32,
                ),
                CustomButton(
                  text: "Get Started",
                  width: 220,
                  textSize: 20,
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: SelectRolePage(),
                            childCurrent: this,
                            type: PageTransitionType.rightToLeftJoined,
                            duration: Duration(milliseconds: 400)));
                  },
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),
                SizedBox(
                  height: 36,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
