import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgo/ui/widgets/custom_button.dart';
import 'package:travelgo/ui/widgets/custom_text_form_field.dart';
import 'package:travelgo/ui/widgets/title.dart';

import '../../../models/user_model.dart';
import '../../../services/user_service.dart';
import '../../../shared/api_response.dart';
import '../../../shared/theme.dart';
import '../../widgets/role_title.dart';

class VendorLoginPage extends StatefulWidget {
  const VendorLoginPage({super.key});

  @override
  State<VendorLoginPage> createState() => _VendorLoginPageState();
}

class _VendorLoginPageState extends State<VendorLoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();

  void _loginVendor() async {
    ApiResponse res = await login(email.text, pw.text, "VENDOR");
    if (res.error == null) {
      saveAndRedirectToHome(res.data as User);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${res.error}")));
    }
  }

  void saveAndRedirectToHome(User user) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("token", user.token ?? "");
    await pref.setInt("userId", user.id);
    Navigator.pushNamedAndRemoveUntil(context, '/main-vendor', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Widget inputSection() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            CustomTextFormField(title: "Email Address", hintText: "Your Email Address", controller: email,),
            CustomTextFormField(title: "Password", hintText: "Enter Password", isHidden: true, controller: pw,)
          ],
        ),
      );
    }

    Widget submitButton() {
      return CustomButton(text: "Login", textSize: 16, onPressed: () {
        _loginVendor();
      },
      margin: EdgeInsets.symmetric(horizontal: 20),);
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
                "Don't have an account?",
                style: blackTextStyle,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/vendor-signup');
                  },
                  child: Text(
                    "Sign Up",
                    style: brownTextStyle.copyWith(fontWeight: bold),
                  ))
            ],
          ),
          Text(
            "Or",
            textAlign: TextAlign.center,
            style: blackTextStyle,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: SizedBox(
              height: 55,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/roles');
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: warnaCoklat, width: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius))),
                child: Text("Change Role", style: brownTextStyle,),
              ),
            ),
          )
        ],
      )),
    );
  }
}