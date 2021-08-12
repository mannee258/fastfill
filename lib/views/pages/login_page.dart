import 'package:fastfill/views/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:fastfill/views//pages/regi_page.dart';
import 'package:fastfill/utils/color.dart';
import 'package:fastfill/widgets/btn_widget.dart';
import 'package:fastfill/widgets/herder_container.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  // TextEditingController email = TextEditingController();
  // TextEditingController password = TextEditingController();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  Future login(BuildContext context) async {
    if (email.text == "" || password.text == "") {
      Fluttertoast.showToast(
        msg: "Both fields cannot be left blank!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
      );
    } else {
      var url = Uri.parse("https://mapx.gr33nium.com/Super/loginapi.php");
      var response = await http.post(url, body: {
        "email": email.text,
        "password": password.text,
      });

      var data = json.decode(response.body);
      if (data == "success") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));
      } else {
        Fluttertoast.showToast(
          msg: "The email and password combination is incorrect",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Login"),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _textInput(
                        controller: email, hint: "Email", icon: Icons.email),
                    _textInput(
                        controller: password,
                        hint: "Password",
                        icon: Icons.vpn_key),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          onClick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Homepage()));
                          },
                          btnText: "LOGIN",
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Don't have an account ? ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: "Register",
                            style: TextStyle(color: blueColors)),
                      ]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // @override
  // void initState() {
  // TODO: implement initState
  //   super.initState();
  //   namectrl = new TextEditingController();
  //   emailctrl = new TextEditingController();
  //   passctrl = new TextEditingController();
  //
  // }
  //
  // void registerUser() async{
  //
  //   setState(() {
  //     processing = true;
  //   });
  //   var url = Uri.parse("https://sampleproject098.000webhostapp.com/login_flutter/signup.php");
  //   var data = {
  //     "email":emailctrl.text,
  //     "name":namectrl.text,
  //     "pass":passctrl.text,
  //   };
  //
  //   var res = await http.post(url,body:data);
  //
  //   if(jsonDecode(res.body) == "account already exists"){
  //     Fluttertoast.showToast(msg: "account exists, Please login",toastLength: Toast.LENGTH_SHORT);
  //
  //   }else{
  //
  //     if(jsonDecode(res.body) == "true"){
  //       Fluttertoast.showToast(msg: "account created",toastLength: Toast.LENGTH_SHORT);
  //     }else{
  //       Fluttertoast.showToast(msg: "error",toastLength: Toast.LENGTH_SHORT);
  //     }
  //   }
  //   setState(() {
  //     processing = false;
  //   });
  // }
  //
  // void userSignIn() async{
  //   setState(() {
  //     processing = true;
  //   });
  //   var url = "https://sampleproject098.000webhostapp.com/login_flutter/signin.php";
  //   var data = {
  //     "email":emailctrl.text,
  //     "pass":passctrl.text,
  //   };
  //
  //   var res = await http.post(url,body:data);
  //
  //   if(jsonDecode(res.body) == "dont have an account"){
  //     Fluttertoast.showToast(msg: "dont have an account,Create an account",toastLength: Toast.LENGTH_SHORT);
  //   }
  //   else{
  //     if(jsonDecode(res.body) == "false"){
  //       Fluttertoast.showToast(msg: "incorrect password",toastLength: Toast.LENGTH_SHORT);
  //     }
  //     else{
  //       print(jsonDecode(res.body));
  //     }
  //   }
  //
  //   setState(() {
  //     processing = false;
  //   });
  // }

  Widget _textInput({controller, hint, icon}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
