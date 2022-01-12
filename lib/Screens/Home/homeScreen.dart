import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_time_calculator/Compounent/Constants.dart';
import 'package:work_time_calculator/Cubit/Cubit.dart';
import 'package:work_time_calculator/Cubit/States.dart';

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
            backgroundColor: kBackGroundColor,
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
            // floatingActionButton: Container(
            //   decoration: BoxDecoration(
            //     color: Colors.blue,
            //     borderRadius: BorderRadius.circular(20.0),
            //   ),
            //   child: FittedBox(
            //     child: RawMaterialButton(
            //       onPressed: () {},
            //       shape: CircleBorder(),
            //       child: Row(
            //         children: [
            //           Text(
            //             'Add Manually',
            //             style: TextStyle(
            //               color: Colors.white,
            //             ),
            //           ),
            //           Icon(
            //             Icons.add_alarm,
            //             color: Colors.white,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ),
        );
      },
    );
  }
}
