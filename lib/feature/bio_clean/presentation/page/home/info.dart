import 'package:flutter/material.dart';

import '../../../domain/entities/input.dart';
import '../../../domain/entities/machine.dart';

class Info extends StatelessWidget {
  const Info({Key? key, required this.machine, required this.input})
      : super(key: key);

  final Machine machine;
  final Input input;

  @override
  Widget build(BuildContext context) {
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

    Color color = const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          'S/N: ${machine.serialNumber}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Waste Type: ${input.type}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Water Added: ${input.water}L',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Waste Added: ${input.waste}Kg',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Mechanic Added: ${input.methanol}Kg',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Start Production: ${months[input.createdAt.month - 1]}-${input.createdAt.day}-${input.createdAt.year}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Current Biogas Status: ${(input.currentBioGasProduction * 100).ceil()} M3',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Current Water Status: ${(input.currentWaterProduction * input.water).ceil()}L',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Maximum Biogas Production: ${(input.bioGasProduction * 100).ceil()} M3',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Maximum Water Production: ${(input.waterProduction * input.water).ceil()}L',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ],
    );
  }
}
