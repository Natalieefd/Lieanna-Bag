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
      body: Row(
        children: [
          Padding(
            
            padding: const EdgeInsets.only(top: 30,left:20),
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
            padding: const EdgeInsets.only(top: 30,left:10),
            child: Text("Welcome, User A!",
              style: Theme.of(context).textTheme.titleSmall
              ),
          ),
          
          Padding(
            
            padding: const EdgeInsets.only(top: 40,left:170),
            child: Icon(
              CupertinoIcons.arrowtriangle_right_square,
              size: 30,
            ),
          ),
        ],

      ),
    );
  }
}