import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String selectedColor = 'Grey';
  bool isFavorite = false;

  Map<String, String> colorMap = {
    'Grey': 'Assets/grey_kierra.jpg',
    'Navy': 'Assets/navy_kierra.jpg',
    'Khaki': 'Assets/khaki_kierra.jpg',
    'Maroon': 'Assets/maroon_kierra.jpg',
  };

  @override
  void initState() {
    super.initState();
    fetchData(widget.itemId);
  }

  String itemImage = '';
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

    var desainDocument = desain.docs[0];

    setState(() {
      itemImage = desainDocument['gambar'];
      itemName = document['nama'];
      itemDescription = document['deskripsi'];
      itemPrice = document['harga'];
      itemType = document['jenis'];
    });
  }

  Future<void> addFavorite(String idTas) async {
    var userID = FirebaseAuth.instance.currentUser!.uid;
    var userCollection = await FirebaseFirestore.instance.collection('user');

    userCollection
        .doc(userID)
        .collection('favorite')
        .doc()
        .set({'id tas': idTas});
  }

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeModeData>(context).containerColor,
        title: Text(
          widget.itemId,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Positioned(
                child: GestureDetector(
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => Merk_Page(),
                  //     ),
                  //   );
                  // },
                  child: Container(
                    width: lebar,
                    height: 250,
                    alignment: AlignmentDirectional.center,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage(colorMap[selectedColor]!),
                        fit: BoxFit.contain,
                      ),
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                          // borderRadius: BorderRadius.circular(10),
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 220,
            child: Container(
              width: lebar,
              height: tinggi - 310,
              decoration: const ShapeDecoration(
                // color: Provider.of<ThemeModeData>(context).containerColor,
                color: Color.fromRGBO(76, 83, 114, 1),
                shape: RoundedRectangleBorder(
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
                    Text(
                      itemDescription,
                      // 'Backpack dengan design casual dapat memuat banyak barang karena dilengkapi kompartemen luas sehingga dapat menampung laptop 14-15 inch, slot saku bagian depan, serta saku kiri kanan.',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: tinggi - 370,
            child: Container(
              width: lebar,
              height: tinggi - 300,
              decoration: const ShapeDecoration(
                // color: Provider.of<ThemeModeData>(context).container2Color,
                color: Color.fromRGBO(148, 154, 177, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Warna',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            addFavorite(widget.itemId);
                          },
                          icon: const Icon(
                            Icons.favorite_sharp,
                          ),
                        )
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
