import 'package:flutter/material.dart';
import 'package:travelgo/shared/theme.dart';

class SelectRolePage extends StatefulWidget {
  const SelectRolePage({super.key});

  @override
  State<SelectRolePage> createState() => _SelectRolePageState();
}

class _SelectRolePageState extends State<SelectRolePage> {
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
                    image: AssetImage('assets/img_bg2.png'), fit: BoxFit.fill)),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Which Hodophile Are You?",
                  style:
                      whiteTextStyle.copyWith(fontWeight: bold, fontSize: 24),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Hodophile (n.) a person who loves to travel.",
                  style: whiteTextStyle.copyWith(fontSize: 16),
                ),
                SizedBox(
                  height: 28,
                ),
                SizedBox(
                    width: 300,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/user-login');
                      },
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: warnaBg, width: 2),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius))),
                      child: Text(
                        "User",
                        style: whiteTextStyle.copyWith(fontWeight: bold),
                      ),
                    )),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: 300,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/vendor-login');
                      },
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: warnaBg, width: 2),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius))),
                      child: Text(
                        "Vendor",
                        style: whiteTextStyle.copyWith(fontWeight: bold),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
