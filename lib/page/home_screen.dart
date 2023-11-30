import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lienna_bag/page/about_page.dart';
import 'package:lienna_bag/page/login_page.dart';

class hom_scrn extends StatefulWidget {
  const hom_scrn({super.key});

  @override
  State<hom_scrn> createState() => _hom_scrnState();
}

class _hom_scrnState extends State<hom_scrn> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index){
          if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return hom_scrn();
                  },
                ),
              );
            }
          if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return About_Page();
                  },
                ),
              );
            }
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return hom_scrn();
                  },
                ),
              );
            }
        },
        backgroundColor:Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).colorScheme.onSecondary,
        unselectedItemColor: Theme.of(context).colorScheme.onBackground,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              CupertinoIcons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: "Us",
            icon: Icon(
              CupertinoIcons.info_circle,
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 20),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black
                          // image: DecorationImage(
                          //   image: AssetImage("Assets/poster.jpg"),
                          //   fit: BoxFit.cover)
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 10),
                    child: Text("Welcome, User A!",
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: MediaQuery.of(context).size.width * 0.35),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Icon(
                        CupertinoIcons.square_arrow_right,
                        color: Theme.of(context).colorScheme.onBackground,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                   height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("Assets/poster.jpg"),
                        fit: BoxFit.cover)
                      ),
                ),
              ),

              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginPage(),)
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40, left: 15),
                        child:Hero(
                          tag: "Zalora",
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.13,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: AssetImage("Assets/zalora.png"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginPage(),)
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40, left: 30),
                        child: Hero(
                          tag: "Kanken",
                          child: Container(
                             width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.13,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: AssetImage("Assets/kanken.png"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginPage(),)
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40, left: 30),
                        child: Hero(
                          tag: "h&m",
                          child: Container(
                                  width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.13,
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
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, top: 5),
                    child: Text(
                      "Zalora",
                      style: Theme.of(context).textTheme.titleSmall,
                      
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.22, top: 5),
                    child: Text(
                      "KanKen",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2, top: 5),
                    child: Text(
                      "H&M",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(top: 35, left: MediaQuery.of(context).size.width * 0.06),
                child: Text(
                  "TOP PRODUCT",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginPage(),)
                        );
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
                        
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginPage(),)
                        );
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
                    padding:  EdgeInsets.only( left: MediaQuery.of(context).size.width * 0.05, top: 5),
                    child: Text(
                      "Shoulder Bag 5632",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.18, top: 5),
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
                        
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginPage(),)
                        );
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
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginPage(),)
                        );
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
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, top: 5),
                    child: Text(
                      "Sling Bag 0638",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.22, top: 5),
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
}