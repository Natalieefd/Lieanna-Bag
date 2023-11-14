import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lienna_bag/page/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool press = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Text(
              "Sign Up".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
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
                  child: Text("Full Name"),
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
            padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Confirm Password"),
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
                Text("Already Have an Account?"),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                  },
                  child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.indigo,
                            decoration: TextDecoration.underline),
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60, bottom: 30, left: 85, right: 85),
            child: CupertinoButton.filled(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              child: Text("Sign Up"),
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
