import 'package:flutter/material.dart';

class OrderSeat extends StatefulWidget {
  const OrderSeat({super.key});

  @override
  State<OrderSeat> createState() => _OrderSeatState();
}

class _OrderSeatState extends State<OrderSeat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(                
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: -8, // Mengatur posisi ikon dari sisi kiri
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
                color: Colors.green,
                decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow,
                image: const DecorationImage(
                    image: AssetImage("assets/Vextor 65.png"),
                    fit: BoxFit.cover),
              ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width * 0.26,
                color: Colors.blue,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width * 0.26,
                color: Colors.cyan,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width * 0.26,
                color: Colors.orange,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width * 0.26,
                color: Colors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
