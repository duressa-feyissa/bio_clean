import 'package:bio_clean/feature/bio_clean/presentation/bloc/input/input_bloc.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/home/ai.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/home/history_detail.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/onboarding/bubble.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/machine.dart';

List<String> months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

class History extends StatefulWidget {
  const History({Key? key, required this.machine}) : super(key: key);

  final Machine machine;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color.fromRGBO(1, 127, 97, 0.1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView(
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
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Analysis(machine: widget.machine);
                                }));
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color.fromRGBO(1, 127, 97, 1),
                                ),
                                child: Icon(
                                  Icons.analytics_outlined,
                                  size: 30,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: const BarChartWidget(),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.03),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.05),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'History',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Divider(
                                color: Colors.black.withOpacity(0.4),
                                thickness: 1),
                            const SizedBox(height: 10),
                            for (int i = 0;
                                i <
                                    context
                                        .read<InputBloc>()
                                        .state
                                        .inputs
                                        .length;
                                i++)
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return HistoryDetail(
                                          input: context
                                              .read<InputBloc>()
                                              .state
                                              .inputs[i],
                                          machine: widget.machine);
                                    },
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 75,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white.withOpacity(0.1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            months[context
                                                    .read<InputBloc>()
                                                    .state
                                                    .inputs[i]
                                                    .createdAt
                                                    .month -
                                                1],
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              color: const Color.fromRGBO(
                                                      255, 176, 57, 0.5)
                                                  .withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${context.read<InputBloc>().state.inputs[i].createdAt.year}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                            ),
                                          ),
                                          Text(
                                            '${context.read<InputBloc>().state.inputs[i].createdAt.day} - ${i == 0 ? 'Present' : '${context.read<InputBloc>().state.inputs[i - 1].createdAt.day}'}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'JosefinSans',
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 25,
                                        color: Color.fromRGBO(1, 127, 97, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
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

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          maxY: 100,
          barGroups: createBarGroups(context),
          alignment: BarChartAlignment.center,
          groupsSpace: 25,
          gridData: FlGridData(
            show: true,
            horizontalInterval: 10,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.white.withOpacity(0.1),
                strokeWidth: 2,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Colors.transparent,
              );
            },
          ),
          borderData: FlBorderData(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.1),
                width: 2,
              ),
              left: const BorderSide(color: Colors.transparent),
              right: const BorderSide(color: Colors.transparent),
              top: const BorderSide(color: Colors.transparent),
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: true,
              getTextStyles: (context, value) => TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              margin: 10,
              reservedSize: 30,
            ),
            topTitles: SideTitles(
              showTitles: false,
            ),
            rightTitles: SideTitles(
              showTitles: false,
            ),
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (context, value) => TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w400,
                fontSize: 10,
              ),
              margin: 10,
              getTitles: (double value) {
                return "${months[context.read<InputBloc>().state.inputs[value.toInt()].createdAt.month - 1]}-${context.read<InputBloc>().state.inputs[value.toInt()].createdAt.day.toString()}\n${context.read<InputBloc>().state.inputs[value.toInt()].createdAt.year}";
              },
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> createBarGroups(BuildContext context) {
    return [
      for (int index = 0;
          index < context.read<InputBloc>().state.inputs.length;
          index++)
        BarChartGroupData(
          x: index,
          barsSpace: 3,
          barRods: [
            BarChartRodData(
              width: 10,
              y: context
                      .read<InputBloc>()
                      .state
                      .inputs[index]
                      .bioGasProduction *
                  100,
              colors: [
                const Color.fromRGBO(9, 182, 141, 1),
              ],
            ),
            BarChartRodData(
              width: 10,
              y: context.read<InputBloc>().state.inputs[index].waterProduction *
                  100,
              colors: [
                const Color.fromRGBO(42, 223, 236, 1),
              ],
            ),
          ],
        ),
    ];
  }
}
