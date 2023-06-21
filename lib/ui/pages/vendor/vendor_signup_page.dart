import 'package:flutter/material.dart';
import 'package:travelgo/ui/widgets/custom_text_form_field.dart';

import '../../../services/user_service.dart';
import '../../../shared/api_response.dart';
import '../../../shared/theme.dart';
import '../../widgets/role_title.dart';
import '../../widgets/title.dart';

class VendorSignUpPage extends StatefulWidget {
  const VendorSignUpPage({super.key});

  @override
  State<VendorSignUpPage> createState() => _VendorSignUpPageState();
}

class _VendorSignUpPageState extends State<VendorSignUpPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController usn = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();
  TextEditingController cpw = TextEditingController();

  Future _register() async {
    ApiResponse res = await register(name.text, email.text, pw.text, usn.text, "VENDOR");

    if (res.error == null) {
      Navigator.pushNamed(context, '/vendor-login');
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
            CustomTextFormField(title: "Name", hintText: "Your Name", controller: name,),
            CustomTextFormField(title: "Username", hintText: "Your Username", controller: usn,),
            CustomTextFormField(title: "Email Address", hintText: "Your Email Address", controller: email,),
            CustomTextFormField(title: "Password", hintText: "Enter Password", isHidden: true, controller: pw,),
            CustomTextFormField(title: "Confirm Password", hintText: "Re-enter Password", isHidden: true, controller: cpw,)
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
              _register();
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
          RoleTitle(title: "VENDOR",),
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
                    Navigator.pushNamed(context, '/vendor-login');
                  },
                  child: Text(
                    "Login",
                    style: brownTextStyle.copyWith(fontWeight: bold),
                  ))
            ],
          )
        ],
      )),
    );
  }
}