import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
          // onTap: (index){
          //   if (index == 0) {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) {
          //             return hom_scrn();
          //           },
          //         ),
          //       );
          //     }
          //   if (index == 1) {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) {
          //             return hom_scrn();
          //           },
          //         ),
          //       );
          //     }
          //     if (index == 1) {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) {
          //             return hom_scrn();
          //           },
          //         ),
          //       );
          //     }
          // },
          backgroundColor: Colors.black12,
            // iconSize: 32,
            // selectedItemColor: Theme.of(context).colorScheme.onPrimary,
            // unselectedItemColor: Theme.of(context).colorScheme.secondaryContainer,
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
            // scrollDirection: Axis.vertical,
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
                          //   image: AssetImage("Assets/bracelets.jpg"),
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
                    padding: const EdgeInsets.only(top: 40, left: 170),
                    child: Icon(
                      CupertinoIcons.square_arrow_right,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(color: Colors.black
                      // image: DecorationImage(
                      //   image: AssetImage("Assets/bracelets.jpg"),
                      //   fit: BoxFit.cover)
                      ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 20),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black
                          // image: DecorationImage(
                          //   image: AssetImage("Assets/bracelets.jpg"),
                          //   fit: BoxFit.cover)
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 25),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black
                          // image: DecorationImage(
                          //   image: AssetImage("Assets/bracelets.jpg"),
                          //   fit: BoxFit.cover)
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 25),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black
                          // image: DecorationImage(
                          //   image: AssetImage("Assets/bracelets.jpg"),
                          //   fit: BoxFit.cover)
                          ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 5),
                    child: Text(
                      "Merek A",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 5),
                    child: Text(
                      "Merek B",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 5),
                    child: Text(
                      "Merek C",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 20),
                child: Text("TOP PRODUCT",
                style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
               Row(
                 children: [
                   Padding(
                        padding: const EdgeInsets.only(top: 25, left: 25),
                        child: Container(
                          width: 160,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black
                              // image: DecorationImage(
                              //   image: AssetImage("Assets/bracelets.jpg"),
                              //   fit: BoxFit.cover)
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, left: 25),
                        child: Container(
                          width: 160,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black
                              // image: DecorationImage(
                              //   image: AssetImage("Assets/bracelets.jpg"),
                              //   fit: BoxFit.cover)
                              ),
                        ),
                      ),
                 ],
               ),
               Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 65, top: 5),
                    child: Text(
                      "Nama Tas",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 110, top: 5),
                    child: Text(
                      "Nama Tas",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
              Row(
                 children: [
                   Padding(
                        padding: const EdgeInsets.only(top: 30, left: 25),
                        child: Container(
                          width: 160,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black
                              // image: DecorationImage(
                              //   image: AssetImage("Assets/bracelets.jpg"),
                              //   fit: BoxFit.cover)
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 25),
                        child: Container(
                          width: 160,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black
                              // image: DecorationImage(
                              //   image: AssetImage("Assets/bracelets.jpg"),
                              //   fit: BoxFit.cover)
                              ),
                        ),
                      ),
                 ],
               ),
               Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 65, top: 5),
                    child: Text(
                      "Nama Tas",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 110, top: 5),
                    child: Text(
                      "Nama Tas",
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
