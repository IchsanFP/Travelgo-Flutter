import 'package:flutter/material.dart';
import 'package:travelgo/services/user_service.dart';
import 'package:travelgo/ui/pages/select_role_page.dart';

import '../../../models/user_model.dart';
import '../../../shared/api_response.dart';
import '../../../shared/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = User(id: 999, name: "xxx", email: "email", role: "role");

  Future<User?> fetchUser() async {
    ApiResponse res = await getDetailUser();
    if (res.error == null) {
      user = res.data as User;
      return user;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${res.error}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            Text(
              "PROFILE",
              style: blackTextStyle.copyWith(
                  fontWeight: semibold, fontSize: 24, letterSpacing: 3),
            ),
            SizedBox(
              height: 32,
            ),
            Expanded(
              child: FutureBuilder(
                future: fetchUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Empty"),
                    );
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 32),
                          child: Column(
                            children: [
                              Text(
                                user.name,
                                style: blackTextStyle.copyWith(
                                    fontSize: 20, fontWeight: semibold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                user.email,
                                style: greyTextStyle.copyWith(fontSize: 16),
                              ),
                            ],
                          )),
                      Container(
                          width: 200,
                          height: 56,
                          margin: EdgeInsets.only(bottom: 72),
                          decoration: BoxDecoration(
                              color: warnaMerah,
                              borderRadius:
                                  BorderRadius.circular(defaultRadius)),
                          child: TextButton(
                              onPressed: () {
                                logout().then((value) => Navigator.of(context)
                                    .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SelectRolePage()),
                                        (route) => false));
                              },
                              child: Text(
                                "Logout",
                                style: whiteTextStyle,
                              ))),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
