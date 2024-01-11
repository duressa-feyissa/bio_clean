import 'package:bio_clean/feature/bio_clean/presentation/bloc/user/user_bloc.dart';
import 'package:bio_clean/feature/bio_clean/presentation/page/onboarding/layout.dart';
import 'package:bio_clean/injection_container.dart';
import 'package:bio_clean/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;

void main() async {
  Bloc.observer = const SimpleBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(
    BlocProvider(
      create: (context) => sl<UserBloc>(),
      child: const MaterialApp(
        home: OnboardingLayout(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
