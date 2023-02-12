import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todoapp/modules/shop_app/login_screen/login_screen.dart';
import 'package:todoapp/shared/componants/componants.dart';
import 'package:todoapp/shared/network/local/cache_helper.dart';

class BoardingModel {
  final String title;
  final String image;
  final String content;

  BoardingModel({
    required this.title,
    required this.image,
    required this.content,
  });
}

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var boardController = PageController();

  List<BoardingModel> Boarding = [
    BoardingModel(
        title: "Welcome To salla",
        image: 'assets/image/Onboarding-cuate.png',
        content: "Salla Welcome You"),
    BoardingModel(
        title: "On Boarding 2",
        image: 'assets/image/Onboarding-bro.png',
        content: "Salla Welcome You"),
    BoardingModel(
        title: "On Boarding 3",
        image: 'assets/image/Onboarding-cuate.png',
        content: "Salla Welcome You"),
  ];

  bool isLast = false;

  void submit() {
    cacheHelper.putDynamic(key: "onBoarding", value: true).then((value) {
      if (value!) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Salla",
          style: TextStyle(fontSize: 50, fontFamily: "Jannah"),
        ),
        titleSpacing: 30,
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: const Text(
              "skip",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: boardController,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildOnBoardingItem(Boarding[index]),
              itemCount: 3,
              onPageChanged: (index) {
                if (index == Boarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: Boarding.length,
                  axisDirection: Axis.horizontal,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 5,
                    spacing: 3,
                    activeDotColor: Colors.blue,
                  ),
                  onDotClicked: (index) {
                    boardController.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn);
                  },
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildOnBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image.asset(model.image)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              model.title,
              style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              model.content,
              style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Jannah"),
            ),
          ),
        ],
      );
}
