import 'package:flutter/material.dart';
import 'package:myflutix/const/app_color.dart';

class MyMovieDetailPage extends StatefulWidget {
  const MyMovieDetailPage({super.key});

  @override
  State<MyMovieDetailPage> createState() => _MyMovieDetailPageState();
}

class _MyMovieDetailPageState extends State<MyMovieDetailPage> {
  bool isReadmore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 235,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.0, 0.50, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset('avatar_details.png'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.watch_later_outlined),
                Text("3h 10min"),
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.star_border),
                Text("4.0/5"),
                SizedBox(
                  width: 15,
                ),
                Text("Fantasy/Action"),
                SizedBox(
                  width: 15,
                ),
                Text("English"),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Jake Sully lives with his newfound family formed on the extrasolar moon Pandora. Once a familiar threat returns to finish what was previously started, Jake must work with Neytiri and the army of the Na\'vi race to protect their home.',
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              maxLines: (isReadmore ? null : 3),
              overflow:
                  (isReadmore ? TextOverflow.visible : TextOverflow.ellipsis),
            ),
          ),
          const SizedBox(
            height: 1.5,
          ),
          InkWell(
            onTap: () {
              setState(() {
                isReadmore = !isReadmore;
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                (isReadmore ? 'Read Less' : 'Read More'),
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 11,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          const Text(
            'Cast',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          Container(
            height: 80, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10, // Adjust the number of cast members
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 50,
                    height: 70,
                    decoration: const ShapeDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage("gambar.png"), // Use a valid image URL
                        fit: BoxFit.contain,
                      ),
                      shape: StadiumBorder(),
                    ),
                  ),
                );
              },
            ),
          ),
          const Text(
            'Select Place & Date',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      'SCP XXI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 5), // Adjust the spacing between text and dates
                  Row(
                    children: [
                      DateBox('25 June'),
                      DateBox('26 June'),
                      DateBox('27 June'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
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
                  'Get Reservation',
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
        ],
      ),
    );
  }

  Widget DateBox(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 60,
        height: 25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  date,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
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
    );
  }

  Widget buildText(String text) {
    final lines = isReadmore ? null : 3;
    return Text(
      text,
      style: const TextStyle(fontSize: 25),
      maxLines: lines,
      overflow: isReadmore ? TextOverflow.visible : TextOverflow.ellipsis,
    );
  }
}
