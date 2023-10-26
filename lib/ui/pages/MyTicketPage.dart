import 'package:flutter/material.dart';

class MyTicketPage extends StatefulWidget {
  @override
  _MyTicketPageState createState() => _MyTicketPageState();
}

class _MyTicketPageState extends State<MyTicketPage> {
  List<Ticket> myTickets = [
    Ticket(
      image: 'Avatar.jpg',
      title: 'Avatar',
      date: '15 Oktober 2023',
      time: '19:00',
      seatNumber: 'A12,A13,A14',
    ),
    Ticket(
      image: 'Avenger.jpg',
      title: 'Avenger',
      date: '20 November 2023',
      time: '15:30',
      seatNumber: 'B5',
    ),
    Ticket(
      image: 'Archer.jpg',
      title: 'Archer',
      date: '20 November 2023',
      time: '15:30',
      seatNumber: 'A5',
    ),
    Ticket(
      image: 'Archer.jpg',
      title: 'Archer',
      date: '20 November 2023',
      time: '15:30',
      seatNumber: 'A5',
    ),
    Ticket(
      image: 'Archer.jpg',
      title: 'Archer',
      date: '20 November 2023',
      time: '15:30',
      seatNumber: 'A5',
    ),
    Ticket(
      image: 'Archer.jpg',
      title: 'Archer',
      date: '20 November 2023',
      time: '15:30',
      seatNumber: 'A5',
    ),
  ];

  List<Ticket> filteredTickets = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredTickets = myTickets;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tickets'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  filteredTickets = myTickets
                      .where((ticket) => ticket.title
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTickets.length,
              itemBuilder: (context, index) {
                return TicketCard(ticket: filteredTickets[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Ticket {
  final String image;
  final String title;
  final String date;
  final String time;
  final String seatNumber;

  Ticket({
    required this.image,
    required this.title,
    required this.date,
    required this.time,
    required this.seatNumber,
  });
}

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  TicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double imageHeight = screenHeight * 0.2;

    return Card(
      margin: EdgeInsets.all(8.0),
      color: Color(0xFF6558F5), // Background color for the entire card
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.asset(
              'assets/${ticket.image}',
              height: imageHeight,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            flex: 2,
            child: ListTile(
              title: Text(
                ticket.title,
                style: TextStyle(color: Colors.white), // Text color
              ),
              subtitle: Text(
                '${ticket.date} \n${ticket.time}\n${ticket.seatNumber}',
                style: TextStyle(color: Colors.white), // Text color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
