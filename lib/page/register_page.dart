// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lienna_bag/Provider/themeMode.dart';
import 'package:lienna_bag/auth.dart';
import 'package:lienna_bag/page/login_page.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static final CollectionReference user =
      FirebaseFirestore.instance.collection('user');

  //untuk icon lihat password
  bool pressPass = false;
  bool pressConfPass = false;

  //variable untuk tampilkan animasi loading
  bool loading = false;

  //untuk menampilkan form input
  bool form = false;

  //untuk validasi confirmasi password
  bool confPass = false;
  bool validation = false;

  //untuk mengecek inputan empty
  bool usernameVal = false;
  bool emailVal = false;
  bool emailCheck = false;
  bool passwordVal = false;
  bool confPasswordVal = false;
  bool checkVal = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      setState(() {
        usernameVal = _usernameController.text.isNotEmpty;
      });
    });
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
    _confPasswordController.addListener(() {
      setState(() {
        confPasswordVal = _confPasswordController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();
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
            padding: const EdgeInsets.only(top: 95, left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "register\nyour\naccount".toUpperCase(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  "Create your Lieanna account!",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: true,
            child: Column(
              children: [
                SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 35, right: 35),
                  child: SizedBox(
                    width: size.width - 50,
                    child: CupertinoButton(
                      color: Provider.of<ThemeModeData>(context).containerColor,
                      child: Text("Register",
                          style: Theme.of(context).textTheme.headlineSmall),
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
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text("I already have an account"),
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
        height: form == false ? 0 : size.height - 340,
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
                padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                child: SizedBox(
                  child: TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          Provider.of<ThemeModeData>(context).container2Color,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Provider.of<ThemeModeData>(context)
                                .containerColor,
                            width: 0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Provider.of<ThemeModeData>(context)
                                .containerColor,
                            width: 1.7),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: "Email",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.black),
                      errorText: emailVal == true && emailCheck == false
                          ? "Invalid email"
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
                          }
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                child: SizedBox(
                  child: TextFormField(
                    controller: _passwordController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          Provider.of<ThemeModeData>(context).container2Color,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Provider.of<ThemeModeData>(context)
                                .containerColor,
                            width: 0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Provider.of<ThemeModeData>(context)
                                .containerColor,
                            width: 1.7),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            pressPass = !pressPass;
                          });
                        },
                        child: Icon(pressPass
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                      ),
                      suffixIconColor: Colors.grey,
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: "Password",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.black),
                    ),
                    obscureText: pressPass ? false : true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                child: SizedBox(
                  child: TextFormField(
                    controller: _confPasswordController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          Provider.of<ThemeModeData>(context).container2Color,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Provider.of<ThemeModeData>(context)
                                .containerColor,
                            width: 0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Provider.of<ThemeModeData>(context)
                                .containerColor,
                            width: 1.7),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            pressConfPass = !pressConfPass;
                          });
                        },
                        child: Icon(pressConfPass
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                      ),
                      suffixIconColor: Colors.grey,
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: "Confirm Password",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.black),
                    ),
                    obscureText: pressConfPass ? false : true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    "I have read and agree to the privacy policy",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (!states.contains(MaterialState.selected)) {
                      return Theme.of(context).colorScheme.background;
                    }
                    return Theme.of(context).colorScheme.secondary;
                  }),
                  checkColor: Theme.of(context).colorScheme.background,
                  value: checkVal,
                  onChanged: (value) {
                    setState(() {
                      checkVal = value!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, bottom: 30, left: 85, right: 85),
                child: SizedBox(
                  width: size.width - 55,
                  child: CupertinoButton(
                    color: Provider.of<ThemeModeData>(context).containerColor,
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    child: Text("Sign Up",
                        style: Theme.of(context).textTheme.headlineSmall),
                    onPressed: () async {
                      // final username = _usernameController.value.text;
                      final email = _emailController.value.text;
                      final password = _passwordController.value.text;
                      final confPassword = _confPasswordController.value.text;

                      confPassword == password
                          ? confPass = true
                          : alert(context, "Waring",
                              "Confirmasi Password harus sama!");

                      if (
                          // usernameVal == true &&
                          emailVal == true &&
                              passwordVal == true &&
                              confPass == true &&
                              checkVal == true) {
                        try {
                          setState(() => loading = true);

                          //membuat akun baru
                          await Auth().register(email, password);

                          //input data user ke firestore
                          // addUser(email, password);

                          setState(() => loading = false);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        } catch (e) {
                          alert(context, 'Warning', e.toString());
                        }
                      } else if (checkVal == false) {
                        alert(context, "Waring",
                            "Mohon setujui Privacy Police terlebih dahulu!");
                      } else {
                        alert(context, "Waring",
                            "Mohon lengkapi data register terlebih dahulu!");
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
