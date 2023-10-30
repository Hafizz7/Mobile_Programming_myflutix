import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: profile(),
    );
  }
}

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(fontSize: 15),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.all(15)),
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 25,
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    image: DecorationImage(
                      image: NetworkImage(
                          "data:image/jpeg;base64,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"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1,
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.all(9)),
                        Text(
                          "John Doe",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          width: 75,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.mode_edit),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text("john.doe@email.com"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text("Dasboard"),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.wallet),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text(
                      "My Wallet",
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.language),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text(
                      "Change Language",
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.help_center),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text(
                      "Help Center",
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.star),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text(
                      "Rate Flutix App",
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                Text(
                  "My Account",
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Switch to Other Account",
                  style: TextStyle(color: Color.fromARGB(255, 29, 5, 243)),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Log Out",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
