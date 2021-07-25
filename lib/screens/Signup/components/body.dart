import 'package:dock_man/components/already_have_an_account_acheck.dart';
import 'package:dock_man/components/rounded_button.dart';
import 'package:dock_man/screens/Auth/auth.dart';
import 'package:dock_man/screens/Login/login_screen.dart';
import 'package:dock_man/screens/Signup/components/background.dart';
import 'package:dock_man/screens/Signup/components/or_divider.dart';
import 'package:dock_man/screens/Signup/components/social_icon.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController ip = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Image.asset(
                "assets/icons/dock.gif",
                height: size.height * 0.25,
              ),
              SizedBox(height: size.height * 0.02),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                controller: name,
              ),
              SizedBox(height: size.height * 0.01),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                controller: email,
              ),
              SizedBox(height: size.height * 0.01),
              TextField(
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                controller: password,
              ),
              SizedBox(height: size.height * 0.01),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter Docker Server IP",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.network_check),
                ),
                controller: ip,
              ),
              RoundedButton(
                  text: "SIGNUP",
                  press: () => {
                        writeData(context, name.text, email.text, password.text,
                            ip.text)
                      }),
              SizedBox(height: size.height * 0.01),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
