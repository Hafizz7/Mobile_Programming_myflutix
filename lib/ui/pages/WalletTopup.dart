import 'package:flutter/material.dart';
import 'TopupSuccess.dart';

class TopupPage extends StatefulWidget {
  @override
  _TopupPageState createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  double _customAmount = 0.0;
  double _selectedAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top-Up Wallet"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                Text("Amount:"),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: const Color.fromARGB(255, 56, 56, 56),
                      width: 2.0,
                    ),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _customAmount = double.tryParse(value) ?? 0.0;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'IDR', // Placeholder text
                      contentPadding:
                          EdgeInsets.all(8.0), // Padding for the placeholder
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text("Top-Up Nominal :"),
                GridView.builder(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // This line disables scrolling
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: nominalOptions.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedAmount == nominalOptions[index];
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width: 120.0,
                        height: 80.0,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (isSelected) {
                                // Deselect the button if it's already selected
                                _selectedAmount = 0.0;
                              } else {
                                // Select the button if it's not selected
                                _selectedAmount = nominalOptions[index];
                              }
                            });
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              isSelected ? Color(0xFF6558F5) : Colors.white,
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          child: Text(
                            "Rp ${nominalOptions[index].toStringAsFixed(0)}",
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          Text(
              "Jumlah yang akan ditop-up: Rp ${_customAmount + _selectedAmount}"),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TopupSuccess()),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF6558F5)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text("Top-Up"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<double> nominalOptions = [50000, 75000, 100000, 250000, 1000000, 1500000];
