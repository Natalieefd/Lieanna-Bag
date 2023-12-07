import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lienna_bag/Provider/themeMode.dart';
import 'package:lienna_bag/page/search_page.dart';
import 'package:provider/provider.dart';

class BagDetails extends StatefulWidget {
  final String itemId;
  const BagDetails({super.key, required this.itemId});

  @override
  State<BagDetails> createState() => _BagDetailsState();
}

class _BagDetailsState extends State<BagDetails> {
  String selectedColor = '';
  bool isFavorite = false;
  Map<String, String> colorMap = {};

  @override
  void initState() {
    super.initState();
    fetchData(widget.itemId);
  }

  String itemImage = '';
  String itemWarna = '';
  String itemName = '';
  String itemDescription = '';
  int itemPrice = 0;
  String itemType = '';

  Future<void> fetchData(String itemId) async {
    var document =
        await FirebaseFirestore.instance.collection('tas').doc(itemId).get();

    var desain = await FirebaseFirestore.instance
        .collection('tas')
        .doc(itemId)
        .collection('desain')
        .get();

    var desainDocument = desain.docs;
    
    setState(() {
      itemName = document['nama'];
      itemDescription = document['deskripsi'];
      itemPrice = document['harga'];
      itemType = document['jenis'];

      for(final i in desainDocument) {
        colorMap[i.get('warna')] = i.get('gambar');
      }
    });
  }

  Future<void> addFavorite(String idTas, String nama, String gambar) async {
    var userID = FirebaseAuth.instance.currentUser!.uid;
    var userCollection = FirebaseFirestore.instance.collection('user');

    userCollection
        .doc(userID)
        .collection('favorite')
        .doc(idTas)
        .set({'id tas': idTas, 'gambar': gambar, 'nama': nama});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeModeData>(context).containerColor,
        title: Text(
          "BAG DETAIL",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Positioned(
                child: Container(
                  width: lebar,
                  height: 250,
                  alignment: AlignmentDirectional.center,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image:
                        NetworkImage(colorMap[selectedColor]?? "https://firebasestorage.googleapis.com/v0/b/lieanna-bag.appspot.com/o/images%2Fproducts%2FSELECT_COLOR_Light.png?alt=media&token=9545fee5-6745-43e1-b74b-0589e945ef44")
                        ,
                      fit: BoxFit.contain,
                    ),
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                        // borderRadius: BorderRadius.circular(10),
                        ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 180,
            child: Container(
              width: lebar,
              height: tinggi - 310,
              decoration: ShapeDecoration(
                color: Provider.of<ThemeModeData>(context).containerColor,
                // color: Color.fromRGBO(76, 83, 114, 1),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
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
                      itemName,
                      // 'HEYLOOK BACKPACK KIERRA',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(itemDescription,
                        // 'Backpack dengan design casual dapat memuat banyak barang karena dilengkapi kompartemen luas sehingga dapat menampung laptop 14-15 inch, slot saku bagian depan, serta saku kiri kanan.',
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: tinggi - 410,
            child: Container(
              width: lebar,
              height: tinggi - 300,
              decoration: ShapeDecoration(
                color: Provider.of<ThemeModeData>(context).container2Color,
                // color: Color.fromRGBO(148, 154, 177, 1),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Warna',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ButtonSegment(
                      colorMap: colorMap,
                      selectedColor: selectedColor,
                      onColorSelected: (color) {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Harga',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.justify,
                      CurrencyFormat.convertToIdr(itemPrice, 0),
                      // 'Rp165.000',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Jenis',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.justify,
                      itemType,
                      // 'Tas Ransel Wanita',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: size.width - 50,
                        child: CupertinoButton(
                          color: Provider.of<ThemeModeData>(context)
                              .containerColor,
                          child: Text("Tambahkan ke Favorite",
                              style: Theme.of(context).textTheme.headlineSmall),
                          onPressed: () {
                            addFavorite(widget.itemId, itemName, itemImage);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Produk Berhasil Ditambahkan sebagai Favorit!"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonSegment extends StatelessWidget {
  final Map<String, String> colorMap;
  final String selectedColor;
  final Function(String) onColorSelected;

  const ButtonSegment({
    super.key,
    required this.colorMap,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 10.0,
      children: colorMap.keys.map((String color) {
        bool isSelected = color == selectedColor;

        return GestureDetector(
          onTap: () {
            onColorSelected(color);
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color.fromRGBO(76, 83, 114, 1)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: isSelected ? Colors.white : Colors.black,
                width: 2.0,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isSelected
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16.0,
                      )
                    : Container(),
                SizedBox(width: isSelected ? 4.0 : 0),
                Text(
                  color,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
