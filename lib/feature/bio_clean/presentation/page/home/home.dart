import 'dart:math';

import 'package:bio_clean/feature/bio_clean/presentation/page/home/detail.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/onboarding/bubble.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/onboarding/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/machine/machine_bloc.dart';
import '../../bloc/user/user_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

Random random = Random();

class _HomeState extends State<Home> {
  final TextEditingController _machineNameController = TextEditingController();
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool isCommentVisible = false;
  bool add = true;
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  String machineId = '';

  String getFullName() {
    final String firstName = context.read<UserBloc>().state.user!.firstName;
    final String lastName = context.read<UserBloc>().state.user!.lastName;
    return '${capitalize(firstName)} ${capitalize(lastName)}';
  }

  bool isSerialTakeVissible = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    context.read<MachineBloc>().add(
          MachineGetAllEvent(
              userId: context.read<UserBloc>().state.user!.id,
              token: context.read<UserBloc>().state.user!.token ?? '',
              machinesId: context.read<MachineBloc>().state.serials),
        );
  }

  @override
  void dispose() {
    _machineNameController.dispose();
    _serialNumberController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void onAddMachine() {
    final String machineName = _machineNameController.text;
    final String serialNumber = _serialNumberController.text;
    final String location = _locationController.text;

    if (machineName.isEmpty || serialNumber.isEmpty || location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text('Please fill all fields')),
        ),
      );
      return;
    }

    if (add) {
      context.read<MachineBloc>().add(
            MachineCreateEvent(
              name: machineName,
              userId: context.read<UserBloc>().state.user!.id,
              serialNumber: serialNumber,
              token: context.read<UserBloc>().state.user!.token ?? '',
              location: location,
            ),
          );
    } else {
      context.read<MachineBloc>().add(
            MachineUpdateEvent(
              id: machineId,
              name: machineName,
              serialNumber: serialNumber,
              token: context.read<UserBloc>().state.user!.token ?? '',
              location: location,
            ),
          );
      add = false;
    }
  }

  void setSerialTakeVissible() => setState(() {
        isSerialTakeVissible = !isSerialTakeVissible;
        isCommentVisible = false;
      });

  void setAdd(bool value) => setState(() {
        add = value;
      });

  void onAddNewSerialMachine() {
    final String serialNumber = _serialNumberController.text;

    if (serialNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text('Please fill the serial number')),
        ),
      );
      return;
    }

    context.read<MachineBloc>().add(
          MachineGetAllEvent(
            userId: context.read<UserBloc>().state.user!.id,
            token: context.read<UserBloc>().state.user!.token ?? '',
            machinesId: [serialNumber],
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.loginStatus == LoginStatus.success) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingLayout()),
              (route) => false);
        }
      },
      child: BlocListener<MachineBloc, MachineState>(
        listener: (context, state) {
          if (state.getAllStatus == MachineGetAllStatus.success) {
            setState(() {
              isCommentVisible = false;
              isSerialTakeVissible = false;
              _serialNumberController.clear();
            });
          }
          if (state.createStatus == MachineCreateStatus.success) {
            setState(() {
              isCommentVisible = false;
              isSerialTakeVissible = false;
            });
            _locationController.clear();
            _machineNameController.clear();
            _serialNumberController.clear();
          }
          if (state.serialSaveStatus == MachineSerialSaveStatus.success) {
            setState(() {
              isCommentVisible = false;
              isSerialTakeVissible = false;
            });
            _serialNumberController.clear();
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
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
                    color: Color.fromARGB(31, 78, 161, 110),
                    numberOfBubbles: 5,
                    maxBubbleSize: 90),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCommentVisible = false;
                      isSerialTakeVissible = false;
                    });
                  },
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
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                    ),
                                    Text(
                                      getFullName(),
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<MachineBloc>()
                                        .add(const ClearMachine());
                                    context
                                        .read<UserBloc>()
                                        .add(const LogoutUserEvent());
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          const Color.fromRGBO(1, 127, 97, 1),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color.fromRGBO(1, 127, 97, 1),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        'Bio Cleaner',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
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
                                            color:
                                                Colors.white.withOpacity(0.8),
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
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isCommentVisible = false;
                                          isSerialTakeVissible = true;
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
                                        child: const Icon(
                                          Icons.visibility_sharp,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        setAdd(true);
                                        setState(() {
                                          isCommentVisible = !isCommentVisible;
                                          isSerialTakeVissible = false;
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
                                        child: const Icon(
                                          Icons.add,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.52,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: context
                                  .read<MachineBloc>()
                                  .state
                                  .machines
                                  .length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  key: Key(random.nextInt(100000).toString()),
                                  background: Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue.withOpacity(0.7),
                                    ),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 20),
                                          Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  secondaryBackground: Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red.withOpacity(0.7),
                                    ),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onDismissed: (direction) {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      if (context
                                              .read<UserBloc>()
                                              .state
                                              .user!
                                              .id ==
                                          context
                                              .read<MachineBloc>()
                                              .state
                                              .machines[index]
                                              .userId) {
                                        context.read<MachineBloc>().add(
                                              MachineDeleteEvent(
                                                id: context
                                                    .read<MachineBloc>()
                                                    .state
                                                    .machines[index]
                                                    .id,
                                                token: context
                                                        .read<UserBloc>()
                                                        .state
                                                        .user!
                                                        .token ??
                                                    '',
                                              ),
                                            );
                                      } else {
                                        setState(() {
                                          isCommentVisible = false;
                                        });
                                        if (context
                                            .read<MachineBloc>()
                                            .state
                                            .serials
                                            .contains(context
                                                .read<MachineBloc>()
                                                .state
                                                .machines[index]
                                                .serialNumber)) {
                                          context.read<MachineBloc>().add(
                                              DeleteMachineSerialEvent(
                                                  id: context
                                                      .read<MachineBloc>()
                                                      .state
                                                      .machines[index]
                                                      .serialNumber));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Center(
                                                  child: Text(
                                                      'You can\'t delete this machine.')),
                                            ),
                                          );
                                        }
                                      }
                                    } else if (direction ==
                                        DismissDirection.startToEnd) {
                                      setAdd(false);
                                      if (context
                                              .read<UserBloc>()
                                              .state
                                              .user!
                                              .id ==
                                          context
                                              .read<MachineBloc>()
                                              .state
                                              .machines[index]
                                              .userId) {
                                        machineId = context
                                            .read<MachineBloc>()
                                            .state
                                            .machines[index]
                                            .id;
                                        _machineNameController.value =
                                            TextEditingValue(
                                                text: context
                                                    .read<MachineBloc>()
                                                    .state
                                                    .machines[index]
                                                    .name);
                                        _serialNumberController.value =
                                            TextEditingValue(
                                                text: context
                                                    .read<MachineBloc>()
                                                    .state
                                                    .machines[index]
                                                    .serialNumber);
                                        _locationController.value =
                                            TextEditingValue(
                                                text: context
                                                    .read<MachineBloc>()
                                                    .state
                                                    .machines[index]
                                                    .location);
                                        setState(() {
                                          isCommentVisible = true;
                                        });
                                      } else {
                                        setState(() {
                                          isCommentVisible = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Center(
                                                child: Text(
                                                    'You can\'t edit this machine.')),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return Detail(
                                              machine: context
                                                  .read<MachineBloc>()
                                                  .state
                                                  .machines[index],
                                            );
                                          },
                                        ));
                                      },
                                      title: Text(
                                        capitalize(context
                                            .read<MachineBloc>()
                                            .state
                                            .machines[index]
                                            .name),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'JosefinSans',
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromRGBO(116, 238, 209, 1),
                                        ),
                                      ),
                                      subtitle: Column(
                                        children: [
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on_outlined,
                                                size: 14,
                                                color: Color.fromRGBO(
                                                    1, 127, 97, 1),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                capitalize(context
                                                    .read<MachineBloc>()
                                                    .state
                                                    .machines[index]
                                                    .location),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'JosefinSans',
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      95, 196, 172, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 20,
                                        color: Color.fromRGBO(1, 127, 97, 1),
                                      ),
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
                ),
                if (isCommentVisible)
                  Positioned(
                    bottom: 0,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          SizedBox(
                            height: 55,
                            child: TextField(
                              controller: _machineNameController,
                              decoration: const InputDecoration(
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
                                  child: Icon(Icons.cleaning_services_outlined),
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
                              controller: _serialNumberController,
                              decoration: const InputDecoration(
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
                          SizedBox(
                            height: 55,
                            child: TextField(
                              controller: _locationController,
                              decoration: const InputDecoration(
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
                            onPressed: onAddMachine,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 55),
                              backgroundColor:
                                  const Color.fromRGBO(1, 127, 97, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text(add ? 'Add Now' : 'Update Now',
                                style: const TextStyle(
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
                if (isSerialTakeVissible)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
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
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setSerialTakeVissible();
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
                                      "Hey, add the serial number of bio cleaner you want to see.",
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
                          SizedBox(
                            height: 55,
                            child: TextField(
                              controller: _serialNumberController,
                              decoration: const InputDecoration(
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
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1),
                          ElevatedButton(
                            onPressed: onAddNewSerialMachine,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
