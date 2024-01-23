import 'package:bio_clean/feature/bio_clean/presentation/page/entrance/login.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/entrance/register.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/onboarding/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EntranceLayout extends StatefulWidget {
  const EntranceLayout({Key? key}) : super(key: key);

  static const routeName = '/EntranceLayout';

  @override
  State<EntranceLayout> createState() => _EntranceLayoutState();
}

class _EntranceLayoutState extends State<EntranceLayout> {
  int index = 0;

  void onChange(int index) {
    if (index == 0 || index == 1) {
      setState(() {
        this.index = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      body: Stack(
        children: [
          const BubbleScreen(
            maxBubbleSize: 90,
            numberOfBubbles: 4,
            color: Color.fromRGBO(0, 0, 0, 0.03),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
            child: index == 0
                ? Login(onChange: onChange)
                : Register(onChange: onChange),
          ),
        ],
      ),
    );
  }
}
