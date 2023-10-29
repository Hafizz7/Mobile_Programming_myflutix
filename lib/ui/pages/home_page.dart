import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:myflutix/ui/widgets/home_category_button.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final imagesUrl = [
    'barbie_poster.jpeg',
    'oppenheimer_poster.jpeg',
    'avatar_poster.jpeg',
  ];

  int activeIndex = 0; 
 // Index for the selected image
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Container(
              height: 50,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 5,
                    offset: Offset(2, 2),
                    spreadRadius: 0,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Container(
              height: 30,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  HomeCustomButton(
                    text: "Now Playing",
                    onPressed: () {},
                  ),
                  HomeCustomButton(
                    text: "Coming Soon",
                    onPressed: () {},
                  ),
                  HomeCustomButton(
                    text: "Trending",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CarouselSlider.builder(
            itemCount: imagesUrl.length,
            itemBuilder: ((context, index, realIndex) {
              final imageUrl = imagesUrl[index];
              return buildImage(imageUrl, index);
            }),
            options: CarouselOptions(
              height: 350,
              autoPlay: true,
              enlargeCenterPage: true,
              initialPage: 1,
              onPageChanged: (((index, reason) {
                setState(() {
                  activeIndex = index;
                });
              }))
            ),
          ),
          SizedBox(height: 10,),
          buildIndicator(),
        ],
      ),
    );
  }

  Widget buildImage(String imageUrl, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.contain,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: imagesUrl.length,
  );
}
