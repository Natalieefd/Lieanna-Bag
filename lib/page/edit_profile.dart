import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lienna_bag/Provider/themeMode.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //variable untuk tampilkan animasi loading
  bool loading = false;

  String imageUrl = "";

  final TextEditingController _usernameController = TextEditingController();

  var userCollection = FirebaseFirestore.instance.collection('user');
  var user = FirebaseAuth.instance.currentUser;
  var userID = FirebaseAuth.instance.currentUser!.uid;

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

  Future<void> updateUser(String username, String email, String password,
      String userProfile) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(userID)
        .set({
          'username': username,
          'email': email,
          'password': password,
          'profile': userProfile,
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
      backgroundColor: Provider.of<ThemeModeData>(context).containerColor,
    );

    return StreamBuilder<DocumentSnapshot>(
        stream: userCollection.doc(userID).snapshots(),
        builder: (BuildContext, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            Object? usernameData =
                snapshot.data!.data().toString().contains('username')
                    ? snapshot.data!.get('username')
                    : '...';

            Object? emailData =
                snapshot.data!.data().toString().contains('email')
                    ? snapshot.data!.get('email')
                    : '...';

            Object? passwordData =
                snapshot.data!.data().toString().contains('password')
                    ? snapshot.data!.get('password')
                    : '...';

            Object? profileData =
                snapshot.data!.data().toString().contains('profile')
                    ? snapshot.data!.get('profile')
                    : '';

            return Scaffold(
              appBar: AppBar(
                backgroundColor:
                    Provider.of<ThemeModeData>(context).containerColor,
                title: Text(
                  'EDIT PROFILE',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                centerTitle: true,
              ),
              body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 140, bottom: 10),
                    child: InkWell(
                      onTap: () async {
                        // Membuat  dan menambahkan package image_picker
                        final imgPicker = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        if (imgPicker == null) return;

                        String fileName =
                            DateTime.now().microsecondsSinceEpoch.toString();

                        // Membua reference untuk menggambil folder root pada firebase storage
                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceImages =
                            referenceRoot.child("images/user_profile");

                        // Membuat reference untuk mengupload gambar
                        Reference referenceImageToUpload =
                            referenceImages.child(fileName);

                        // Error handling
                        try {
                          await referenceImageToUpload
                              .putFile(File(imgPicker.path));
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                        } catch (e) {
                          alert(context, 'Warning', e.toString());
                        }
                      },
                      child: imageUrl == ""
                          ? Padding(
                            padding:
                                const EdgeInsets.only(left: 125, right: 125),
                            child: Container(
                              height: 140,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(80),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    profileData.toString()))
                              ),
                            ),
                          )
                          : Container(
                            padding:
                                const EdgeInsets.only(left: 125, right: 125),
                            child: Container(
                              height: 140,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(80),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    usernameData.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 25, right: 25),
                    child: SizedBox(
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade200, width: 0),
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
                          hintText: "Username",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 120, bottom: 30, left: 35, right: 35),
                    child: CupertinoButton.filled(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      child: const Text("Edit Profile"),
                      onPressed: () async {
                        var username = _usernameController.value.text;
              
                          try {
                            imageUrl == ''
                            ? imageUrl = profileData.toString()
                            : null;

                            username == ''
                          ? username = usernameData.toString()
                          : null;
                          
                            setState(() => loading = true);
                            
                            //update data user pada firestore
                            updateUser(username, emailData.toString(),
                            passwordData.toString(), imageUrl);
              
                            setState(() => loading = false);
              
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBarUpdate);
              
                          } catch (e) {
                            print(e);
                          }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(30),
            child: CircularProgressIndicator(),
          ));
        });
  }
}
