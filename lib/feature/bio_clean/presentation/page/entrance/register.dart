import 'package:bio_clean/feature/bio_clean/presentation/page/entrance/or.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user/user_bloc.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.onChange}) : super(key: key);

  final void Function(int) onChange;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void onSubmit() {
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final String phone = phoneController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text('Please fill all fields')),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text('Password not match')),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<UserBloc>().add(CreateUserEvent(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        password: password));
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.status == UserStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(child: Text('Account already exists or invalid')),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (state.status == UserStatus.success) {
          firstNameController.clear();
          lastNameController.clear();
          phoneController.clear();
          passwordController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(child: Text('Create account success')),
              backgroundColor: Colors.green,
            ),
          );
          widget.onChange(0);
        }
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            Image.asset('assets/logo.png', width: 200, height: 200),
            const Text(
              'BIO CLEAN',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromRGBO(1, 127, 97, 1),
                fontSize: 32,
                fontFamily: 'JosefinSans',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                 SizedBox(
                  height: 55,
                  child: TextField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      label: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          'First Name',
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
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(230, 230, 230, 1),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
               SizedBox(
                  height: 55,
                  child: TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      label: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          'Last Name',
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
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(230, 230, 230, 1),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 55,
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      label: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Phone',
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
                        child: Icon(
                          Icons.phone_outlined,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(230, 230, 230, 1),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(230, 230, 230, 1),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                 SizedBox(
                  height: 55,
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      label: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Password',
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
                        child: Icon(
                          Icons.lock_outlined,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(230, 230, 230, 1),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(230, 230, 230, 1),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                 SizedBox(
                  height: 55,
                  child: TextField(
                    controller: confirmPasswordController,
                    decoration: const InputDecoration(
                      label: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Confirm Password',
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
                        child: Icon(
                          Icons.lock_outlined,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(230, 230, 230, 1),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(230, 230, 230, 1),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    backgroundColor: const Color.fromRGBO(1, 127, 97, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text('Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'JosefinSans',
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                ),
                const SizedBox(height: 20),
                const OR(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Color.fromRGBO(31, 31, 31, 0.6),
                        fontSize: 14,
                        fontFamily: 'openSans',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.onChange(0);
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 69, 104),
                          fontSize: 14,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
