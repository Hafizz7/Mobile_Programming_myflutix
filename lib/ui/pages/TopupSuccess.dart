import 'package:flutter/material.dart';
import 'package:myflutix/const/app_color.dart';
import 'package:myflutix/ui/pages/home_page.dart';

class TopupSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.asset('assets/gambar.png'),
            ),
            SizedBox(height: 20.0),
            Text(
              "TOP UP SUCCESS",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: MediaQuery.of(context).size.width *
                  0.8, // Set the width to 80% of screen width
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  child: Text(
                    "Go To Home",
                    style: TextStyle(
                      color: Colors.white, // Set the text color to white
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
