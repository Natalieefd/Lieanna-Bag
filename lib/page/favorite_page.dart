import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lienna_bag/Provider/themeMode.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    getClientStream();
    getFavorite();
    super.initState();
  }

  List _allResults = [];
  List favoriteID = [];

  void getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('tas')
        .orderBy('nama')
        .get();

    setState(() {
      _allResults = data.docs;
    });
  }

  String getFirstSentence(String text) {
    List<String> sentences = text.split(RegExp(r'[.!? ]'));
    if (sentences.isNotEmpty) {
      return sentences.first.trim();
    } else {
      return text;
    }
  }

  void getFavorite() async {
    var userID = FirebaseAuth.instance.currentUser!.uid;
    // var favID = await FirebaseFirestore.instance.collectionGroup('favorite').get();
    var favID = await FirebaseFirestore.instance.collection('user').doc(userID).collection('favorite').get();

    setState(() {
      favoriteID = favID.docs;
    });
  }

  // void deleteFavorite(String itemID) async {
  //   var userID = FirebaseAuth.instance.currentUser!.uid;
  //   var favCollection = await FirebaseFirestore.instance.collection('user').doc(userID).collection('favorite');

  //   return favCollection.where('id tas', isEqualTo: itemID).;
  // }

  Future<dynamic> alert(BuildContext context, String judul, String kontent) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(judul),
          content: Text(kontent),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeModeData>(context).containerColor,
        title: Text(
          'FAVORITE',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body:
      favoriteID.length > 1 ?
      GestureDetector(
        onLongPress: () {
          alert(context, "Confirmation", "Are you sure want to delete this item from your favorite?");
          // deleteFavorite();
        },
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
          ),
          itemCount: favoriteID.length,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) {
            final item = favoriteID[index];
            return Column(
              children: <Widget>[
                Container(
                  width: 111,
                  height: 124,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    image: DecorationImage(
                        image: NetworkImage(item['gambar']),
                        repeat: ImageRepeat.repeat),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Expanded(
                    child: Text(getFirstSentence(item['nama'].toUpperCase())))
              ],
            );
          },
        ),
      )
      : Center(
        child: Text("There is no favorite item there"),
      ),
    );
  }
}
