import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../constants/routes.dart';
import '../../../firebase_helper/firebase_auth.dart';
import '../../../widgets/primary_button/primary_button.dart';
import '../../../widgets/top_titles/top_titles.dart';
import '../../custom_bottom_bar/custom_bottom_bar.dart';
import '../../home/home.dart';
import '../sign_up/sign_up.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(
                title: "Login",
                subTitle: "Welcome Back to Food Oder App",
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: password,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(
                    Icons.password_outlined,
                  ),
                  suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 36,
              ),
              PrimaryButton(
                title: "Login",
                onPressed: () async {
                  bool isValidated = loginVaildation(email.text, password.text);
                  if (isValidated) {
                    bool isLogined = await FirebaseAuthHelper.instance
                        .login(email.text, password.text, context);
                    if (isLogined) {
                      Routes.instance
                          .pushAndRemoveUntil(widget: CustomBottomBar(), context: context);
                    }
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "Don't have an account?",
              )),
              Center(
                  child: CupertinoButton(
                onPressed: () {
                  Routes.instance.push(widget: SignUp(), context: context);
                },
                child: Text(
                  "Create an account",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
