import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lienna_bag/Provider/themeMode.dart';
import 'package:provider/provider.dart';

class MerkPage extends StatefulWidget {
  final String merkName;
  const MerkPage({super.key, required this.merkName});

  @override
  State<MerkPage> createState() => _MerkPageState();
}

class _MerkPageState extends State<MerkPage> {
  @override
  void initState() {
    getClientStream();
    super.initState();
  }

  List<dynamic> _allResults = [];

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
    final themeModeData = Provider.of<ThemeModeData>(context);

    final orientation = MediaQuery.of(context).orientation;
    final item = _allResults.where((bag) {
      final name = bag['merk'].toString().toLowerCase();
      return name.contains(widget.merkName.toLowerCase());
    }).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeModeData>(context).containerColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.merkName,
            // 'MERK A',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge),
        centerTitle: true,
      ),
      body: Container(
        // decoration: const BoxDecoration(
        //   color: Color.fromARGB(119, 133, 99, 99),
        // ),
        child: Stack(children: <Widget>[
          Positioned(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 125,
            child: Center(
              child: Text(
                "Lieanna\nBag",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.30000001192092896),
                  fontSize: 48,
                  fontFamily: 'La Belle Aurore',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
            ),
            padding: const EdgeInsets.all(20),
            itemCount: item.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Container(
                    width: 111,
                    height: 124,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD9D9D9),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(item[index]['gambar']),
                          repeat: ImageRepeat.noRepeat),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Text(
                          getFirstSentence(item[index]['nama'].toUpperCase()),
                          style: Theme.of(context).textTheme.headlineMedium))
                ],
              );
            },
          ),
        ]),
      ),
    );
  }
}
