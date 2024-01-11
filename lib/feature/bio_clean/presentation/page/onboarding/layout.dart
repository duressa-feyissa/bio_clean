import 'package:bio_clean/feature/bio_clean/presentation/bloc/user/user_bloc.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/entrance/layout.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/home/home.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/onboarding/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingLayout extends StatefulWidget {
  const OnboardingLayout({Key? key}) : super(key: key);

  @override
  State<OnboardingLayout> createState() => _OnboardingLayoutState();
}

class _OnboardingLayoutState extends State<OnboardingLayout> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      onPageChanged(_pageController.page!.round());
    });

    context.read<UserBloc>().add(const GetUserEvent());
    context.read<UserBloc>().stream.listen((event) {
      if (event.status == UserStatus.success) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }
    });
  }

  void onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: SizedBox.expand(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              onPageChanged(currentPage - 1);
            } else {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              onPageChanged(currentPage + 1);
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: onPageChanged,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Image.asset(
                    'assets/onboarding/${index + 1}.png',
                    fit: BoxFit.cover,
                  );
                },
              ),
              const BubbleScreen(
                numberOfBubbles: 3,
                maxBubbleSize: 90,
                color: Color.fromRGBO(255, 208, 215, 0.05),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.04,
                  vertical: MediaQuery.of(context).size.height * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (currentPage < 3) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EntranceLayout()));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.white.withOpacity(0.35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        currentPage == 3 ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'JosefinSans',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
