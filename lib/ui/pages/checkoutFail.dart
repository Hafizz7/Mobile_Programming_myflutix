import 'package:flutter/material.dart';

class checkOutFail extends StatefulWidget {
  const checkOutFail({super.key});

  @override
  State<checkOutFail> createState() => _checkOutFailState();
}

class _checkOutFailState extends State<checkOutFail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
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
                          color: Color(0xFF6558F5),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: const Text(
                          'Checkout',
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
                SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 1,
                  color: Colors.amber,
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.42,
                      // 
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage("assets/avatar.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        child: Column(
                          children: [
                            SizedBox(height: 16),
                            //Judul Film
                            Container(
                              height: MediaQuery.of(context).size.height * 0.04,
                              width: MediaQuery.of(context).size.width * 0.46,
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Avatar : The Way Of Water',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            // genre film
                            Container(
                              height: MediaQuery.of(context).size.height * 0.04,
                              width: MediaQuery.of(context).size.width * 0.46,
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Fantasy/Action - English',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.04,
                              width: MediaQuery.of(context).size.width * 0.46,
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '3h 10min',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.46,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: <Widget>[
                                      for (int i = 0; i < 5; i++)
                                        const Icon(
                                          Icons.star,
                                          color: Color(0xFF6558F5),
                                          size: 24,
                                        ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                    ),
                  ),
                ),
                //bagian sub total
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height * 0.11,
                  width: MediaQuery.of(context).size.width * 1,                  
                  child: Column(children: [
                    //sub total checkout
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.width * 1,                      
                      child: Row(
                        children: [
                          //sub total checkout
                          Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.451,                            
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Subtotal',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.451,                            
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'IDR 75.000',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //tax
                      margin: EdgeInsets.only(top: 4),
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.width * 1,                      
                      child: Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.451,                            
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tax',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.451,                            
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'IDR 5.000',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.width * 1,                      
                      child: Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.451,                            
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Total',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.451,                            
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'IDR 80.000',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                //baris 2
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  height: MediaQuery.of(context).size.height * 0.03,
                  width: MediaQuery.of(context).size.width * 1,                  
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.03,
                        width: MediaQuery.of(context).size.width * 0.451,                        
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Saldo Wallet',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.03,
                        width: MediaQuery.of(context).size.width * 0.451,                        
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'IDR 100.000',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(                  
                    margin: EdgeInsets.only(top: 4),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.8,                           
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(                    
                          'Saldo anda tidak mencukupi,silahkan tambah saldo anda.',
                          style: TextStyle(
                              color: Color(0xFFD73E3E),
                              fontSize: 16,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w400,
                              height: 1,
                          ),
                      ),
                    ),
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
                        color: Color(0xFF6558F5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Confirm Payment',
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
          )
        ],
      ),
    );
  }
}
