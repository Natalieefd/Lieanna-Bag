import 'package:flutter/material.dart';
import 'about_page.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
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
                          image: AssetImage("Assets/logo.png"),
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
                        Container(
                          width: 100,
                          height: 100,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage("Assets/logo.png"),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Andi Nur Fadilah',
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
                          'andinurfadilah@gmail.com',
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => Edit_Profile()),
                          // );
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => Favorite()),
                          // );
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
                          //   MaterialPageRoute(builder: (context) => Settings()),
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
}
