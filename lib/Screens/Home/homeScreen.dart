import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_time_calculator/Cubit/Cubit.dart';
import 'package:work_time_calculator/Cubit/States.dart';
import 'package:work_time_calculator/Screens/CheckInOut/CheckInOut.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, states>(
      listener: (context, state) {},
      builder: (context, state) {
        var myCubit = AppCubit.getCubit(context);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              title: Text(
                myCubit.appBarTitle[myCubit.appBarIndex],
              ),
              elevation: 10,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [Colors.blue, Colors.purple],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
              ),
              bottom: TabBar(
                indicatorColor: Colors.blue[200],
                onTap: (index) {
                  myCubit.changeTopBar(index);
                },
                tabs: const [
                  Tab(
                    icon: Icon(
                      Icons.timer,
                    ),
                    text: 'Start Time',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.history,
                    ),
                    text: 'Your History',
                  ),
                ],
              ),
            ),
            body: myCubit.screenBody[myCubit.appBarIndex],
          ),
        );
      },
    );
  }
}
