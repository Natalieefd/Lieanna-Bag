import 'package:flutter/material.dart';

class hom_scrn extends StatefulWidget {
  const hom_scrn({super.key});

  @override
  State<hom_scrn> createState() => _hom_scrnState();
}

class _hom_scrnState extends State<hom_scrn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            children:[
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // image: DecorationImage(
                  //   image: AssetImage("Assets/bracelets.jpg"),
                  //   fit: BoxFit.cover)
                ),
              ),
              Text("Welcome, User A!",
                style: Theme.of(context).textTheme.titleMedium
                ),
            ]
          )
        ],

      ),
    );
  }
}