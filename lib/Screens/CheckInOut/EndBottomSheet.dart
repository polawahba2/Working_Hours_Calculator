import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:work_time_calculator/Compounent/Constants.dart';
import 'package:work_time_calculator/Cubit/Cubit.dart';
import 'package:work_time_calculator/SharedPreferences/CashHelper.dart';

TextEditingController endTimeController = TextEditingController();

var endFormkey = GlobalKey<FormState>();
Widget myEndBottomSheet(context) {
  var size = MediaQuery.of(context).size;
  var myCubit = AppCubit.getCubit(context);
  return Container(
    color: kBackGroundColor,
    child: Form(
      key: endFormkey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(
                Icons.alarm,
                color: Colors.blue[900],
              ),
              labelText: 'End Time',
            ),
            controller: endTimeController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter valid time';
              }
              return null;
            },
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ).then((value) {
                endTimeController.text = value!.format(context).toString();
                print(value.format(context).toString());
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.red[900],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      myCubit.changeIsPressed(false);
                      myCubit.insertToDB(
                        startTimee: CashHelper.getData(key: 'startTime'),
                        endTimee: endTimeController.text,
                        datee: CashHelper.getData(key: 'startDate'),
                      );
                      endTimeController.text = '';
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.green[900],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
