import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myflutix/const/app_color.dart';
import 'package:myflutix/ui/widgets/home_promotion_container.dart';
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

  int activeIndex = 0; // Index for the selected image
  int activePromotionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            const SizedBox(
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
                  onPageChanged: (((index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  }))),
            ),
            const SizedBox(
              height: 10,
            ),
            buildIndicator(),
            const SizedBox(
              height: 20,
            ),
            CarouselSlider.builder(
              itemCount: 3, // Number of promotion containers
              itemBuilder: (context, index, realIndex) {
                // Replace with the actual PromotionContainer widget
                return PromotionContainer();
              },
              options: CarouselOptions(
                height: 100, // Adjust the height as needed
                enableInfiniteScroll: false, // To prevent infinite scrolling
                onPageChanged: (index, reason) {
                  setState(() {
                    activePromotionIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            buildPromotionIndicator(),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String imageUrl, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
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
        effect: ExpandingDotsEffect(
          activeDotColor: primaryColor,
          dotColor: Colors.grey,
          dotHeight: 8,
          dotWidth: 8,
        ),
      );

  Widget buildPromotionIndicator() => AnimatedSmoothIndicator(
        activeIndex: activePromotionIndex, // Use your active index variable
        count: 3, // Set the total count of promotion items
        effect: ExpandingDotsEffect(
          activeDotColor: primaryColor, // Customize the active dot color
          dotColor: Colors.grey, // Customize the inactive dot color
          dotHeight: 8, // Customize the dot height
          dotWidth: 8, // Customize the dot width
        ),
      );
}
