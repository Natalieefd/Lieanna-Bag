import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  //untuk icon lihat password
  bool pressPass = false;
  bool pressConfPass = false;

  //variable untuk tampilkan animasi loading
  bool loading = false;

  //untuk validasi confirmasi password
  bool confPass = false;

  //untuk mengecek inputan empty
  bool usernameVal = false;
  bool emailVal = false;
  bool passwordVal = false;
  bool confPasswordVal = false;
  String imageUrl = "";

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

  Future<void> updateUser() async {
    var userEmail = FirebaseAuth.instance.currentUser;
    var userAccount = FirebaseAuth.instance.currentUser;

  final CollectionReference user =
      FirebaseFirestore.instance.collection('user');

    final Future<QuerySnapshot<Map<String, dynamic>>> userData =
      FirebaseFirestore.instance.collection('user').where('email', isEqualTo: userEmail).get();
    
    // Future<QuerySnapshot<Map<String, dynamic>>> listUser = userData;

    // final id = listUser;
    final username = _usernameController.value.text;
    final email = _emailController.value.text;
    final password = _passwordController.value.text;

    userAccount!.updateEmail(email);
    userAccount.updatePassword(password);

    return user
        .doc().set({
          'username': username,
          'email': email,
          'password': password,
          'profile': "default",
        })
        .then((value) => print("Data Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final snackBarUpdate = SnackBar(
      content: const Text("Successfully edit profile"),
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(10),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "edit profile".toUpperCase(),
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 10),
            child: InkWell(
              onTap: () async {
                // Membuat  dan menambahkan package image_picker
                final imgPicker =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                if (imgPicker == null) return;

                String fileName =
                    DateTime.now().microsecondsSinceEpoch.toString();

                // Membua reference untuk menggambil folder root pada firebase storage
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceImages =
                    referenceRoot.child("images/user_profile");

                // Membuat reference untuk mengupload gambar
                Reference referenceImageToUpload =
                    referenceImages.child(fileName);

                // Error handling
                try {
                  await referenceImageToUpload.putFile(File(imgPicker.path));
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                } catch (e) {}
              },
              child: imageUrl == ""
                  ? CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: ClipOval(
                        child: Image.asset("Assets/profile_default.png",
                            fit: BoxFit.cover),
                      ),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: ClipOval(
                        child: Image.network(imageUrl, fit: BoxFit.cover),
                      ),
                    ),
            ),
          ),
          // Padding(padding: EdgeInsets.only(top: 30, bottom: 10, left: 25, right: 25),child: ,)
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
                padding: const EdgeInsets.only(
                    top: 60, bottom: 30, left: 85, right: 85),
                child: SizedBox(
                  width: size.width - 55,
                  child: CupertinoButton.filled(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    child: const Text("Edit Profile"),
                    onPressed: () async {

                      final email = _emailController.value.text;
                      final password = _passwordController.value.text;
                      final confPassword = _confPasswordController.value.text;

                      confPassword == password
                          ? confPass = true
                          : alert(context, "Waring",
                              "Confirmasi Password harus sama!");

                      if (usernameVal == true && emailVal == true &&
                          passwordVal == true && confPass == true) {

                        try {
                          setState(() => loading = true);

                          //input data user ke firestore
                          updateUser();

                          setState(() => loading = false);

                          ScaffoldMessenger.of(context).showSnackBar(snackBarUpdate);
                          // Navigator.pop(context);

                        } catch (e) {
                          print(e);
                        }

                      } else {
                        // alert(context, "Waring",
                        //     "Mohon lengkapi data register terlebih dahulu!");
                      }
                    },
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
