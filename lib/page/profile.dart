import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lienna_bag/page/edit_profile.dart';
import 'package:lienna_bag/page/favorite_page.dart';

import 'about_page.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;

    var userCollection = FirebaseFirestore.instance.collection('user');
    var userID = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<DocumentSnapshot>(
      stream: userCollection.doc(userID).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(30),
            child: CircularProgressIndicator(),
          ));
        } else if (snapshot.hasData) {
          Object? usernameData =
              snapshot.data!.data().toString().contains('username')
                  ? snapshot.data!.get('username')
                  : '...' ;
                  
          Object? emailData =
              snapshot.data!.data().toString().contains('email')
                  ? snapshot.data!.get('email')
                  : '...';

          Object? profileData =
              snapshot.data!.data().toString().contains('profile')
                  ? snapshot.data!.get('profile')
                  : '';

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                // backgroundColor: Providser.of<ThemeModeData>(context).containerColor,
                backgroundColor: Color.fromRGBO(76, 83, 114, 1),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'USER PROFILE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
            body: ListView(
              children: [
                Container(
                  width: lebar,
                  height: tinggi,
                  // color: Color.fromARGB(255, 54, 53, 56),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: lebar,
                        height: 350,
                        padding: const EdgeInsets.all(0),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("Assets/profile_default.png"),
                                fit: BoxFit.cover)),
                        child: Container(
                          width: lebar,
                          height: tinggi,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0x7F373538), Color(0xFF363538)],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              profileData.toString() == ''
                              ? Container(
                                width: 100,
                                height: 100,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("Assets/profile_default.png"),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                ),
                              )
                              : Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    image: DecorationImage(
                                        image: NetworkImage(profileData.toString()),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                usernameData.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                emailData.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile()),
                                );
                              },
                              icon: Icon(
                                Icons.manage_accounts_rounded,
                                size: 30,
                                color: Color(0xFF4C5372),
                              ),
                              label: Text(
                                "Edit Profile",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FavoritePage()),
                                );
                              },
                              icon: Icon(
                                Icons.favorite_border_rounded,
                                size: 30,
                                color: Color(0xFF4C5372),
                              ),
                              label: Text(
                                "My Favorite",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => setting()),
                                // );
                              },
                              icon: Icon(
                                Icons.settings,
                                size: 30,
                                color: Color(0xFF4C5372),
                              ),
                              label: Text(
                                "Settings",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => About_Page()),
                                );
                              },
                              icon: Icon(
                                Icons.info_outline_rounded,
                                size: 30,
                                color: Color(0xFF4C5372),
                              ),
                              label: Text(
                                "About Us",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(40),
          child: CircularProgressIndicator(),
        ));
      },
    );
  }
}
