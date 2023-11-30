import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lienna_bag/pages/about_page.dart';
import 'package:lienna_bag/pages/login_page.dart';
import 'package:lienna_bag/pages/search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _listPage = [
    HomePage(),
    const SearchPage(),
    const AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor:Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).colorScheme.onSecondary,
        unselectedItemColor: Theme.of(context).colorScheme.onBackground,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              CupertinoIcons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: "Search", 
            icon: Icon(Icons.search_rounded)
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              CupertinoIcons.profile_circled,
            ),
          ),
        ],
      ),
      body: _listPage[_currentIndex],
    );
  }
}

class HomePage extends StatelessWidget {
  
  final List<String> _imageMerk = [
    'Assets/zalora.png',
    'Assets/kanken.png',
    'Assets/h&m.png',
  ];

  final List<String> _merk = [
    "Zalora",
    "KanKen",
    "H&M"
  ];

  final List<String> _topProduct = [
    "Shoulder Bag 5632",
    "Sling Bag 1708",
    "Sling Bag 0638",
    "BackPack 0266"
  ];

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return ListView(
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
                  padding: EdgeInsets.only(
                      top: 40, left: MediaQuery.of(context).size.width - 230),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage()
                        ),
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
                width:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width,
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height - 550
                        : MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("Assets/poster.jpg"),
                        fit: BoxFit.cover)),
              ),
            ),
            Container(
              width: MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height - 643
                  : MediaQuery.of(context).size.height - 150,
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0), // padding merk
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginPage()) 
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: AssetImage(_imageMerk[index]),
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _merk[index],
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 0,
                left: MediaQuery.of(context).size.width * 0.06
              ),
              child: Text(
                "TOP PRODUCT",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Container(
              width: MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,               
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: orientation == Orientation.portrait ? 2 : 4, 
                  crossAxisSpacing: 20.0, 
                  mainAxisSpacing: 20.0, 
                ),
                itemCount: 4,
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 150,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage('Assets/tas${(index+1)}.jpg'),
                            fit: BoxFit.cover
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _topProduct[index],
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
