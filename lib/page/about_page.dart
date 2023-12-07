import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lienna_bag/Provider/themeMode.dart';
import 'package:provider/provider.dart';

class About_Page extends StatelessWidget {
  const About_Page({super.key});

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    // var tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeModeData>(context).containerColor,
        title: Text(
          'ABOUT',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70.0,
              backgroundImage: AssetImage('Assets/logo.png'),
            ),
            SizedBox(height: 20.0),
            Column(
              children: [
                Container(
                  width: lebar,
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: ShapeDecoration(
                    color: Provider.of<ThemeModeData>(context).containerColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Lieanna Bag',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Lieanna Bag adalah aplikasi yang dapat memberikan Anda rekomendasi produk tas berkualitas yang sesuai dengan style. Dengan fitur rekomendasi yang mudah dan cerdas, Lieanna Bag akan selalu membuat penampilan Anda tampil sempurna!.',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.black),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: lebar,
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: ShapeDecoration(
                    color: Provider.of<ThemeModeData>(context).container2Color,
                    // color: Color.fromRGBO(148, 154, 177, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Founder',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Andi Nur Fadilah',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Natalie Fuad',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Rizki Agung Romadhon',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Sherina Laraswati',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: lebar,
                  // height: tinggi,
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  decoration: ShapeDecoration(
                    color: Provider.of<ThemeModeData>(context).containerColor,
                    // color: Color.fromRGBO(107, 140, 150, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Official Account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Instagram : @lieanna_bag',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
