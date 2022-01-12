import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_time_calculator/Compounent/Constants.dart';
import 'package:work_time_calculator/Cubit/Cubit.dart';
import 'package:work_time_calculator/Cubit/States.dart';
import 'package:work_time_calculator/Screens/CheckInOut/BottomSheet.dart';
import 'package:work_time_calculator/Screens/CheckInOut/EndBottomSheet.dart';
import 'package:work_time_calculator/SharedPreferences/CashHelper.dart';

class CheckInOut extends StatelessWidget {
  var startTime = DateFormat('HH:mm').format(DateTime.now());
  var startDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
  var endTime = DateFormat.Hm().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, states>(
      listener: (context, state) {},
      builder: (context, state) {
        var size = MediaQuery.of(context).size;
        bool isPressed = CashHelper.getData(key: 'isPressed') ?? false;
        var myCubit = AppCubit.getCubit(context);
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (!isPressed)
                    Text(
                      'Welcome my Bro 😇'.toUpperCase(),
                      style: mainStyle(),
                    ),
                  if (isPressed)
                    Text(
                      'Now, You Are Started Your Job 🔥 ',
                      style: mainStyle(),
                    ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  if (isPressed)
                    Text(
                      'I Hope You Are Enjoying Your Time',
                      style: mainStyle(),
                    ),
                  if (isPressed)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        '🔥🔥💪',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (isPressed == false) {
                        myCubit.changeIsPressed(true);
                        startTime = DateFormat('h:mm a').format(DateTime.now());
                        startDate =
                            DateFormat("dd/MM/yyyy").format(DateTime.now());
                        CashHelper.saveData(key: 'startTime', value: startTime);
                        CashHelper.saveData(key: 'startDate', value: startDate);
                      } else {
                        myCubit.changeIsPressed(false);
                        endTime = DateFormat('h:mm a').format(DateTime.now());

                        myCubit.insertToDB(
                          startTimee: CashHelper.getData(key: 'startTime'),
                          endTimee: endTime,
                          datee: CashHelper.getData(key: 'startDate'),
                        );
                        print(myCubit.times);
                      }
                    },
                    color: !isPressed ? Colors.blue : Colors.red[900],
                    splashColor: Colors.purple,
                    height: size.height * 0.28,
                    child: Text(
                      !isPressed
                          ? 'start time '.toUpperCase()
                          : 'end time '.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    shape: CircleBorder(),
                  ),
                  TextButton(
                    onPressed: () {
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return !isPressed
                              ? myBottomSheet(context)
                              : myEndBottomSheet(context);
                        },
                      );
                    },
                    child: Text(
                      'Add Manually',
                      style: TextStyle(
                        fontSize: 17,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
