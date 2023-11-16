import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/asset_images.dart';
import '../../../constants/routes.dart';
import '../../../widgets/primary_button/primary_button.dart';
import '../../../widgets/top_titles/top_titles.dart';
import '../login/login.dart';
import '../sign_up/sign_up.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitles(title: "Welcome", subTitle: "Welcome to Food Oder App"),
              Center(
                child: Image.asset(
                  AssetsImages.instance.welcomeImage,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.facebook,
                      size: 35,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: Image.asset(
                      AssetsImages.instance.googleLogo,
                      scale: 120.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              PrimaryButton(
                title: "Login",
                onPressed: () {
                  Routes.instance.push(widget: Login(),context: context);
                },
              ),
              const SizedBox(
                height: 18,
              ),
              PrimaryButton(
                title: "Sign up",
                onPressed: () {
                  Routes.instance.push(widget: SignUp(),context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
