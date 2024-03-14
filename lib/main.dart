import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return _pages[index];
            },
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: _currentPage == index ? 14 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _pages[_currentPage].color, // Use page color
                      ),
                      child: Text(
                        'Join the Movement!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Login'),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final Color color;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'BeVietnamPro'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'BeVietnamPro'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<OnboardingPage> _pages = [
  OnboardingPage(
    title: 'Quality',
    description:
        'Sell your farm fresh products directly to consumers, cutting out the middleman and reducing emissions of the global supply chain. ',
    imageUrl: 'assets/images/onboard_1.png',
    color: Colors.red, // Color for the first page
  ),
  OnboardingPage(
    title: 'Convenient',
    description:
        'Our team of delivery drivers will make sure your orders are picked up on time and promptly delivered to your customers.',
    imageUrl: 'assets/images/onboard_2.png',
    color: Colors.green, // Color for the second page
  ),
  OnboardingPage(
    title: 'Local',
    description:
        'We love the earth and know you do too! Join us in reducing our local carbon footprint one order at a time. ',
    imageUrl: 'assets/images/onboard_3.png',
    color: Colors.blue, // Color for the third page
  ),
];
