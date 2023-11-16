import 'package:flutter/material.dart';

class Bag_Details extends StatefulWidget {
  const Bag_Details({super.key});

  @override
  State<Bag_Details> createState() => _Bag_DetailsState();
}

class _Bag_DetailsState extends State<Bag_Details> {
  String selectedColor = 'Grey';

  Map<String, String> colorMap = {
    'Grey': 'Assets/grey_kierra.jpg',
    'Navy': 'Assets/navy_kierra.jpg',
    'Khaki': 'Assets/khaki_kierra.jpg',
    'Maroon': 'Assets/maroon_kierra.jpg',
  };

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Provider.of<ThemeModeData>(context).containerColor,
          backgroundColor: Color.fromRGBO(76, 83, 114, 1),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'HEYLOOK BACKPACK KIERRA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
      body: Stack(
        children: [
          Column(
            children: [
              Positioned(
                child: Container(
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
                        shape: RoundedRectangleBorder(
                            // borderRadius: BorderRadius.circular(10),
                            ),
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
              decoration: ShapeDecoration(
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
                      'HEYLOOK BACKPACK KIERRA',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Backpack dengan design casual dapat memuat banyak barang karena dilengkapi kompartemen luas sehingga dapat menampung laptop 14-15 inch, slot saku bagian depan, serta saku kiri kanan.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 10),
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
              decoration: ShapeDecoration(
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
                    Text(
                      'Warna',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 10.0,
                      children: colorMap.keys.map((String color) {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: color == selectedColor
                                ? Color.fromRGBO(76, 83, 114, 1)
                                : Colors.white,
                          ),
                          child: Text(
                            color,
                            style: TextStyle(
                              color: color == selectedColor
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Harga',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.justify,
                      'Rp165.000',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Jenis',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.justify,
                      'Tas Ransel Wanita',
                      style: TextStyle(
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
