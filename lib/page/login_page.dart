import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lienna_bag/page/register_page.dart';

// testing

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool press = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 95),
            child: Text(
              "Login".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Username"),
                ),
                SizedBox(
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: "Type Here",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Password"),
                ),
                SizedBox(
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            press = !press;
                          });
                        },
                        child: Icon(press
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                      ),
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: "Type Here",
                    ),
                    obscureText: press ? false : true,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 35),
            child: Row(
              children: [
                Text("Don't Have an Account?"),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ));
                  },
                  child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.indigo,
                            decoration: TextDecoration.underline),
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 140, bottom: 30, left: 85, right: 85),
            child: CupertinoButton.filled(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              child: Text("Login"),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}