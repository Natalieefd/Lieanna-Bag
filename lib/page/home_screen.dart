import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lienna_bag/Provider/themeMode.dart';
import 'package:lienna_bag/page/bag_details.dart';
import 'package:lienna_bag/page/login_page.dart';
import 'package:lienna_bag/page/profile.dart';
import 'package:lienna_bag/page/search_page.dart';
import 'package:provider/provider.dart';

class hom_scrn extends StatefulWidget {
  const hom_scrn({super.key});

  @override
  State<hom_scrn> createState() => _hom_scrnState();
}

class _hom_scrnState extends State<hom_scrn> {
  @override
  Widget build(BuildContext context) {
    var userCollection = FirebaseFirestore.instance.collection('user');
    var userID = FirebaseAuth.instance.currentUser!.uid;

    final orientation = MediaQuery.of(context).orientation;
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
                  : '...';

          Object? profileData =
              snapshot.data!.data().toString().contains('profile')
                  ? snapshot.data!.get('profile')
                  : '';

          return Scaffold(
            appBar: AppBar(
              backgroundColor:
                  Provider.of<ThemeModeData>(context).containerColor,
              leading: profileData.toString() == ''
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Container(
                        width: 50,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                            image: DecorationImage(
                                image: AssetImage('Assets/profile_default.png'),
                                fit: BoxFit.cover)),
                      ),
                    )
                  : Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Container(
                        width: 50,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                            image: DecorationImage(
                                image: NetworkImage(profileData.toString()),
                                fit: BoxFit.cover)),
                      ),
                    ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome, $usernameData',
                      style: Theme.of(context).textTheme.headlineMedium),
                  Icon(
                    CupertinoIcons.square_arrow_right,
                    color: Color.fromRGBO(76, 83, 114, 1),
                    size: 30,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor:
                  Provider.of<ThemeModeData>(context).containerColor,
              currentIndex: 0,
              onTap: (index) {
                if (index == 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return hom_scrn();
                      },
                    ),
                  );
                }
                if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SearchPage();
                      },
                    ),
                  );
                }
                if (index == 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Profile();
                      },
                    ),
                  );
                }
              },
              selectedItemColor: Color.fromRGBO(76, 83, 114, 1),
              items: [
                BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(
                    CupertinoIcons.home,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Search",
                  icon: Icon(
                    CupertinoIcons.search,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Profile",
                  icon: Icon(
                    CupertinoIcons.profile_circled,
                  ),
                ),
              ],
            ),
            body: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Assets/poster.jpg"),
                              fit: BoxFit.cover)),
                    ),

                    Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchPage(),
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40, left: 15),
                              child: Hero(
                                tag: "Zalora",
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image:
                                              AssetImage("Assets/zalora.png"),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchPage(),
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40, left: 30),
                              child: Hero(
                                tag: "Kanken",
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image:
                                              AssetImage("Assets/kanken.png"),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchPage(),
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40, left: 30),
                              child: Hero(
                                tag: "h&m",
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: AssetImage("Assets/h&m.png"),
                                          fit: BoxFit.fill)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.1,
                              top: 5),
                          child: Text(
                            "Zalora",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.22,
                              top: 5),
                          child: Text(
                            "KanKen",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.2,
                              top: 5),
                          child: Text(
                            "H&M",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 35,
                          left: MediaQuery.of(context).size.width * 0.06),
                      child: Text(
                        "TOP PRODUCT",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25, left: 15),
                            child: Hero(
                              tag: "top1",
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: AssetImage("Assets/tas1.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25, left: 45),
                            child: Hero(
                              tag: "top2",
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: AssetImage("Assets/tas2.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              top: 5),
                          child: Text(
                            "Shoulder Bag 5632",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.18,
                              top: 5),
                          child: Text(
                            "Sling Bag 1708",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30, left: 15),
                            child: Hero(
                              tag: "top3",
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: AssetImage("Assets/tas3.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30, left: 45),
                            child: Hero(
                              tag: "top4",
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: AssetImage("Assets/tas4.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.1,
                              top: 5),
                          child: Text(
                            "Sling Bag 0638",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.22,
                              top: 5),
                          child: Text(
                            "BackPack 0266",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
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
