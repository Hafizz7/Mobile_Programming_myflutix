import 'package:flutter/material.dart';

class MyWalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wallet'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Color(0xFF6558F5),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    'Your Balance',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  Text(
                    'Rp 10,000,000',
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Topup',
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                            Text(
                              'IDR 50,000',
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1.0,
                        height: 50.0,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Expense',
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                            Text(
                              'IDR 250,000',
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            for (var transaction in recentTransactions)
              TransactionCard(
                title: transaction.title,
                date: transaction.date,
                time: transaction.time,
                seatNumber: transaction.seatNumber,
              ),
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final String title;
  final String date;
  final String time;
  final String seatNumber;

  Transaction({
    required this.title,
    required this.date,
    required this.time,
    required this.seatNumber,
  });
}

class TransactionCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String seatNumber;

  TransactionCard({
    required this.title,
    required this.date,
    required this.time,
    required this.seatNumber,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double imageHeight = screenHeight * 0.15;

    return Card(
      margin: EdgeInsets.all(8.0),
      color: Color(0xFF6558F5),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.asset(
              'assets/$title.jpg', // Assuming you have an image with the title as the file name
              height: imageHeight,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            flex: 2,
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                '$date\n$time\n$seatNumber',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final recentTransactions = [
  Transaction(
    title: 'Avatar',
    date: '15 Oktober 2023',
    time: '19:00',
    seatNumber: 'A12, A13, A14',
  ),
  Transaction(
    title: 'Avenger',
    date: '20 November 2023',
    time: '15:30',
    seatNumber: 'B5',
  ),
  Transaction(
    title: 'Archer',
    date: '20 November 2023',
    time: '15:30',
    seatNumber: 'A5',
  ),
  Transaction(
    title: 'Archer',
    date: '20 November 2023',
    time: '15:30',
    seatNumber: 'A5',
  ),
];