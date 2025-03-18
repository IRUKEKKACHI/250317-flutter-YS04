import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Widget> _pages = [
    Center(
      child: Text(
        "Onboarding 01",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        "Onboarding 02",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        "Onboarding 03",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          children: _pages,
        ),
        bottomSheet: _currentPage == _pages.length - 1
            ? Container(
                height: 60,
                width: double.infinity,
                color: Colors.blueGrey,
                child: TextButton(
                    onPressed: () async {
                      Navigator.pushReplacementNamed(context, '/auth');
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              )
            : Container(
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        _pageController.animateToPage(_pages.length - 1,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.linear);
                      },
                      child: Text('SKIP'),
                    ),
                    Row(
                        children: List.generate(_pages.length, (index) {
                      return Container(
                        margin: EdgeInsets.all(4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Colors.blueGrey
                                : Colors.blueGrey),
                      );
                    })),
                    TextButton(
                        onPressed: () {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 400),
                              curve: Curves.linear);
                        },
                        child: Text(
                          'NEXT',
                        ))
                  ],
                ),
              ));
  }
}
