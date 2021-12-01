import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_time_calculator/Constants/Constants.dart';
import 'package:work_time_calculator/Cubit/Cubit.dart';
import 'package:work_time_calculator/Cubit/States.dart';
import 'package:work_time_calculator/SharedPreferences/CashHelper.dart';

class CheckInOut extends StatelessWidget {
  var startTime = DateFormat.Hm().format(DateTime.now());
  var startDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
  var endTime = DateFormat.Hm().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocConsumer<AppCubit, states>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isPressed = CashHelper.getData(key: 'isPressed') ?? false;
        var myCubit = AppCubit.getCubit(context);
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (!isPressed)
                  Text(
                    'Welcome my Bro  '.toUpperCase(),
                    style: mainStyle(),
                  ),
                if (isPressed)
                  Text(
                    'Now, You Are Started Your Job ',
                    style: mainStyle(),
                  ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                if (isPressed)
                  Text(
                    'I Hope You Are Enjoying Your Time ',
                    style: mainStyle(),
                  ),
                SizedBox(
                  height: size.height * 0.18,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (isPressed == false) {
                      myCubit.changeIsPressed(true);
                      startTime = DateFormat.Hm().format(DateTime.now());
                      startDate =
                          DateFormat("dd/MM/yyyy").format(DateTime.now());
                      CashHelper.saveData(key: 'startTime', value: startTime);
                      CashHelper.saveData(key: 'startDate', value: startDate);
                    } else {
                      myCubit.changeIsPressed(false);
                      endTime = DateFormat.Hm().format(DateTime.now());

                      myCubit.insertToDB(
                        startTimee: CashHelper.getData(key: 'startTime'),
                        endTimee: endTime,
                        datee: CashHelper.getData(key: 'startDate'),
                        overTimee:
                            myCubit.calculateOverTimeInMin(startTime, endTime),
                      );
                      print(myCubit.times);
                    }
                  },
                  color: !isPressed ? Colors.blue : Colors.red[900],
                  splashColor: Colors.purple,
                  height: size.height * 0.14,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
