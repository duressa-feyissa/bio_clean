import 'package:bio_clean/feature/bio_clean/presentation/page/home/info.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/onboarding/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/input.dart';
import '../../../domain/entities/machine.dart';
import '../../bloc/input/input_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import 'circular.dart';

class HistoryDetail extends StatefulWidget {
  const HistoryDetail({Key? key, required this.machine, required this.input})
      : super(key: key);

  final Machine machine;
  final Input input;

  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  @override
  void dispose() {
    super.dispose();
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  String capitalizeAll(String s) {
    final List<String> words = s.split(' ');
    String result = '';
    for (final word in words) {
      result += '${capitalize(word)} ';
    }
    return result;
  }

  @override
  void initState() {
    super.initState();

    context.read<InputBloc>().add(
          InputViewAllEvent(
            machineId: widget.machine.id,
            token: context.read<UserBloc>().state.user!.token ?? '',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color.fromRGBO(1, 127, 97, 0.1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Image(
                image: const AssetImage(
                  'assets/background.png',
                ),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              const BubbleScreen(
                  color: Color.fromARGB(31, 144, 201, 166),
                  numberOfBubbles: 3,
                  maxBubbleSize: 90),
              SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                  color: Color.fromRGBO(1, 127, 97, 1),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Text(
                                      capitalizeAll(widget.machine.name),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        size: 20,
                                        color: Color.fromRGBO(1, 127, 97, 1),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        capitalizeAll(widget.machine.location),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'JosefinSans',
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(1, 127, 97, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        DoubleCircularTimerWidget(
                          waterProgress: widget.input.currentWaterProduction,
                          biogasProgress: widget.input.currentBioGasProduction,
                        ),
                        const SizedBox(height: 40),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.05),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        capitalizeAll(widget.machine.name),
                                        softWrap: true,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white.withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Divider(
                                color: Colors.black.withOpacity(0.6),
                              ),
                              Info(
                                machine: widget.machine,
                                input: widget.input,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
