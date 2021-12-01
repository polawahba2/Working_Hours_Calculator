import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_time_calculator/Cubit/BlocObserver.dart';
import 'package:bloc/bloc.dart';
import 'package:work_time_calculator/Cubit/Cubit.dart';
import 'package:work_time_calculator/SharedPreferences/CashHelper.dart';
import 'Screens/Home/homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();

  BlocOverrides.runZoned(
    () {
      runApp(MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => AppCubit()..createDB(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}
