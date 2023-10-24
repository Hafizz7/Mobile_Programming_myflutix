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
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.26,
              color: Colors.amber,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.26,
              color: Colors.green,
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
    );
  }
}