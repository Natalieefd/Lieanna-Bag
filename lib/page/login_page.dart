// ignore_for_file: use_build_context_synchronously
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lienna_bag/Provider/themeMode.dart';
import 'package:lienna_bag/auth.dart';
import 'package:lienna_bag/page/forgot_password.dart';
import 'package:lienna_bag/page/home_screen.dart';
import 'package:lienna_bag/page/register_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool press = false;
  bool form = false;
  bool loading = false;
  bool emailVal = false;
  bool passwordVal = false;
  bool emailCheck = false;
  bool passIconColor = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        emailVal = _emailController.text.isNotEmpty;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        passwordVal = _passwordController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<dynamic> alert(BuildContext context, String judul, String kontent) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(judul),
          content: Text(kontent),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 85, left: 25, bottom: 55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "welcome back!".toUpperCase(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  "Login to Lieanna Bag",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: true,
            child: Column(
              children: [
                Container(
                  width: 250,
                  height: 250,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 35, right: 35),
                  child: SizedBox(
                    width: size.width - 50,
                    child: CupertinoButton.filled(
                      child: const Text("Login"),
                      onPressed: () {
                        setState(() {
                          form = !form;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width - 55,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ));
                    },
                    child: const Text("Create an Account"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomSheet: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.ease,
        width: size.width,
        height: form == false ? 0 : size.height - 370,
        decoration: BoxDecoration(
            //warna sementara
            color: Theme.of(context).colorScheme.background,
            boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 5)],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Visibility(
          visible: form,
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    form = !form;
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 10, left: 130, right: 130),
                  child: Container(
                    height: 7,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: TextFormField(
                          controller: _emailController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Provider.of<ThemeModeData>(context)
                                .container2Color,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Provider.of<ThemeModeData>(context)
                                      .containerColor,
                                  width: 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Provider.of<ThemeModeData>(context)
                                      .containerColor,
                                  width: 1.7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: "Email",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: Colors.black),
                            errorText: emailVal == true && emailCheck == false
                                ? "invalid email"
                                : null,
                            errorStyle: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 14,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              emailCheck = EmailValidator.validate(
                                  _emailController.text);
                            });
                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: TextFormField(
                        controller: _passwordController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Provider.of<ThemeModeData>(context)
                                .container2Color,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Provider.of<ThemeModeData>(context)
                                      .containerColor,
                                  width: 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Provider.of<ThemeModeData>(context)
                                      .containerColor,
                                  width: 1.7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                            suffixIconColor: Colors.grey,
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: "Password",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: Colors.black)),
                        obscureText: press ? false : true,
                        // style: const TextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
                child: CupertinoButton.filled(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  child: const Text("Submit"),
                  onPressed: () async {
                    if (emailCheck == true &&
                        emailVal == true &&
                        passwordVal == true) {
                      try {
                        final email = _emailController.value.text;
                        final password = _passwordController.value.text;

                        setState(() => loading = true);

                        //login akun
                        await Auth().signIn(email, password);

                        setState(() => loading = false);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const hom_scrn(),
                          ),
                        );
                      } catch (e) {
                        alert(context, 'Warning', e.toString());
                      }
                    } else {
                      alert(context, "Warning",
                          "Mohon lengkapi data login terlebih dahulu!");
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50, left: 30, right: 30),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen(),
                        ));
                  },
                  child: Text("Forgot Password"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
