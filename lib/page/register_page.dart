// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lienna_bag/auth.dart';
import 'package:lienna_bag/page/login_page.dart';

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

  Future<void> addUser() {
    final username = _usernameController.value.text;
    final email = _emailController.value.text;
    final password = _passwordController.value.text;
    final confPassword = _confPasswordController.value.text;

    int number = 0;

    setState(() {
      number += number;
    });

    return user
        .add({
          'id': number,
          'username': username,
          'email': email,
          'password': password,
          'profile': "default",
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
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
                Container(
                  width: 250,
                  height: 250,
                  decoration: const BoxDecoration(
                      //gambar sementara
                      // image: DecorationImage(
                      // image: AssetImage("Assets/login.png")),
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 35, right: 35),
                  child: SizedBox(
                    width: size.width - 50,
                    child: CupertinoButton.filled(
                      child: const Text("Register"),
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
        height: form == false ? 0 : size.height - 270,
        decoration: BoxDecoration(
            //warna sementara
            color: Theme.of(context).colorScheme.background,
            boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 5)],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Visibility(
          visible: form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    form = !form;
                  });
                },
                child: Container(
                  width: size.width - 270,
                  height: 9,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
                child: SizedBox(
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: "Username",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                child: SizedBox(
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: "Email",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                child: SizedBox(
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
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
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: "Password",
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
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
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
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: "Confirm Password",
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
                    "By using this application, you agree to its Privacy Policy and Terms of Use",
                    style: TextStyle(
                      fontSize: 16,
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
                    top: 60, bottom: 30, left: 85, right: 85),
                child: SizedBox(
                  width: size.width - 55,
                  child: CupertinoButton.filled(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    child: const Text("Sign Up"),
                    onPressed: () async {

                      final email = _emailController.value.text;
                      final password = _passwordController.value.text;
                      final confPassword = _confPasswordController.value.text;

                      confPassword == password
                          ? confPass = true
                          : alert(context, "Waring",
                              "Confirmasi Password harus sama!");

                      if (usernameVal == true && emailVal == true &&
                          passwordVal == true && confPass == true &&
                          checkVal == true) {

                        try {
                          setState(() => loading = true);

                          //membuat akun baru
                          await Auth().register(email, password);

                          //input data user ke firestore
                          addUser();

                          setState(() => loading = false);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );

                        } catch (e) {
                          print(e);
                        }

                      } else if (checkVal == false) {
                        alert(context, "Waring",
                            "Mohon setujui Privacy Police dan Terms of Use");

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
