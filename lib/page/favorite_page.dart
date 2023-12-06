import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  // final String itemId;
  const FavoritePage({super.key,
  // required this.itemId
  });

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    getClientStream();
    super.initState();
  }

  List _allResults = [];

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

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF9D8D8D),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'FAVORITE',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3, 
          crossAxisSpacing: 20.0, 
          mainAxisSpacing: 20.0, 
        ),
        itemCount: _allResults.length,
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          final item = _allResults[index];
          return Column(
            children: <Widget>[
              Container(
                width: 111,
                height: 124,
                decoration: ShapeDecoration(
                  color: const Color(0xFFD9D9D9),
                  image: DecorationImage(
                    image: NetworkImage(item['gambar']),
                    repeat: ImageRepeat.repeat
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(child: Text(getFirstSentence(item['nama'].toUpperCase())))
            ],
          );
        },
      ),
    );
  }
}
