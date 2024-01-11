import 'package:bio_clean/feature/bio_clean/presentation/bloc/user/user_bloc.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.onChange}) : super(key: key);
  final void Function(int) onChange;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void _onLogin() {
    final String phone = phoneController.text;
    final String password = passwordController.text;

    if (phone.isEmpty || password.isEmpty) {
      return;
    }

    context
        .read<UserBloc>()
        .add(LoginUserEvent(phone: phone, password: password));
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(context.read<UserBloc>().state.user);
    print(context.read<UserBloc>().state.status);
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.status == UserStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid phone or password'),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (state.status == UserStatus.success) {
          phoneController.clear();
          passwordController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login success'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Home();
          }));
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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
                        child: Icon(Icons.phone_outlined),
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
                        child: Icon(Icons.lock_outlined),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(Icons.remove_red_eye_outlined),
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
                  onPressed: _onLogin,
                  style: ElevatedButton.styleFrom(
                    animationDuration: const Duration(milliseconds: 400),
                    minimumSize: const Size(double.infinity, 55),
                    backgroundColor: const Color.fromRGBO(1, 127, 97, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text('Sign In',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'JosefinSans',
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        color: Color.fromRGBO(31, 31, 31, 1),
                        fontSize: 14,
                        fontFamily: 'openSans',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.onChange(1);
                      },
                      child: const Text(
                        'Sing Up',
                        style: TextStyle(
                          color: Color.fromRGBO(1, 127, 97, 1),
                          fontSize: 14,
                          fontFamily: 'openSans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
