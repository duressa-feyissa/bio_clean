import 'package:bio_clean/feature/bio_clean/presentation/page/home/history.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/home/info.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/onboarding/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/machine.dart';
import '../../bloc/input/input_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import 'circular.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key, required this.machine}) : super(key: key);

  final Machine machine;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool isCommentVisible = false;
  String inputId = '';

  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _wasteController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _mechanicController = TextEditingController();

  @override
  void dispose() {
    _typeController.dispose();
    _wasteController.dispose();
    _waterController.dispose();
    _mechanicController.dispose();
    super.dispose();
  }

  void onSubmitted() {
    if (_wasteController.text.isEmpty ||
        _waterController.text.isEmpty ||
        _mechanicController.text.isEmpty ||
        _typeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text('Please fill all fields')),
        ),
      );
      return;
    }
    final String type = _typeController.text;
    final double waste = double.parse(_wasteController.text);
    final double water = double.parse(_waterController.text);
    final double mechanic = double.parse(_mechanicController.text);

    context.read<InputBloc>().add(
          InputCreateEvent(
            machineId: widget.machine.id,
            token: context.read<UserBloc>().state.user!.token ?? '',
            type: type,
            waste: waste,
            water: water,
            methanol: mechanic,
          ),
        );
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

    myRecursiveFunction();
  }

  void myRecursiveFunction() {
    if (context.read<InputBloc>().state.inputs.isNotEmpty) {
      context.read<InputBloc>().add(InputViewEvent(
          id: context.read<InputBloc>().state.inputs.first.id,
          token: context.read<UserBloc>().state.user!.token ?? ''));
    }
    Future.delayed(const Duration(seconds: 2), myRecursiveFunction);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InputBloc, InputState>(
      listener: (context, state) {
        if (state.createStatus == InputCreateStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Center(
                child: Text('Input created successfully'),
              ),
              backgroundColor: Colors.green.withOpacity(0.6),
            ),
          );
          setState(() {
            isCommentVisible = false;
          });
          _typeController.clear();
          _wasteController.clear();
          _waterController.clear();
          _mechanicController.clear();
        } else if (state.createStatus == InputCreateStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Center(
                child: Text('Input add failed'),
              ),
              backgroundColor: Colors.red.withOpacity(0.6),
            ),
          );
        }

        if (state.getAllStatus == InputGetAllStatus.success) {
          if (state.inputs.isNotEmpty) {
            setState(() {
              inputId = state.inputs.first.id;
            });
          }
        }
      },
      child: Scaffold(
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCommentVisible = false;
                    });
                  },
                  child: SingleChildScrollView(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 3),
                                        child: Text(
                                          capitalizeAll(widget.machine.name),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            size: 20,
                                            color:
                                                Color.fromRGBO(1, 127, 97, 1),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            capitalizeAll(
                                                widget.machine.location),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'JosefinSans',
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  Color.fromRGBO(1, 127, 97, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => History(
                                                  machine: widget.machine),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromRGBO(
                                                1, 127, 97, 1),
                                          ),
                                          child: Icon(
                                            Icons.history_outlined,
                                            size: 30,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isCommentVisible =
                                                !isCommentVisible;
                                          });
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromRGBO(
                                                1, 127, 97, 1),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            size: 30,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            if (context
                                .read<InputBloc>()
                                .state
                                .inputs
                                .isNotEmpty)
                              DoubleCircularTimerWidget(
                                waterProgress: context
                                    .read<InputBloc>()
                                    .state
                                    .inputs
                                    .first
                                    .currentBioGasProduction,
                                biogasProgress: context
                                    .read<InputBloc>()
                                    .state
                                    .inputs
                                    .first
                                    .currentWaterProduction,
                              ),
                            if (context
                                    .read<InputBloc>()
                                    .state
                                    .inputs
                                    .isEmpty &&
                                context.read<InputBloc>().state.getAllStatus ==
                                    InputGetAllStatus.failure)
                              Center(
                                child: Text(
                                  'No data available',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                            if (context
                                .read<InputBloc>()
                                .state
                                .inputs
                                .isNotEmpty)
                              const SizedBox(height: 40),
                            if (context
                                .read<InputBloc>()
                                .state
                                .inputs
                                .isNotEmpty)
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withOpacity(0.05),
                                ),
                                child: Column(
                                  children: [
                                    Info(
                                      machine: widget.machine,
                                      input: context
                                          .read<InputBloc>()
                                          .state
                                          .inputs
                                          .first,
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (isCommentVisible)
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.05,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 5,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 5),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Hey, I'm Bio Clean. I'm here to help you manage your waste.",
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 16,
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
                          SizedBox(
                            height: 55,
                            child: TextField(
                              controller: _typeController,
                              decoration: const InputDecoration(
                                label: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Waste Type',
                                    style: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 15,
                                      fontFamily: 'openSans',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
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
                          SizedBox(
                            height: 55,
                            child: TextField(
                              controller: _wasteController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Waste Amount',
                                    style: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 15,
                                      fontFamily: 'openSans',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
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
                          SizedBox(
                            height: 55,
                            child: TextField(
                              controller: _waterController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Water Amount',
                                    style: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 15,
                                      fontFamily: 'openSans',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
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
                          SizedBox(
                            height: 55,
                            child: TextField(
                              controller: _mechanicController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Mechanic Amount',
                                    style: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 15,
                                      fontFamily: 'openSans',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
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
                            onPressed: onSubmitted,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 55),
                              backgroundColor:
                                  const Color.fromRGBO(1, 127, 97, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: const Text('Add New Waste',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
