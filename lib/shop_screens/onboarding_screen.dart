import 'package:flutter/material.dart';
import 'package:shop/shop_screens/login_screen.dart';
import 'package:shop/components/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  String image;
  String title;
  String description;
  BoardingModel(this.image, this.title, this.description);
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

bool? isLast;

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    List<BoardingModel> boardings = [
      BoardingModel('images/boardings/bord1.jpg', 'OnBoarding 1',
          'description of boarding screen 1'),
      BoardingModel('images/boardings/bord2.jpg', 'OnBoarding 2',
          'description of boarding screen 2'),
      BoardingModel('images/boardings/bord3.jpg', 'OnBoarding 3',
          'description of boarding screen 2'),
    ];
    var controller = PageController();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: const Text('Skip'))
          ],
          backgroundColor: Colors.white,
        ),
        body: Column(children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: ((int value) {
                if (value == boardings.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              }),
              physics: const BouncingScrollPhysics(),
              controller: controller,
              itemBuilder: (context, index) => boardingItem(boardings[index]),
              itemCount: boardings.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                    controller: controller, // PageController
                    count: boardings.length,
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotWidth: 10,
                        spacing: 10.0,
                        dotHeight: 7,
                        expansionFactor: 3), // your preferred effect
                    onDotClicked: (index) {}),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    } else {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_sharp),
                ),
              ],
            ),
          )
        ]));
  }
}
