import 'package:flutter/material.dart';
import 'package:travelgo/services/user_service.dart';
import 'package:travelgo/shared/api_response.dart';
import 'package:travelgo/shared/theme.dart';
import 'package:travelgo/ui/widgets/custom_text_form_field.dart';

import '../../widgets/role_title.dart';
import '../../widgets/title.dart';

class UserSignUpPage extends StatefulWidget {
  const UserSignUpPage({super.key});

  @override
  State<UserSignUpPage> createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController usn = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();
  TextEditingController cpw = TextEditingController();

  Future _register() async {
    ApiResponse res = await register(name.text, email.text, pw.text, usn.text, "USER");

    if (res.error == null) {
      Navigator.pushNamed(context, '/user-login');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${res.error}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget inputSection() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            CustomTextFormField(
              title: "Name",
              hintText: "Your Name",
              controller: name,
            ),
            CustomTextFormField(
                title: "Username",
                hintText: "Your Username",
                controller: usn),
            CustomTextFormField(
                title: "Email Address",
                hintText: "Your Email Address",
                controller: email),
            CustomTextFormField(
                title: "Password",
                hintText: "Enter Password",
                isHidden: true,
                controller: pw,
                validator: (val) => val!.length < 8 ? "Required at least 8 chars" : null,
                ),
            CustomTextFormField(
                title: "Confirm Password",
                hintText: "Re-enter Password",
                isHidden: true,
                controller: cpw,
                validator:(val) => val != pw.text ? 'Password does not match' : null,
                )
          ],
        ),
      );
    }

    Widget submitButton() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  _register();
                });
              }
            },
            style: TextButton.styleFrom(
                backgroundColor: warnaCoklat,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultRadius))),
            child: Text(
              "Sign Up",
              style: whiteTextStyle.copyWith(fontWeight: bold, fontSize: 16),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
          child: Form(
            key: formKey,
            child: ListView(
                  padding: EdgeInsets.all(defaultMargin),
                  children: [
            SizedBox(
              height: 15,
            ),
            title(null),
            SizedBox(
              height: 32,
            ),
            RoleTitle(
              title: "USER",
            ),
            inputSection(),
            submitButton(),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: blackTextStyle,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/user-login');
                    },
                    child: Text(
                      "Login",
                      style: brownTextStyle.copyWith(fontWeight: bold),
                    ))
              ],
            )
                  ],
                ),
          )),
    );
  }
}
