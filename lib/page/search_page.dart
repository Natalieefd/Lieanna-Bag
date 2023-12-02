import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lienna_bag/page/about_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    getClientStream();
    super.initState();
  }

  void onSearchTextChanged(String query) {
    _searchResult.clear();
    if (query.isEmpty) {
      setState(() {});
      return;
    }

    for (var item in _allResults) {
      if (item['nama'].toLowerCase().contains(query.toLowerCase())) {
        _searchResult.add(item);
      }
    }
    setState(() {});
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('tas')
        .orderBy('nama')
        .get();

    setState(() {
      _allResults = data.docs;
    });
  }

  List _allResults = [];
  final List _searchResult = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9D8D8D),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                      controller: _searchController,
                      onChanged: onSearchTextChanged,
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
                    itemCount: _searchResult.isNotEmpty
                        ? _searchResult.length
                        : _allResults.length,
                    itemBuilder: (context, index) {
                      final item = _searchResult.isNotEmpty
                          ? _searchResult[index]
                          : _allResults[index];
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
                          backgroundImage: NetworkImage(item['gambar']),
                        ),
                        title: Text(
                          item['nama'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        subtitle: Text(item['jenis']),
                        trailing:
                            Text(CurrencyFormat.convertToIdr(item['harga'], 0)),
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
