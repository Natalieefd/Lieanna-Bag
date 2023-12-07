import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lienna_bag/Provider/themeMode.dart';
import 'package:lienna_bag/page/bag_details.dart';
import 'package:lienna_bag/page/login_page.dart';
import 'package:lienna_bag/page/merk_page.dart';
import 'package:lienna_bag/page/profile.dart';
import 'package:lienna_bag/page/search_page.dart';
import 'package:provider/provider.dart';

class hom_scrn extends StatefulWidget {
  const hom_scrn({super.key});

  @override
  State<hom_scrn> createState() => _hom_scrnState();
}

class _hom_scrnState extends State<hom_scrn> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _allResults = [];

  @override
  void initState() {
    _initData();
    super.initState();
  }

  Future<void> getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('tas')
        .orderBy('nama')
        .get();

    setState(() {
      _allResults = data.docs;
    });
  }

  void _initData() async {
    await getClientStream();
  }

  @override
  Widget build(BuildContext context) {
    // List<QueryDocumentSnapshot<Map<String, dynamic>>> filteredBags =
    //     _allResults.where((bag) {
    //   final name = bag['nama'].toString().toLowerCase();
    //   // return name.contains(searchTas.toLowerCase());
    // }).toList();

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
              title: Text('Welcome, $usernameData',
                  style: Theme.of(context).textTheme.headlineMedium),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(
                      CupertinoIcons.square_arrow_right,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 30,
                    ),
                  ),
                ),
              ],
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
              selectedItemColor: Color.fromRGBO(32, 34, 47, 1),
              unselectedItemColor: Color.fromRGBO(32, 34, 47, 1),
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
                                builder: (context) => MerkPage(
                                  merkName: "Zalora",
                                ),
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
                                builder: (context) => MerkPage(
                                  merkName: "Kanken",
                                ),
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
                                builder: (context) => MerkPage(
                                  merkName: "h&m",
                                ),
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
                                      color: Colors.white,
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
                              builder: (context) =>
                                  BagDetails(itemId: '05CaEhyu4eU1TsZN64kd'),
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
                                        image: AssetImage(
                                            "Assets/kanken weekender.webp"),
                                        fit: BoxFit.contain)),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  BagDetails(itemId: 'sirZ0o7DADeQ7jm76Xfl'),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25, left: 40),
                            child: Hero(
                              tag: "top2",
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "Assets/mango-7355-4887514-1.webp"),
                                        fit: BoxFit.contain)),
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
                            "Kånken Weekender",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.23,
                              top: 5),
                          child: Text(
                            "Mango",
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
                              builder: (context) =>
                                  BagDetails(itemId: 'hOGYjSU7T50WS11q87lP'),
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
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "Assets/Sadie_Mini_HandBag_Chalk.png"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  BagDetails(itemId: 'LwiRXSAe3cL7yrCbfN0p'),
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
                                        image: AssetImage(
                                            "Assets/bbf92fcc1128253b30fca78cf9a39faabd1ac92c_xxl-1.jpg"),
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
                              left: MediaQuery.of(context).size.width * 0.04,
                              top: 5),
                          child: Text(
                            "Sadie Mini HandBag",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.11,
                              top: 5),
                          child: Text(
                            "Packable Outdoor ",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
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
