import 'package:bio_clean/feature/bio_clean/presentation/page/home/detail.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/onboarding/bubble.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/onboarding/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user/user_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _listItem = [
    'machines',
    'machines',
    'machines',
    'machines',
    'machines',
  ];

  bool isCommentVisible = false;

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  String getFullName() {
    final String firstName = context.read<UserBloc>().state.user!.firstName;
    final String lastName = context.read<UserBloc>().state.user!.lastName;
    return '${capitalize(firstName)} ${capitalize(lastName)}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.loginStatus == LoginStatus.success) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingLayout()),
              (route) => false);
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color.fromRGBO(1, 127, 97, 0.1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                const BubbleScreen(
                    color: Color.fromARGB(31, 78, 161, 110),
                    numberOfBubbles: 5,
                    maxBubbleSize: 90),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCommentVisible = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage('assets/logo.png'),
                                width: 70,
                                height: 70,
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hey,',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                  Text(
                                    getFullName(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: Color.fromRGBO(1, 127, 97, 1),
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<UserBloc>()
                                      .add(const LogoutUserEvent());
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color.fromRGBO(1, 127, 97, 1),
                                  ),
                                  child: const Icon(
                                    Icons.logout_outlined,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromRGBO(1, 127, 97, 1),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome to',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 20,
                                        fontFamily: 'JosefinSans',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Text(
                                      'BIO CLEAN',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontFamily: 'JosefinSans',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: Text(
                                        'We are here to help you keep your environment clean.',
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 14,
                                          fontFamily: 'JosefinSans',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset('assets/home_logo.png'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Bio Cleaners',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'JosefinSans',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCommentVisible = !isCommentVisible;
                                  });
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color.fromRGBO(1, 127, 97, 1),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.52,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _listItem.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return const Detail();
                                      },
                                    ));
                                  },
                                  title: Text(
                                    _listItem[index]
                                            .substring(0, 1)
                                            .toUpperCase() +
                                        _listItem[index].substring(1),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'JosefinSans',
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(1, 127, 97, 1),
                                    ),
                                  ),
                                  subtitle: const Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 20,
                                        color: Color.fromRGBO(1, 127, 97, 1),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Kano',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'JosefinSans',
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(1, 127, 97, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                    color: Color.fromRGBO(1, 127, 97, 1),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isCommentVisible)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 5,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isCommentVisible = !isCommentVisible;
                                    });
                                  },
                                  child: const Image(
                                    image: AssetImage('assets/logo.png'),
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Hey, add information about your cleaner.",
                                        softWrap: true,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(
                              height: 55,
                              child: TextField(
                                decoration: InputDecoration(
                                  label: Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Machine Name',
                                      style: TextStyle(
                                        color: Color.fromRGBO(31, 31, 31, 0.6),
                                        fontSize: 15,
                                        fontFamily: 'openSans',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child:
                                        Icon(Icons.cleaning_services_outlined),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(230, 230, 230, 1),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(230, 230, 230, 1),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(
                              height: 55,
                              child: TextField(
                                decoration: InputDecoration(
                                  label: Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Serial Number',
                                      style: TextStyle(
                                        color: Color.fromRGBO(31, 31, 31, 0.6),
                                        fontSize: 15,
                                        fontFamily: 'openSans',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Icon(Icons.numbers_outlined),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(230, 230, 230, 1),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(230, 230, 230, 1),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(
                              height: 55,
                              child: TextField(
                                decoration: InputDecoration(
                                  label: Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Location',
                                      style: TextStyle(
                                        color: Color.fromRGBO(31, 31, 31, 0.6),
                                        fontSize: 15,
                                        fontFamily: 'openSans',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Icon(Icons.location_on_outlined),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(230, 230, 230, 1),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(230, 230, 230, 1),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 55),
                                backgroundColor:
                                    const Color.fromRGBO(1, 127, 97, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: const Text('Add Now',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'JosefinSans',
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
