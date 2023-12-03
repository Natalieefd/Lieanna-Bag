import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lienna_bag/page/bag_details.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSnackBarDisplay = false;
  String searchTas = '';
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _allResults = [];

  @override
  void initState() {
    _initData();
    super.initState();
  }

  Future<void> getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('tas')
        .orderBy('nama')
        .get();

    setState(() {
      _allResults = data.docs;
    });
  }

void _initData() async {
    await getClientStream();
  }

  void _showSnackBar(BuildContext context) {
    if (!isSnackBarDisplay) {
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color.fromARGB(255, 129, 36, 29),
            content: const Text(
              'Not Found!',
              style: TextStyle(color: Colors.white),
            ),
            action: SnackBarAction(
              label: 'OK',
              textColor: Colors.white,
              onPressed: () {
                isSnackBarDisplay = false;
              },
            ),
          ),
        );
      });
      isSnackBarDisplay = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> filteredBags =
        _allResults.where((bag) {
      final name = bag['nama'].toString().toLowerCase();
      return name.contains(searchTas.toLowerCase());
    }).toList();

    if (searchTas.isNotEmpty && filteredBags.isEmpty) {
      _showSnackBar(context);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9D8D8D),
        title: const Text(
          'SEARCH',
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.28, -0.96),
            end: Alignment(-0.28, 0.96),
            colors: [Color(0xFF9D8D8D), Color(0x779E6E6E)],
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Stack(
          children: <Widget>[
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
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 41.0, right: 41.0, bottom: 10),
                  child: Container(
                    width: 278,
                    height: 35,
                    padding: const EdgeInsets.only(right: 2.0, left: 10.0),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchTas = value;
                        });
                      },
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search your bag',
                        hintStyle: TextStyle(
                          height: 0,
                          fontSize: 18,
                          color: Color.fromARGB(255, 116, 78, 78),
                        ),
                        suffixIcon: Icon(Icons.search_rounded),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: filteredBags.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (item) => const About_Page(),
                              ));
                        },
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              NetworkImage(filteredBags[index]['gambar']),
                        ),
                        title: Text(
                          filteredBags[index]['nama'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        subtitle: Text(filteredBags[index]['jenis']),
                        trailing: Text(CurrencyFormat.convertToIdr(
                            filteredBags[index]['harga'], 0)),
                      );
                    },
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

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
