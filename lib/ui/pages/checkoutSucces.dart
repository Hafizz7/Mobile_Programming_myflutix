import 'package:flutter/material.dart';
import 'package:myflutix/const/app_color.dart';
import 'package:myflutix/ui/pages/checkout.dart';

class CheckoutSucces extends StatefulWidget {
  const CheckoutSucces({super.key});

  @override
  State<CheckoutSucces> createState() => _CheckoutSuccesState();
}

class _CheckoutSuccesState extends State<CheckoutSucces> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage("assets/kucing.png"),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 1,                  
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                        'Payment Success!',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            height: 0,
                        ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
                  child: InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    child: InkWell(
                      onTap: () {
                        setState(() {});
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: ShapeDecoration(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Show Ticket',
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => checkOut()),
                        );
                    },           
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: ShapeDecoration(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Go To Home',
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
