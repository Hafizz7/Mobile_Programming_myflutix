import 'package:flutter/material.dart';
import 'package:myflutix/const/app_color.dart';

class OrderSeat extends StatefulWidget {
  const OrderSeat({super.key});

  @override
  State<OrderSeat> createState() => _OrderSeatState();
}

class _OrderSeatState extends State<OrderSeat> {
  int selectedJamIndex = -1;
  List<daftarKursi> daftarkursiku = [
    daftarKursi(nomorKursi: "A1", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "A2", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "A3", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "A4", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "A5", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "A6", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "B1", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "B2", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "B3", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "B4", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "B5", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "B6", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "C1", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "C2", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "C3", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "C4", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "C5", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "C6", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "C1", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "C2", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "C3", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "C4", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "C5", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "C6", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "D1", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "D2", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "D3", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "D4", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "D5", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "D6", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "E1", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "E2", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "E3", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "E4", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "E5", statusKursi: "Kebeli"),
    daftarKursi(nomorKursi: "E6", statusKursi: "Kebeli"),
  ];
  List<jamNonton> jamTonton = [
    jamNonton(jam: "11:00"),
    jamNonton(jam: "13:00"),
    jamNonton(jam: "14:30"),
    jamNonton(jam: "18:00"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: -8, 
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_circle_left_outlined),
                        iconSize: 30,
                        color: primaryColor,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: const Text(
                        'Select Time & Seat',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/Vector 66.png"),
                  ),
                ),
              ),
              //membuat kursi
              Container(
                // height: MediaQuery.of(context).size.height * 0.2,
                // width: MediaQuery.of(context).size.width * 1,
                // color: Colors.blue,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    childAspectRatio: 0.99,
                  ),
                  itemCount: daftarkursiku.length,
                  itemBuilder: (_, i) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          daftarkursiku[i].toggleEnlarged();
                        });
                      },
                      child: buildContentItem(daftarkursiku[i]),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.26,
                // color: Colors.black26,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: OvalBorder(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Available',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: ShapeDecoration(
                        color: Color(0xFF0E1629),
                        shape: OvalBorder(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Reserved',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: ShapeDecoration(
                        color: primaryColor,
                        shape: OvalBorder(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Selected',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.26,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2,
                  ),
                  itemCount: jamTonton.length,
                  itemBuilder: (_, i) {
                    final isItemSelected = selectedJamIndex == i;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (isItemSelected) {
                            // Jika item sudah dipilih, batalkan pemilihan
                            selectedJamIndex = -1;
                          } else {
                            // Jika item belum dipilih, pilih item ini dan batalkan pemilihan yang sebelumnya
                            selectedJamIndex = i;
                          }
                        });
                      },
                      child: buildContentItems(jamTonton[i],
                          isItemSelected: isItemSelected),
                    );
                  },
                ),
              ),
              Padding(                
                padding: const EdgeInsets.only(left: 50,right: 50,top: 30),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      
                    });
                  },
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        
                      });
                    },
                    child: Container(                  
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: ShapeDecoration(
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Buy Ticket IDR 75.000',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildContentItems(jamNonton item, {bool isItemSelected = false}) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(9.0),
      child: Container(
        color: isItemSelected ? primaryColor : Color(0xFFD9D9D9),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            '${item.jam}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildContentItem(daftarKursi item) {
  return Container(
      child: Padding(
    padding: const EdgeInsets.all(9.0),
    child: Container(
      width: 30,
      height: 30,
      decoration: ShapeDecoration(
        // color: Color(0xFFD9D9D9),
        color: item.slect ? primaryColor : Color(0xFFD9D9D9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "${item.nomorKursi}",
          style: TextStyle(
            color: item.slect ? Color(0xFFD9D9D9) : Colors.black,
            fontSize: 12,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ),
    ),
  ));
}

class daftarKursi {
  bool slect = false;
  final String nomorKursi;
  final String statusKursi;

  daftarKursi({required this.nomorKursi, required this.statusKursi});
  void toggleEnlarged() {
    slect = !slect;
  }
}

class jamNonton {
  final String jam;

  jamNonton({required this.jam});
}
